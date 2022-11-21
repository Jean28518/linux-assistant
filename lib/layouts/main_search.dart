import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:linux_assistant/content/top_level_domains.dart';
import 'package:linux_assistant/enums/browsers.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/layouts/action_entry_card.dart';
import 'package:linux_assistant/layouts/disk_space.dart';
import 'package:linux_assistant/layouts/feedback/feedback_form.dart';
import 'package:linux_assistant/layouts/memory_status.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/recommendation_card.dart';
import 'package:linux_assistant/main.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/action_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainSearch extends StatefulWidget {
  late List<ActionEntry> actionEntries;

  MainSearch({Key? key, required this.actionEntries}) : super(key: key);

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

  _MainSearchState({required this.actionEntries}) {
    initHotkeysForKeyboardUse();
  }

  @override
  Widget build(BuildContext context) {
    // Complete height of a search entry is 64 + 8 (padding)
    visibleEntries =
        ((MediaQuery.of(context).size.height - 40 - 70) / 72).round();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _foundEntries.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DiskSpace(),
                            SizedBox(width: 16),
                            MemoryStatus(),
                          ],
                        )
                      : Container(),
                  _foundEntries.isEmpty
                      ? SizedBox(
                          height: 16,
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width > 750
                            ? 600
                            : MediaQuery.of(context).size.width - 50,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: _foundEntries.isEmpty
                                ? null
                                : const EdgeInsets.only(
                                    bottom: -20.0, left: 12, right: 3),
                            border: const OutlineInputBorder(),
                            hintText:
                                AppLocalizations.of(context)!.enterASearchTerm,
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
                          style: MintY.paragraph,
                          controller: searchBarController,
                          autofocus: true,
                          onChanged: (value) => _runFilter(value),
                          onSubmitted: (value) {
                            if (_foundEntries.length > 0) {
                              ActionHandler.handleActionEntry(
                                  _foundEntries[selectedIndex], clear, context);
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
                              icon: const Icon(
                                Icons.feedback,
                                color: Colors.black45,
                              ),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => FeedbackDialog(
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
                      ? SizedBox(
                          height: 50,
                        )
                      : SizedBox(
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
                        )
                ],
              )),
            ),
          ),
          _foundEntries.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecommendationCard(),
                )
              : Container(),
        ],
      ),
    );
  }

  void clear({minimze = true}) {
    if (minimze) {
      windowManager.minimize();
    }
    _lastKeyword = "";
    searchBarController.clear();
    selectedIndex = 0;
    selectedIndexInView = 0;
    _runFilter("");
  }

  void _runFilter(String keyword) {
    // Heavy search
    const duration = Duration(milliseconds: 800);
    searchOnStoppedTyping?.cancel();
    searchOnStoppedTyping = Timer(duration, () => _runHeavyFilter(keyword));

    _lastKeyword = keyword;
    keyword = keyword.toLowerCase();
    List<String> keys = keyword.split(" ");
    List<ActionEntry> results = [];
    if (keyword.isEmpty) {
      results = [];
    } else {
      results = actionEntries.where((actionEntry) {
        for (String key in keys) {
          if (actionEntry.name.toLowerCase().contains(key) ||
              actionEntry.description.toLowerCase().contains(key)) {
            return true;
          }
        }
        return false;
      }).toList();
    }

    bool uri_recognized = false;

    if (Uri.parse(keyword).isAbsolute || keyword.contains("www.")) {
      uri_recognized = true;
    } else if (keyword.contains(".") && !keyword.endsWith(".")) {
      String keysplit = keyword.split(".").last.toUpperCase();
      for (String top_level_domain in topLevelDomains) {
        if (top_level_domain == keysplit) {
          uri_recognized = true;
          break;
        }
      }
    }

    if (uri_recognized) {
      ActionEntry actionEntry = ActionEntry(
          name: "${AppLocalizations.of(context)!.openX} $keyword",
          description: "Open with default webbrowser",
          action: "openwebsite:" + keyword);
      actionEntry.priority = 10;
      results.add(actionEntry);
    }

    if (keyword != "" && Linux.currentenvironment.browser == BROWSERS.FIREFOX) {
      results.add(ActionEntry(
          name: "${AppLocalizations.of(context)!.searchInWebFor} $keyword",
          description: AppLocalizations.of(context)!.lookForOnlineResults,
          action: "websearch:" + keyword));
      results.last.priority = -50;
    }

    if (selectedIndex >= results.length) {
      selectedIndex = results.length - 1;
    } else if (results.length > 0 && selectedIndex == -1) {
      selectedIndex = 0;
      selectedIndexInView = 0;
    }

    // Sort:
    _foundEntries = results;
    _sortFoundEntries();

    setState(() {});
  }

  /// This filter is only runs, if the user has stopped typing.
  void _runHeavyFilter(String keyword) async {
    if (keyword.trim() == "") {
      return;
    }

    List<ActionEntry> heavyEntries = [];

    // Search through apt
    if (Linux.currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.APT)) {
      List<ActionEntry> pckgs =
          await Linux.getInstallableAptPackagesForKeyword(keyword);

      heavyEntries.addAll(pckgs);
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
  }
}
