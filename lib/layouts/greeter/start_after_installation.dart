import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/layouts/after_installation/after_installation_entry.dart';
import 'package:linux_assistant/layouts/greeter/introduction.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class StartAfterInstallationRoutineQuestion extends StatelessWidget {
  const StartAfterInstallationRoutineQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: AppLocalizations.of(context)!.startAfterInstallationRoutine,
      contentElements: [
        Text(
          AppLocalizations.of(context)!.timeToSetupYourComputer,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          AppLocalizations.of(context)!.timeToSetupYourComputerDescription,
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButtonNavigate(
            route: GreeterIntroduction(),
            text: Text(
              AppLocalizations.of(context)!.skip,
              style: MintY.heading3,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          MintYButtonNavigate(
            route: const AfterInstallationEntry(),
            color: MintY.currentColor,
            text: Text(
              AppLocalizations.of(context)!.letsStart,
              style: MintY.heading3White,
            ),
          ),
        ],
      ),
    );
  }
}
