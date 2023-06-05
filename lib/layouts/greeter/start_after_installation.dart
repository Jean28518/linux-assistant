import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/after_installation/after_installation_entry.dart';
import 'package:linux_assistant/layouts/greeter/introduction.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartAfterInstallationRoutineQuestion extends StatelessWidget {
  const StartAfterInstallationRoutineQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: AppLocalizations.of(context)!.startAfterInstallationRoutine,
      contentElements: [
        Text(
          AppLocalizations.of(context)!.timeToSetupYourComputer,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          AppLocalizations.of(context)!.timeToSetupYourComputerDescription,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButtonNavigate(
            route: const GreeterIntroduction(),
            text: Text(
              AppLocalizations.of(context)!.skip,
              style: MintY.heading4,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          MintYButtonNavigate(
            route: const AfterInstallationEntry(),
            color: MintY.currentColor,
            text: Text(
              AppLocalizations.of(context)!.letsStart,
              style: MintY.heading4White,
            ),
          ),
        ],
      ),
    );
  }
}
