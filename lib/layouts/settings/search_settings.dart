import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/settings/settings_widgets.dart';
import 'package:linux_assistant/services/config_handler.dart';

class SearchSettings extends StatelessWidget {
  SearchSettings({super.key}) {
    ConfigHandler().ensureConfigIsLoaded();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: min(600, MediaQuery.of(context).size.width - 100),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SettingWidgetOnOff(
              settingKey: "search_filter_applications",
              text: AppLocalizations.of(context)!.includeApplications),
          SettingWidgetOnOff(
              settingKey: "search_filter_basic_folders",
              text: AppLocalizations.of(context)!.includeBasicFolders),
          SettingWidgetOnOff(
              settingKey: "search_filter_recently_used_files_and_folders",
              text: AppLocalizations.of(context)!
                  .includeRecentlyUsedFilesAndFolders),
          SettingWidgetOnOff(
              settingKey: "search_filter_favorite_files_and_folder_bookmarks",
              text: AppLocalizations.of(context)!
                  .includeFavoriteFilesAndFolderBookmarks),
          SettingWidgetOnOff(
              settingKey: "search_filter_bookmarks",
              text: AppLocalizations.of(context)!.includeBrowserBookmarks),
          SettingWidgetOnOff(
              settingKey: "self_learning_search",
              text: AppLocalizations.of(context)!.selfLearningSearch),
          SettingWidgetText(
              settingKey: "folder_recursion_depth",
              text: AppLocalizations.of(context)!.folderRecursionDepth,
              defaultValue: "3",
              hintText: "3",
              parseFunction: (String p0) {
                int? parsed = int.tryParse(p0);
                if (parsed == null) {
                  return "3";
                }
                return parsed.toString();
              }),
        ],
      ),
    );
  }
}
