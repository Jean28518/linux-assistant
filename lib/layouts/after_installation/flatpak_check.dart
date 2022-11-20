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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        Text(
          AppLocalizations.of(context)!.flatpakIsNotInstalled,
          style: MintY.heading1,
          textAlign: TextAlign.center,
        ),
        Text(
          AppLocalizations.of(context)!.flatpakDescription,
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
              AppLocalizations.of(context)!.skip,
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
              AppLocalizations.of(context)!.settingUpFlatpak,
              style: MintY.heading3White,
            ),
            onPressed: () async {
              await Linux.setUpFlatpak();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => RunCommandQueue(
                        route: AfterInstallationBrowserSelection(),
                        title: AppLocalizations.of(context)!.settingUpFlatpak,
                        message:
                            "${AppLocalizations.of(context)!.settingUpFlatpak}...",
                      ))));
            },
          )
        ],
      ),
    );
  }
}
