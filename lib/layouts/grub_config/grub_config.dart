import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class GrubConfigPage extends StatelessWidget {
  GrubConfigPage({super.key});

  final _GrubSettings _grubSettings = _GrubSettings(Linux.getGrubSettings());

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: AppLocalizations.of(context)!.grubConfiguration,
      contentElements: [
        MintYCheckboxSetting(
          text: AppLocalizations.of(context)!.grubVisible,
          value: _grubSettings.grubVisible,
          onChanged: (value) {
            _grubSettings.grubVisible = value;
          },
        ),
        MintYCheckboxSetting(
          text: AppLocalizations.of(context)!.enableBigFont,
          value: _grubSettings.enableBigFont,
          onChanged: (value) {
            _grubSettings.enableBigFont = value;
          },
        ),
        MintYTextSetting(
          text: AppLocalizations.of(context)!.grubCountdown,
          textAlign: TextAlign.right,
          value: _grubSettings.timeout.toString(),
          onChanged: (value) {
            int? parsed = int.tryParse(value);
            if (parsed == null) {
              return;
            }
            _grubSettings.timeout = parsed;
          },
        ),
        MintYCheckboxSetting(
          text: AppLocalizations.of(context)!.startLastBootedEntry,
          value: _grubSettings.startLastBootedOne,
          onChanged: (value) {
            _grubSettings.startLastBootedOne = value;
          },
        ),
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButton(
            text:
                Text(AppLocalizations.of(context)!.back, style: MintY.heading4),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MainSearchLoader(),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          MintYButton(
            text: Text(AppLocalizations.of(context)!.save,
                style: MintY.heading4White),
            color: MintY.currentColor,
            onPressed: () {
              Linux.ensureGrubSettings(
                  context,
                  _grubSettings.grubVisible,
                  _grubSettings.enableBigFont,
                  _grubSettings.timeout,
                  _grubSettings.startLastBootedOne);
            },
          ),
        ],
      ),
    );
  }
}

class _GrubSettings {
  bool grubVisible = false;
  bool enableBigFont = false;
  int timeout = 100;
  bool startLastBootedOne = false;

  _GrubSettings(Map<String, dynamic> settingsMap) {
    grubVisible = settingsMap["grubVisible"];
    enableBigFont = settingsMap["enableBigFont"];
    timeout = settingsMap["timeout"];
    startLastBootedOne = settingsMap["startLastBootedOne"];
  }
}
