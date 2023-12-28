import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:linux_assistant/content/top_level_domains.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/layouts/feature_overview/feature_overview.dart';
import 'package:linux_assistant/layouts/greeter/introduction.dart';
import 'package:linux_assistant/layouts/main_screen/action_entry_card.dart';
import 'package:linux_assistant/widgets/disk_space.dart';
import 'package:linux_assistant/layouts/feedback/feedback_form.dart';
import 'package:linux_assistant/layouts/settings/settings_start.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/widgets/memory_status.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/main_screen/recommendation_card.dart';
import 'package:linux_assistant/main.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/action_handler.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainSearch extends StatefulWidget {
  late List<ActionEntry> actionEntries;
  late bool colorfulBackground;

  MainSearch({Key? key, required this.actionEntries}) {
    ConfigHandler configHandler = ConfigHandler();
    colorfulBackground =
        configHandler.getValueUnsafe("colorfulBackground", true);
  }

  @override
  State<MainSearch> createState() =>
      _MainSearchState(actionEntries: actionEntries);

  static void unregisterHotkeysForKeyboardUse() {
    hotKeyManager.unregisterAll();
    MyApp.initHotkeyToShowUp();
  }
}

class _MainSearchState extends State<MainSearch> {
  late List<ActionEntry> actionEntries;

  String _lastKeyword = "";

  List<ActionEntry> _foundEntries = [];

  var selectedIndex = 0;
  var selectedIndexInView = 0;

  /// Only describes the technical possible amount of visible entries depending
  /// at the screen size
  late int visibleEntries;

  final searchBarController = TextEditingController();
  final scrollController = ScrollController();

  Timer? searchOnStoppedTyping;
  Timer? suggestionTimer;

  ActionEntry? suggestion;

  _MainSearchState({required this.actionEntries}) {
    initHotkeysForKeyboardUse();
  }

