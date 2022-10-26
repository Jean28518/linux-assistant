import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class AfterInstallationAutomaticConfiguration extends StatelessWidget {
  AfterInstallationAutomaticConfiguration({Key? key}) : super(key: key);

  Future<bool> isNvidiaCardInstalledOnSystem =
      Linux.isNvidiaCardInstalledOnSystem();

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: "Automatic Configuration",
      contentElements: [
        MintYSelectableEntryWithIconHorizontal(
          icon: SystemIcon(
            iconString: "multimedia",
            iconSize: 128,
          ),
          title: "Install Multimedia Codecs",
          selected: true,
          onPressed: () {
            AfterInstallationService.installMultimediaCodecs =
                !AfterInstallationService.installMultimediaCodecs;
          },
          text:
              "Additional proprietary multimedia codes for playing videos and music.",
        ),
        MintYSelectableEntryWithIconHorizontal(
          icon: SystemIcon(
            iconString: "disks",
            iconSize: 128,
          ),
          title: "Automatic Snapshots",
          selected: true,
          onPressed: () {
            AfterInstallationService.setupAutomaticSnapshots =
                !AfterInstallationService.setupAutomaticSnapshots;
          },
          text:
              "Configure automatic snapshots with timeshift. Timeshift will be configured to 2 monthly automatic snapshots on your root partition. It will not backup your personal files.",
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
                  title: "Automatic Nividia-Driver installation",
                  selected: true,
                  onPressed: () {
                    AfterInstallationService.installNvidiaDrivers =
                        !AfterInstallationService.installNvidiaDrivers;
                  },
                  text: "All recommended drivers will be installed.",
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
          title: "Automatic Update Manager Configuration",
          selected: true,
          onPressed: () {
            AfterInstallationService.setupAutomaticUpdates =
                !AfterInstallationService.setupAutomaticUpdates;
          },
          text: "Automatic updates and maintainance will be configured.",
        ),
      ],
      bottom: MintYButtonNext(
        route: const MainSearchLoader(),
        onPressed: () {
          AfterInstallationService.applyAutomaticConfiguration();
        },
      ),
    );
  }
}
