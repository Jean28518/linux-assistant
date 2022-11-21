import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/browser_selection.dart';
import 'package:linux_assistant/layouts/after_installation/flatpak_check.dart';
import 'package:linux_assistant/layouts/mintY.dart';
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
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalizations.of(context)!.afterInstallationGreetingDescription,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MintYButtonNavigate(
                text: Text(AppLocalizations.of(context)!.letsStart,
                    style: MintY.heading2White),
                route: AfterInstallationFlatpakCheck(),
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
