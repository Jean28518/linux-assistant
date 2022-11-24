import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationAutomaticConfiguration extends StatelessWidget {
  AfterInstallationAutomaticConfiguration({Key? key}) : super(key: key);

  Future<bool> isNvidiaCardInstalledOnSystem =
      Linux.isNvidiaCardInstalledOnSystem();

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: AppLocalizations.of(context)!.automaticConfiguration,
      customContentElement: MintYGrid(
        widgetSize: 700,
        children: [
          MintYSelectableEntryWithIconHorizontal(
            icon: SystemIcon(
              iconString: "multimedia",
              iconSize: 128,
            ),
            title: AppLocalizations.of(context)!.installMultimediaCodecs,
            selected: true,
            onPressed: () {
              AfterInstallationService.installMultimediaCodecs =
                  !AfterInstallationService.installMultimediaCodecs;
            },
            text: AppLocalizations.of(context)!
                .installMultimediaCodecsDescription,
          ),
          MintYSelectableEntryWithIconHorizontal(
            icon: SystemIcon(
              iconString: "disks",
              iconSize: 128,
            ),
            title: AppLocalizations.of(context)!.automaticSnapshots,
            selected: true,
            onPressed: () {
              AfterInstallationService.setupAutomaticSnapshots =
                  !AfterInstallationService.setupAutomaticSnapshots;
            },
            text: AppLocalizations.of(context)!.automaticSnapshotsDescription,
          ),
          FutureBuilder<bool>(
            future: isNvidiaCardInstalledOnSystem,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.toString() == "true") {
                  AfterInstallationService.installNvidiaDrivers = true;
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: SystemIcon(
                      iconString: "cs-drivers",
                      iconSize: 128,
                    ),
                    title: AppLocalizations.of(context)!
                        .automaticNvidiaDriverInstallation,
                    selected: true,
                    onPressed: () {
                      AfterInstallationService.installNvidiaDrivers =
                          !AfterInstallationService.installNvidiaDrivers;
                    },
                    text: AppLocalizations.of(context)!
                        .automaticNvidiaDriverInstallationDesciption,
                  );
                } else {
                  AfterInstallationService.installNvidiaDrivers = false;
                }
              }
              return Container();
            },
          ),
          MintYSelectableEntryWithIconHorizontal(
            icon: SystemIcon(
              iconString: "update-manager",
              iconSize: 128,
            ),
            title: AppLocalizations.of(context)!
                .automaticUpdateManagerConfiguration,
            selected: true,
            onPressed: () {
              AfterInstallationService.setupAutomaticUpdates =
                  !AfterInstallationService.setupAutomaticUpdates;
            },
            text: AppLocalizations.of(context)!
                .automaticUpdateManagerConfigurationDescription,
          ),
        ],
      ),
      bottom: MintYButtonNext(
        route: RunCommandQueue(
          title: AppLocalizations.of(context)!.welcomeToYourNewSystem,
          message: AppLocalizations.of(context)!
              .automaticConfigurationIsRunningDescription,
          route: const MainSearchLoader(),
        ),
        onPressed: () {
          AfterInstallationService.applyAutomaticConfiguration();
        },
      ),
    );
  }
}
