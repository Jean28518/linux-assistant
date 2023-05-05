import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/after_installation/flatpak_check.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationEntry extends StatelessWidget {
  const AfterInstallationEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MintYPage(
        title: AppLocalizations.of(context)!.afterInstallation,
        contentElements: [
          Text(
            AppLocalizations.of(context)!.welcomeToYourLinuxMachine,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            AppLocalizations.of(context)!.afterInstallationGreetingDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MintYButtonNavigate(
                text: Text(AppLocalizations.of(context)!.letsStart,
                    style: MintY.heading4White),
                route: const AfterInstallationFlatpakCheck(),
                color: MintY.currentColor,
                // width: 400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
