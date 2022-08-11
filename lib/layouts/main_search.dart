import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:linux_helper/enums/browsers.dart';
import 'package:linux_helper/layouts/action_entry_card.dart';
import 'package:linux_helper/layouts/disk_space.dart';
import 'package:linux_helper/layouts/memory_status.dart';
import 'package:linux_helper/layouts/recommendation_card.dart';
import 'package:linux_helper/main.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/services/action_handler.dart';
import 'package:linux_helper/services/linux.dart';
import 'package:window_manager/window_manager.dart';

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

  var selectedIndex = 1;

  final searchBarController = TextEditingController();
  final scrollController = ScrollController();

  _MainSearchState({required this.actionEntries}) {
    initHotkeysForKeyboardUse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _foundEntries.length == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DiskSpace(),
                      SizedBox(width: 10),
                      MemoryStatus(),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter a search term..."),
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
            _foundEntries.length == 0
                ? RecommendationCard()
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
    );
  }

  void clear({minimze = true}) {
    if (minimze) {
      windowManager.minimize();
    }
    _lastKeyword = "";
    searchBarController.clear();
    selectedIndex = 0;
    _runFilter("");
  }

  void _runFilter(String keyword, {bool runSetState = true}) {
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

    if (Uri.parse(keyword).isAbsolute) {
      ActionEntry actionEntry = ActionEntry("Open " + keyword,
          "Open default webbrowser", "openwebsite:" + keyword);
      actionEntry.priority = 10;
      results.add(actionEntry);
    }

    if (keyword != "" && Linux.currentEnviroment.browser == BROWSERS.FIREFOX) {
      results.add(ActionEntry("Search in web for " + keyword,
          "look for online results..", "websearch:" + keyword));
      results.last.priority = -50;
    }

    for (ActionEntry result in results) {
      result.tmp_priority = 0;
      for (String key in keys) {
        if (result.name.toLowerCase().contains(key)) {
          result.tmp_priority += 10;
          if (result.name.toLowerCase().startsWith(key)) {
            result.tmp_priority += 10;
          }
        }
        if (result.description.toLowerCase().contains(keyword)) {
          result.tmp_priority += 5;
        }
      }
    }

    if (selectedIndex >= results.length) {
      selectedIndex = results.length - 1;
    } else if (results.length > 0 && selectedIndex == -1) {
      selectedIndex = 0;
    }

    // Sort:
    results.sort((a, b) => (a.name).compareTo(b.name));

    results.sort((a, b) =>
        (b.priority + b.tmp_priority).compareTo(a.priority + a.tmp_priority));

    _foundEntries = results;

    if (runSetState) {
      setState(() {});
    }
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
            if (_foundEntries.length > 10) {
              scrollController.jumpTo(scrollController.offset + 70);
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
            if (_foundEntries.length > 10) {
              scrollController.jumpTo(scrollController.offset - 70);
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
