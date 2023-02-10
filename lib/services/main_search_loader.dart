import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:linux_assistant/content/basic_entries.dart';
import 'package:linux_assistant/content/recommendations.dart';
import 'package:linux_assistant/layouts/main_screen/main_search.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/action_entry_list.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

class MainSearchLoader extends StatefulWidget {
  const MainSearchLoader({Key? key}) : super(key: key);

  @override
  State<MainSearchLoader> createState() => _MainSearchLoaderState();
}

class _MainSearchLoaderState extends State<MainSearchLoader> {
  late Future<ActionEntryList> futureActionEntryList;

  Future<ActionEntryList> prepare() async {
    MainSearch.unregisterHotkeysForKeyboardUse();
    const Duration timeoutDuration = Duration(seconds: 5);

    ConfigHandler configHandler = ConfigHandler();
    Future clearOldEntries = configHandler.clearOldDatesOfOpenendEntries();

    // prepare Action Entries
    ActionEntryList returnValue = ActionEntryList(entries: []);
    returnValue.entries.addAll(getRecommendations(context));
    returnValue.entries.addAll(getBasicEntries(context));
    var folderEntries = await Linux.getAllFolderEntriesOfUser(context).timeout(
        timeoutDuration,
        onTimeout: () => _onTimeoutOfSearchLoadingModule("folderEntries"));
    returnValue.entries.addAll(folderEntries);
    var applicationEntries = await Linux.getAllAvailableApplications().timeout(
        timeoutDuration,
        onTimeout: () => _onTimeoutOfSearchLoadingModule("applicationEntries"));
    returnValue.entries.addAll(applicationEntries);
    var recentFiles = await Linux.getRecentFiles(context).timeout(
        timeoutDuration,
        onTimeout: () => _onTimeoutOfSearchLoadingModule("recentFiles"));
    returnValue.entries.addAll(recentFiles);
    var favoriteFiles = await Linux.getFavoriteFiles(context).timeout(
        timeoutDuration,
        onTimeout: () => _onTimeoutOfSearchLoadingModule("favoriteFiles"));
    returnValue.entries.addAll(favoriteFiles);
    var browserBookmarks = await Linux.getBrowserBookmarks(context).timeout(
        timeoutDuration,
        onTimeout: () => _onTimeoutOfSearchLoadingModule("browserBookmarks"));
    returnValue.entries.addAll(browserBookmarks);

    var additionalFolders =
        Linux.getFoldersOfActionEntries(context, returnValue.entries);
    returnValue.entries.addAll(additionalFolders);

    await configHandler.setValue("runFirstStartUp", false);
    await clearOldEntries;

    return returnValue;
  }

  List<ActionEntry> _onTimeoutOfSearchLoadingModule(String module) {
    Logger().w(
        "Timeout of loading $module! Please report this to the developers on https://www.linux-assistant.org.");
    return [];
  }

  @override
  Widget build(BuildContext context) {
    futureActionEntryList = prepare();
    return FutureBuilder<dynamic>(
      future: futureActionEntryList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (MainSearch(actionEntries: snapshot.data!.entries));
        } else {
          return MintYLoadingPage(
              text: AppLocalizations.of(context)!.preparingSearch);
        }
      },
    );
  }
}
