import 'package:flutter/material.dart';
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
    await configHandler.ensureConfigIsLoaded();
    Future clearOldEntries = configHandler.clearOldDatesOfOpenendEntries();

    // prepare Action Entries
    ActionEntryList returnValue = ActionEntryList(entries: []);
    returnValue.entries.addAll(getRecommendations(context));
    returnValue.entries.addAll(getBasicEntries(context));

    if (configHandler.getValueUnsafe("search_filter_basic_folders", true)) {
      var folderEntries = await Linux.getAllFolderEntriesOfUser(context)
          .timeout(
              timeoutDuration,
              onTimeout: () =>
                  _onTimeoutOfSearchLoadingModule("folderEntries"));
      returnValue.entries.addAll(folderEntries);
    }
    if (configHandler.getValueUnsafe("search_filter_applications", true)) {
      var applicationEntries = await Linux.getAllAvailableApplications()
          .timeout(timeoutDuration,
              onTimeout: () =>
                  _onTimeoutOfSearchLoadingModule("applicationEntries"));
      returnValue.entries.addAll(applicationEntries);
    }

    if (configHandler.getValueUnsafe(
        "search_filter_recently_used_files_and_folders", true)) {
      var recentFiles = await Linux.getRecentFiles(context).timeout(
          timeoutDuration,
          onTimeout: () => _onTimeoutOfSearchLoadingModule("recentFiles"));
      returnValue.entries.addAll(recentFiles);
    }

    if (configHandler.getValueUnsafe(
        "search_filter_favorite_files_and_folder_bookmarks", true)) {
      var favoriteFiles = await Linux.getFavoriteFiles(context).timeout(
          timeoutDuration,
          onTimeout: () => _onTimeoutOfSearchLoadingModule("favoriteFiles"));
      returnValue.entries.addAll(favoriteFiles);
    }

    if (configHandler.getValueUnsafe("search_filter_bookmarks", true)) {
      var browserBookmarks = await Linux.getBrowserBookmarks(context).timeout(
          timeoutDuration,
          onTimeout: () => _onTimeoutOfSearchLoadingModule("browserBookmarks"));
      returnValue.entries.addAll(browserBookmarks);
    }

    if (configHandler.getValueUnsafe(
        "search_filter_recently_used_files_and_folders", true)) {
      var additionalFolders =
          Linux.getFoldersOfActionEntries(context, returnValue.entries);
      returnValue.entries.addAll(additionalFolders);
    }

    // Flatpak Index Installations
    if (configHandler.getValueUnsafe("search_filter_install_software", true)) {
      var flatpaks = await Linux.getAvailableFlatpaks(context).timeout(
          timeoutDuration,
          onTimeout: () => _onTimeoutOfSearchLoadingModule("flatpaks"));
      returnValue.entries.addAll(flatpaks);
    }

    // Deinstallation Entries.
    if (configHandler.getValueUnsafe(
        "search_filter_uninstall_software", true)) {
      var actions = await Linux.getUninstallEntries(context).timeout(
          timeoutDuration,
          onTimeout: () =>
              _onTimeoutOfSearchLoadingModule("uninstall_entries"));
      returnValue.entries.addAll(actions);
    }

    // Remove action entries for specific environments
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
