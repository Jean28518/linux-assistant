import 'package:flutter/widgets.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/greeter/introduction.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationAutomaticConfiguration extends StatelessWidget {
  AfterInstallationAutomaticConfiguration({Key? key}) : super(key: key);

  final Future<bool> isNvidiaCardInstalledOnSystem =
      Linux.isNvidiaCardInstalledOnSystem();

  @override
  Widget build(BuildContext context) {
    // Disable functions for specific Distributions:
    if (Linux.currentenvironment.distribution == DISTROS.OPENSUSE ||
        Linux.currentenvironment.distribution == DISTROS.FEDORA) {
      AfterInstallationService.installNvidiaDrivers =
          false; // disabled at the time
      AfterInstallationService.setupAutomaticSnapshots =
          false; // disabled because of snapper
    }

    List<Widget> content = [
      MintYSelectableEntryWithIconHorizontal(
        icon: const SystemIcon(
          iconString: "update-manager",
          iconSize: 128,
        ),
        title: AppLocalizations.of(context)!.applyUpdatesSinceRelease,
        selected: true,
        onPressed: () {
          AfterInstallationService.applyUpdatesSinceRelease =
              !AfterInstallationService.applyUpdatesSinceRelease;
        },
        text: AppLocalizations.of(context)!.applyUpdatesSinceReleaseDescription(
            getNiceStringOfDistrosEnum(Linux.currentenvironment.distribution)),
      ),
      MintYSelectableEntryWithIconHorizontal(
        icon: const SystemIcon(
          iconString: "multimedia",
          iconSize: 128,
        ),
        title: AppLocalizations.of(context)!.installMultimediaCodecs,
        selected: true,
        onPressed: () {
          AfterInstallationService.installMultimediaCodecs =
              !AfterInstallationService.installMultimediaCodecs;
        },
        text: AppLocalizations.of(context)!.installMultimediaCodecsDescription,
      ),

      AfterInstallationService.setupAutomaticSnapshots
          ? MintYSelectableEntryWithIconHorizontal(
              icon: const SystemIcon(
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
            )
          : Container(),

      // Automatic Nvidia Installation
      AfterInstallationService.installNvidiaDrivers
          ? FutureBuilder<bool>(
              future: isNvidiaCardInstalledOnSystem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.toString() == "true") {
                    AfterInstallationService.installNvidiaDrivers = true;
                    return MintYSelectableEntryWithIconHorizontal(
                      icon: const SystemIcon(
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
            )
          : Container(),

      // Setup automatic updates
      AfterInstallationService.setupAutomaticUpdates
          ? MintYSelectableEntryWithIconHorizontal(
              icon: const SystemIcon(
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
            )
          : Container(),
    ];
    content.removeWhere((element) =>
        element.runtimeType != MintYSelectableEntryWithIconHorizontal);

    // Remove the Nvidia Card Installation and the Automatic Update Manager Configuration if the distribution is Arch
    // Also set the AfterInstallationService.setupAutomaticUpdates and ... to false
    if ([DISTROS.ARCH, DISTROS.MANJARO, DISTROS.ENDEAVOUR]
        .contains(Linux.currentenvironment.distribution)) {
      AfterInstallationService.setupAutomaticUpdates = false;
      content.removeWhere((element) =>
          element.runtimeType == MintYSelectableEntryWithIconHorizontal &&
          (element as MintYSelectableEntryWithIconHorizontal).title ==
              AppLocalizations.of(context)!
                  .automaticUpdateManagerConfiguration);
      AfterInstallationService.installNvidiaDrivers = false;
      content.removeWhere((element) =>
          element.runtimeType == MintYSelectableEntryWithIconHorizontal &&
          (element as MintYSelectableEntryWithIconHorizontal).title ==
              AppLocalizations.of(context)!.automaticNvidiaDriverInstallation);
    }

    return MintYPage(
      title: AppLocalizations.of(context)!.automaticConfiguration,
      customContentElement: MintYGrid(
        widgetSize: 700,
        children: content,
      ),
      bottom: MintYButtonNext(
        route: RunCommandQueue(
          title: AppLocalizations.of(context)!.welcomeToYourNewSystem,
          message: AppLocalizations.of(context)!
              .automaticConfigurationIsRunningDescription,
          route: const GreeterIntroduction(),
        ),
        onPressedFuture: () async {
          await AfterInstallationService.applyAutomaticConfiguration();
        },
      ),
    );
  }
}
