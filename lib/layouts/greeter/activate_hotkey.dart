import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/greeter/start_after_installation.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/services/linux.dart';

class ActivateHotkeyQuestion extends StatelessWidget {
  late Widget? route;
  ActivateHotkeyQuestion({super.key, this.route});

  @override
  Widget build(BuildContext context) {
    route ??= const StartAfterInstallationRoutineQuestion();
    return MintYPage(
      title: AppLocalizations.of(context)!.activateHotkey,
      contentElements: [
        Text(
          AppLocalizations.of(context)!.openLinuxAssistantFaster,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          AppLocalizations.of(context)!.openLinuxAssistantFasterDescription,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButtonNavigate(
            route: route!,
            text: Text(
              AppLocalizations.of(context)!.skip,
              style: MintY.heading3,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          MintYButtonNavigate(
            route: route!,
            text: Text(
              AppLocalizations.of(context)!.yesSetUpHotkey,
              style: MintY.heading3White,
            ),
            color: MintY.currentColor,
            onPressed: () {
              Linux.activateSystemHotkeyForLinuxAssistant();
            },
          ),
        ],
      ),
    );
  }
}
