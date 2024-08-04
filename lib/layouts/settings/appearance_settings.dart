import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/settings/settings_widgets.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';

class AppearanceSettings extends StatelessWidget {
  AppearanceSettings({super.key}) {
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
            settingKey: "dark_theme_activated",
            text: AppLocalizations.of(context)!.darkThemeEnabled,
            defaultValue: Theme.of(context) == MintY.themeDark(),
          ),
          SettingWidgetOnOff(
            settingKey: "colorfulBackground",
            text: AppLocalizations.of(context)!.colorfulBackground,
          ),
          SettingWidgetText(
              settingKey: "main_color",
              text: AppLocalizations.of(context)!.mainColorSetting,
              defaultValue: "",
              hintText: "#8ab15a",
              parseFunction: _parseHexColor),
          SettingWidgetText(
              settingKey: "secondary_color",
              text: AppLocalizations.of(context)!.secondaryColorSetting,
              defaultValue: "",
              hintText: "#2eb9a2",
              parseFunction: _parseHexColor),
          InkWell(
            child: Text(
              "Web color picker for HEX code: https://htmlcolorcodes.com/",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Linux.openWebbrowserWithSite("https://htmlcolorcodes.com/");
            },
          )
        ],
      ),
    );
  }

  String _parseHexColor(String p0) {
    RegExp hexColor = RegExp(r'^#?([0-9a-fA-F]{6})$');
    if (!hexColor.hasMatch(p0)) {
      p0 = "";
    }
    return p0;
  }
}
