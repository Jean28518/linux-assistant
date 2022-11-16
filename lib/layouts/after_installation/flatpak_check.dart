import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_entry.dart';
import 'package:linux_assistant/layouts/after_installation/browser_selection.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';

class AfterInstallationFlatpakCheck extends StatelessWidget {
  const AfterInstallationFlatpakCheck({super.key});

  @override
  Widget build(BuildContext context) {
    if (Linux.currentEnviroment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.FLATPAK)) {
      return AfterInstallationBrowserSelection();
    }
    return MintYPage(
      title: "Flatpak",
      contentElements: [
        const Text(
          "Flatpak isn't installed on your system.",
          style: MintY.heading1,
          textAlign: TextAlign.center,
        ),
        const Text(
          """For easy access to many popular apps Flatpak is highly recommended.
        Flatpak is a new utility for packet management for Linux.
        It is offering a sandbox environment in which apps can run in isolation of the rest of the system.
        By binding the 'Flathub' (biggest repository for flatpaks) you get access to over 1800 different Linux apps.
        As a downside Flatpaks require more diskpace.""",
          style: MintY.paragraph,
          textAlign: TextAlign.center,
        )
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButton(
            color: Colors.grey,
            text: Text(
              "Skip",
              style: MintY.heading3,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) =>
                      AfterInstallationAutomaticConfigurationEntry())));
            },
          ),
          SizedBox(
            width: 10,
          ),
          MintYButton(
            color: MintY.currentColor,
            text: Text(
              "Setup Flatpak",
              style: MintY.heading3White,
            ),
            onPressed: () async {
              await Linux.setUpFlatpak();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => RunCommandQueue(
                        route: AfterInstallationBrowserSelection(),
                        title: "Setup Flatpak",
                        message: "Setting up flatpak...",
                      ))));
            },
          )
        ],
      ),
    );
  }
}
