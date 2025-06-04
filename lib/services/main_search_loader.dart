import 'package:flutter/material.dart';
import 'package:linux_assistant/content/basic_entries.dart';
import 'package:linux_assistant/content/recommendations.dart';
import 'package:linux_assistant/layouts/main_screen/main_search.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/action_entry_list.dart';
import 'package:linux_assistant/services/action_entry_list_service.dart';
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
    await configHandler.ensureConfigIsLoaded();
    Future clearOldEntries = configHandler.clearOldDatesOfOpenendEntries();

    // prepare Action Entries

    // List<Future<List<ActionEntry>>> futures = [];

    // if (configHandler.getValueUnsafe("search_filter_basic_folders", true)) {
    //   print("Loading basic folders");
    //   futures.add(Linux.getAllFolderEntriesOfUser(context).timeout(
    //       timeoutDuration,
    //       onTimeout: () =>
    //           _onTimeoutOfSearchLoadingModule("applicationEntries")));
    //   // future1 = Linux.getAllFolderEntriesOfUser(context);
    // }

    ActionEntryListService.clearEntries();

    Linux.getAllFolderEntriesOfUser(context);

    // if (configHandler.getValueUnsafe("search_filter_applications", true)) {
    //   print("Loading applications");
    //   futures.add(Linux.getAllAvailableApplications().timeout(timeoutDuration,
    //       onTimeout: () =>
    //           _onTimeoutOfSearchLoadingModule("applicationEntries")));
    // }

    Linux.getAllAvailableApplications();

    // if (configHandler.getValueUnsafe(
    //     "search_filter_recently_used_files_and_folders", true)) {
    //   print("Loading recently used files and folders");
    //   futures.add(Linux.getRecentFiles(context).timeout(timeoutDuration,
    //       onTimeout: () => _onTimeoutOfSearchLoadingModule("recentFiles")));
    // }
    Linux.getRecentFiles(context);

    // if (configHandler.getValueUnsafe(
    //     "search_filter_favorite_files_and_folder_bookmarks", true)) {
    //   print("Loading favorite files and folder bookmarks");
    //   futures.add(Linux.getFavoriteFiles(context).timeout(timeoutDuration,
    //       onTimeout: () => _onTimeoutOfSearchLoadingModule("favoriteFiles")));
    // }
    Linux.getFavoriteFiles(context);

    // if (configHandler.getValueUnsafe("search_filter_bookmarks", true)) {
    //   print("Loading browser bookmarks");
    //   futures.add(Linux.getBrowserBookmarks(context).timeout(timeoutDuration,
    //       onTimeout: () =>
    //           _onTimeoutOfSearchLoadingModule("browserBookmarks")));
    // }

    Linux.getBrowserBookmarks(context);

    // Deinstallation Entries.
    // if (configHandler.getValueUnsafe(
    //     "search_filter_uninstall_software", true)) {
    //   print("Loading uninstall entries");
    //   futures.add(Linux.getUninstallEntries(context).timeout(timeoutDuration,
    //       onTimeout: () =>
    //           _onTimeoutOfSearchLoadingModule("uninstall_entries")));
    // }
    Linux.getUninstallEntries(context);

    ActionEntryList returnValue = ActionEntryList(entries: []);
    returnValue.entries.addAll(getRecommendations(context));
    returnValue.entries.addAll(getBasicEntries(context));

    // // Collect all Futures in our returnValue.
    // for (Future<List<ActionEntry>> future in futures) {
    //   returnValue.entries.addAll(await future);
    // }

    if (configHandler.getValueUnsafe(
        "search_filter_recently_used_files_and_folders", true)) {
      print("Loading recently used files and folders");
      var additionalFolders =
          Linux.getFoldersOfActionEntries(context, returnValue.entries);
      print("Finished: search_filter_recently_used_files_and_folders");
      returnValue.entries.addAll(additionalFolders);
    }

    // Remove action entries for specific environments
    print("Removing disabled entries");
    List<ActionEntry> entriesToRemove = [];
    for (ActionEntry entry in returnValue.entries) {
      if (entry.disableEntryIf != null) {
        // If the disableEntryIf function of the entry gets true, remove:
        if (entry.disableEntryIf!()) {
          entriesToRemove.add(entry);
        }
      }
    }
    for (ActionEntry entry in entriesToRemove) {
      returnValue.entries.remove(entry);
    }
    print("Initiating configHandler");
    await configHandler.setValue("runFirstStartUp", false);
    await clearOldEntries;

    // EntryCache.saveEntries(returnValue.entries);

    // returnValue = EntryCache.loadEntries();

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
          return (MainSearch());
        } else {
          return MintYLoadingPage(
              text: AppLocalizations.of(context)!.preparingSearch);
        }
      },
    );
  }

  // void prepareActionEntryList() async {

  // }
}
