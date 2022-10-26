import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_selection.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class AfterInstallationAutomaticConfigurationEntry extends StatelessWidget {
  const AfterInstallationAutomaticConfigurationEntry({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDistribution =
        getNiceStringOfDistrosEnum(Linux.currentEnviroment.distribution);
    return MintYPage(
      title: "Setup $currentDistribution with recommended settings?",
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
              title: "Manual Configuration",
              text:
                  "Exit this routine and keep the full control of every change on your pc.",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainSearchLoader()),
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
              title: "Automatic Configuration",
              text: "Select the specific automatic actions on the next page.",
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
