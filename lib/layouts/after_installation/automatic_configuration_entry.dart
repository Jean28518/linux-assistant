import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_selection.dart';
import 'package:linux_assistant/layouts/greeter/introduction.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationAutomaticConfigurationEntry extends StatelessWidget {
  const AfterInstallationAutomaticConfigurationEntry({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDistribution =
        getNiceStringOfDistrosEnum(Linux.currentenvironment.distribution);
    return MintYPage(
      title: AppLocalizations.of(context)!.setUpXWithRecommendedSettings +
          " " +
          currentDistribution +
          " " +
          AppLocalizations.of(context)!.setUpXWithRecommendedSettingsPart2,
      customContentElement: Expanded(
          child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MintYButtonBigWithIcon(
              icon: Icon(
                Icons.create_rounded,
                color: MintY.currentColor,
                size: 150,
              ),
              title: AppLocalizations.of(context)!.manualConfiguration,
              text: AppLocalizations.of(context)!
                  .afterInstallationManualConfigurationDescription,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RunCommandQueue(
                      title: AppLocalizations.of(context)!.applyConfiguration,
                      message: AppLocalizations.of(context)!
                          .thisProcessCouldTakeManyMinutesDependingSoftwareChoosed,
                      route: GreeterIntroduction(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            MintYButtonBigWithIcon(
              icon: Icon(
                Icons.auto_awesome,
                color: MintY.currentColor,
                size: 150,
              ),
              title: AppLocalizations.of(context)!.automaticConfiguration,
              text: AppLocalizations.of(context)!
                  .selectSpecificActionsOnTheNextSite,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AfterInstallationAutomaticConfiguration()),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