  @override
  Widget build(BuildContext context) {
    suggestionTimer ??= Timer.periodic(
        const Duration(seconds: 5), ((timer) => _handleSuggestions()));

    // Complete height of a search entry is 64 + 8 (padding)
    visibleEntries =
        ((MediaQuery.of(context).size.height - 40 - 70) / 72).round();
    return Scaffold(
      body: Container(
        decoration: widget.colorfulBackground ? MintY.colorfulBackground : null,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _foundEntries.isEmpty
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 16),
                              DiskSpace(),
                              SizedBox(width: 16),
                              SystemStatus(),
                            ],
                          )
                        : Container(),
                    _foundEntries.isEmpty
                        ? const SizedBox(
                            height: 16,
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width > 750
                              ? 600
                              : MediaQuery.of(context).size.width - 50,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).canvasColor,
                              filled: true,
                              // border: const OutlineInputBorder(
                              //     borderSide: BorderSide(color: Colors.white)),
                              contentPadding: _foundEntries.isEmpty
                                  ? null
                                  : const EdgeInsets.only(
                                      bottom: -20.0, left: 12, right: 3),
                              hintText: suggestion != null
                                  ? suggestion!.name
                                  : AppLocalizations.of(context)!
                                      .enterASearchTerm,
                              prefixIcon: _foundEntries.isEmpty
                                  ? const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    )
                                  : null,
                              suffix: _foundEntries.isEmpty
                                  ? null
                                  : IconButton(
                                      iconSize: 14,
                                      splashRadius: 14,
                                      icon: const Icon(Icons.clear),
                                      onPressed: () => clear(minimze: false),
                                      padding: EdgeInsets.zero,
                                      tooltip:
                                          AppLocalizations.of(context)!.clear,
                                    ),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium,
                            cursorColor: MintY.currentColor,
                            controller: searchBarController,
                            autofocus: true,
                            onChanged: (value) => _runFilter(value),
                            onSubmitted: (value) {
                              if (_foundEntries.isNotEmpty) {
                                ActionHandler.handleActionEntry(
                                    _foundEntries[selectedIndex],
                                    clear,
                                    context);
                              } else if (suggestion != null) {
                                ActionHandler.handleActionEntry(
                                    suggestion!, clear, context);
                              }
                            },
                          ),
                        ),
                        _foundEntries.isEmpty
                            ? Container()
                            : const SizedBox(
                                width: 10,
                              ),
                        _foundEntries.isEmpty
                            ? Container()
                            : IconButton(
                                iconSize: 24,
                                splashRadius: 24,
                                icon: Icon(
                                  Icons.feedback,
                                  color: widget.colorfulBackground
                                      ? Colors.white
                                      : Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color,
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => FeedbackDialog(
                                      calledFromHome: false,
                                      foundEntries: _foundEntries,
                                      searchText: _lastKeyword),
                                ),
                                padding: EdgeInsets.zero,
                                tooltip:
                                    AppLocalizations.of(context)!.sendFeedback,
                              ),
                      ],
                    ),
                    _foundEntries.isEmpty
                        ? const SizedBox(
                            height: 50,
                          )
                        : const SizedBox(
                            height: 10,
                          ),
                    _foundEntries.isEmpty
                        ? Container()
                        : Expanded(
                            child: ListView(
                              controller: scrollController,
                              children: List.generate(
                                  _foundEntries.length,
                                  (index) => ActionEntryCard(
                                      actionEntry: _foundEntries[index],
                                      callback: clear,
                                      selected: selectedIndex == index)),
                            ),
                          ),
                  ],
                )),
              ),
            ),

            /// Bottom Bar
            _foundEntries.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Left Bottom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(),
                        ],
                      ),
                      // Recommendation Card
                      Expanded(child: Container()),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RecommendationCard(),
                      ),
                      // Right Bottom
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Reload Button at start page
                            ReloadSearchButton(widget: widget),

                            // Help Button at start page
                            HelpButton(widget: widget),

                            IconButton(
                              onPressed: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const FeatureOverview(),
                                ))
                              },
                              icon: Icon(
                                Icons.apps,
                                color: widget.colorfulBackground
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                              ),
                              tooltip:
                                  AppLocalizations.of(context)!.featureOverview,
                            ),

                            // Settings Button:
                            IconButton(
                              iconSize: 24,
                              splashRadius: 24,
                              icon: Icon(
                                Icons.settings,
                                color: widget.colorfulBackground
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                              ),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => const SettingsStart(),
                              ),
                              padding: EdgeInsets.zero,
                              tooltip: AppLocalizations.of(context)!.settings,
                            ),
                            // Feedback Button at start page
                            FeedbackButton(
                                widget: widget,
                                foundEntries: _foundEntries,
                                lastKeyword: _lastKeyword),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void clear({minimze = true}) {
    if (minimze) {
      /// On wayland sessions we currently can't issue 'wmctrl -a'
      /// So if we want to get the hotkey working we need to close the app after
      /// a single use. Because otherwise everytime the user presses the hotkey
      /// an additional window would open.
      /// On x11 sessions we don't have the issue.
      if (Linux.currentenvironment.wayland) {
        windowManager.minimize();
        Future.delayed(const Duration(seconds: 5), () => exit(0));
      } else {
        windowManager.minimize();
      }
    }
    _lastKeyword = "";
    searchBarController.clear();
    selectedIndex = 0;
    selectedIndexInView = 0;
    _runFilter("");
  }

  bool isRegex(String pattern) {
    try {
      RegExp(pattern);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _runFilter(String keyword) {
    // Heavy search
    const duration = Duration(milliseconds: 800);
    searchOnStoppedTyping?.cancel();
    searchOnStoppedTyping = Timer(duration, () => _runHeavyFilter(keyword));

    RegExp? regExp;
    if (isRegex(keyword)) {
      regExp = RegExp(keyword, caseSensitive: false);
    } else {
      // Replace all *. with that e.g. *.filetype is recognized as a file ending
      keyword = keyword.replaceAll("*.", ".");
    }

    _lastKeyword = keyword;
    keyword = keyword.toLowerCase();
    List<String> keys = keyword.split(" ");
    List<ActionEntry> results = [];
    if (keyword.isEmpty) {
      results = [];
    } else {
      results = actionEntries.where((actionEntry) {
        // If regualar expression is used and matches return true
        if (regExp != null &&
            (regExp.hasMatch(actionEntry.name) ||
                regExp.hasMatch(actionEntry.description))) {
          return true;
        }
        // Otherwise check if all keys are contained in name or description
        for (String key in keys) {
          if (actionEntry.name.toLowerCase().contains(key) ||
              actionEntry.description.toLowerCase().contains(key)) {
            return true;
          }
        }
        return false;
      }).toList();
    }

    bool uriRecognized = false;

    if (Uri.parse(keyword).isAbsolute || keyword.contains("www.")) {
      uriRecognized = true;
    } else if (keyword.contains(".") && !keyword.endsWith(".")) {
      String keysplit = keyword.split(".").last.toUpperCase();
      for (String topLevelDomain in topLevelDomains) {
        if (topLevelDomain == keysplit) {
          uriRecognized = true;
          break;
        }
      }
    }

    if (uriRecognized) {
      ActionEntry actionEntry = ActionEntry(
          name: "${AppLocalizations.of(context)!.openX} $keyword",
          description: "Open with default webbrowser",
          action: "openwebsite:$keyword");
      actionEntry.priority = 10;
      results.add(actionEntry);
    }

    if (keyword != "") {
      results.add(ActionEntry(
          name: "${AppLocalizations.of(context)!.searchInWebFor} $keyword",
          description: AppLocalizations.of(context)!.lookForOnlineResults,
          action: "websearch:$keyword"));
      results.last.priority = -50;
    }

    if (selectedIndex >= results.length) {
      selectedIndex = results.length - 1;
    } else if (results.isNotEmpty && selectedIndex == -1) {
      selectedIndex = 0;
      selectedIndexInView = 0;
    }

    // Sort:
    _foundEntries = results;
    _sortFoundEntries();
    _removeDuplicatedEntries();

    setState(() {});
  }

  /// This runs fast but only removes direct neighbours.
  void _removeDuplicatedEntries() {
    for (int i = 0; i < _foundEntries.length - 1; i++) {
      if (_foundEntries[i].action == _foundEntries[i + 1].action) {
        _foundEntries.removeAt(i);
      }
    }
  }

  /// This filter is only runs, if the user has stopped typing.
  void _runHeavyFilter(String keyword) async {
    if (keyword.trim() == "" || _lastKeyword == "") {
      return;
    }

    List<ActionEntry> heavyEntries = [];

    // Search through apt
    if (Linux.currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.APT)) {
      List<ActionEntry> pckgs =
          await Linux.getInstallableAptPackagesForKeyword(context, keyword);
      heavyEntries.addAll(pckgs);
    }
    // Search through zypper
    else if (Linux.currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.ZYPPER)) {
      List<ActionEntry> pckgs =
          await Linux.getInstallableZypperPackagesForKeyword(keyword);
      heavyEntries.addAll(pckgs);
    }
    // Search through dnf
    else if (Linux.currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.DNF)) {
      List<ActionEntry> pckgs =
          await Linux.getInstallableDNFPackagesForKeyword(keyword);
      heavyEntries.addAll(pckgs);
    }

    if (Linux.currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.SNAP)) {
      List<ActionEntry> snaps =
          await Linux.getInstallableSnapPackagesForKeyword(keyword);
      heavyEntries.addAll(snaps);
    }

    // If in the meantime the user cleared the search bar, we don't want to
    // show the results.
    if (keyword.trim() == "" || _lastKeyword == "") {
      return;
    }

    setState(() {
      _foundEntries.addAll(heavyEntries);
      _sortFoundEntries();
    });
  }

  void _sortFoundEntries() {
    List<String> keys = _lastKeyword.toLowerCase().split(" ");

    for (ActionEntry result in _foundEntries) {
      result.tmpPriority = 0;
      for (String key in keys) {
        if (key.trim() == "") {
          continue;
        }
        if (result.name.toLowerCase().contains(key)) {
          result.tmpPriority += 10;
          if (result.name.toLowerCase().startsWith(key)) {
            result.tmpPriority += 20;
          }
        }
        if (result.description.toLowerCase().contains(_lastKeyword)) {
          result.tmpPriority += 5;
        }
      }
      if (_lastKeyword == result.name) {
        result.tmpPriority += 20;
      }
    }
    if (ConfigHandler().getValueUnsafe("self_learning_search", true)) {
      for (var element in _foundEntries) {
        String datesString =
            ConfigHandler().getValueUnsafe("opened.${element.action}", "");

        /// length of an date entry is 11: "1970-01-01;".length = 11
        int openTimes = (datesString.length / 11.0).round();
        element.tmpPriority += openTimes * 2;
      }
    }

    _foundEntries.sort((a, b) => (a.name).compareTo(b.name));

    _foundEntries.sort((a, b) =>
        (b.priority + b.tmpPriority).compareTo(a.priority + a.tmpPriority));
  }

  void initHotkeysForKeyboardUse() {
    HotKey down = HotKey(
      KeyCode.arrowDown,
      scope: HotKeyScope.inapp,
    );
    hotKeyManager.register(
      down,
      keyDownHandler: (hotKey) {
        if (selectedIndex + 1 < _foundEntries.length) {
          setState(() {
            selectedIndex += 1;
            selectedIndexInView += 1;
            if (selectedIndexInView >= visibleEntries) {
              scrollController.jumpTo(scrollController.offset + 72);
              selectedIndexInView -= 1;
            }
          });
        }
      },
    );

    HotKey up = HotKey(
      KeyCode.arrowUp,
      scope: HotKeyScope.inapp,
    );
    hotKeyManager.register(
      up,
      keyDownHandler: (hotKey) {
        if (selectedIndex - 1 >= 0) {
          setState(() {
            selectedIndex -= 1;
            selectedIndexInView -= 1;
            if (selectedIndexInView < 0) {
              scrollController.jumpTo(scrollController.offset - 72);
              selectedIndexInView += 1;
            }
          });
        }
      },
    );

    HotKey escape = HotKey(
      KeyCode.escape,
      scope: HotKeyScope.inapp,
    );
    hotKeyManager.register(
      escape,
      keyDownHandler: (hotKey) {
        clear(minimze: false);
      },
    );

    // Debug Call
    HotKey hotKeyDebug = HotKey(
      KeyCode.keyD,
      modifiers: [KeyModifier.control],
      scope: HotKeyScope.inapp,
    );
    hotKeyManager.register(
      hotKeyDebug,
      keyDownHandler: (hotKey) async {
        print("DEBUG");
        // insert here function calls to debug
        // Linux.getInstalledFlatpaks();
        // Linux.getInstalledSnaps();
        // Linux.getInstalledAPTPackages();
      },
    );
  }

  void _handleSuggestions() {
    // If the main search window is present and the user has not typed anything
    if (_foundEntries.isEmpty) {
      int random = 0;
      while (true) {
        random = Random().nextInt(widget.actionEntries.length - 1);
        if (!widget.actionEntries[random].excludeFromSearchProposal) {
          break;
        }
      }
      setState(() {
        suggestion = actionEntries[random];
      });
    }
  }
}

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({
    super.key,
    required this.widget,
    required List<ActionEntry> foundEntries,
    required String lastKeyword,
  })  : _foundEntries = foundEntries,
        _lastKeyword = lastKeyword;

  final MainSearch widget;
  final List<ActionEntry> _foundEntries;
  final String _lastKeyword;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 24,
      splashRadius: 24,
      icon: Icon(
        Icons.feedback,
        color: widget.colorfulBackground
            ? Colors.white
            : Theme.of(context).textTheme.displayLarge!.color,
      ),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => FeedbackDialog(
            calledFromHome: true,
            foundEntries: _foundEntries,
            searchText: _lastKeyword),
      ),
      padding: EdgeInsets.zero,
      tooltip: AppLocalizations.of(context)!.sendFeedback,
    );
  }
}

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
    required this.widget,
  });

  final MainSearch widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 24,
      splashRadius: 24,
      icon: Icon(
        Icons.help,
        color: widget.colorfulBackground
            ? Colors.white
            : Theme.of(context).textTheme.displayLarge!.color,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const GreeterIntroduction(forceOpen: true)),
        );
      },
      padding: EdgeInsets.zero,
      tooltip: AppLocalizations.of(context)!.introduction,
    );
  }
}

class ReloadSearchButton extends StatelessWidget {
  const ReloadSearchButton({
    super.key,
    required this.widget,
  });

  final MainSearch widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 24,
      splashRadius: 24,
      icon: Icon(
        Icons.autorenew,
        color: widget.colorfulBackground
            ? Colors.white
            : Theme.of(context).textTheme.displayLarge!.color,
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainSearchLoader(),
            ));
      },
      padding: EdgeInsets.zero,
      tooltip: AppLocalizations.of(context)!.reload,
    );
  }
}
