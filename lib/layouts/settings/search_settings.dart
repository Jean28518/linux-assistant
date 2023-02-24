import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
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
        ],
      ),
    );
  }
}

class SettingWidgetOnOff extends StatefulWidget {
  /// Settings-Key
  late String settingKey;

  late String text;
  late bool defaultValue;
  SettingWidgetOnOff(
      {super.key,
      required this.settingKey,
      required this.text,
      this.defaultValue = true});

  @override
  State<SettingWidgetOnOff> createState() => _SettingWidgetOnOffState();
}

class _SettingWidgetOnOffState extends State<SettingWidgetOnOff> {
  late bool value;
  @override
  void initState() {
    value =
        ConfigHandler().getValueUnsafe(widget.settingKey, widget.defaultValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Description
          Column(
            children: [
              Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),

          /// Setting
          Column(
            children: [
              MintYButton(
                color: MintY.currentColor,
                text: value
                    ? Text(
                        AppLocalizations.of(context)!.on,
                        style: MintY.heading4White,
                      )
                    : Text(
                        AppLocalizations.of(context)!.off,
                        style: MintY.heading4White,
                      ),
                onPressed: () {
                  ConfigHandler().setValue(widget.settingKey, !value);
                  setState(() {
                    value = !value;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
