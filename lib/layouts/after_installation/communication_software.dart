import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_entry.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationCommunicationSoftwareSelection extends StatelessWidget {
  AfterInstallationCommunicationSoftwareSelection({super.key});

  static Future<bool> thunderbirdInstalled =
      Linux.areApplicationsInstalled(["thunderbird"]);
  static Future<bool> jitsiMeetInstalled =
      Linux.areApplicationsInstalled(["org.jitsi.jitsi-meet"]);
  static Future<bool> elementInstalled =
      Linux.areApplicationsInstalled(["im.riot.Riot", "element-desktop"]);
  static Future<bool> discordInstalled =
      Linux.areApplicationsInstalled(["com.discordapp.Discord", "discord"]);
  static Future<bool> zoomInstalled =
      Linux.areApplicationsInstalled(["us.zoom.Zoom", "zoom-client"]);

  /// Here the snap is preferred, because it is offically supported by Microsoft.
  static Future<bool> microsoftTeamsInstalled =
      Linux.areApplicationsInstalled(["teams", "com.microsoft.Teams"]);

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: AppLocalizations.of(context)!.communicationSoftware,
      customContentElement: MintYGrid(
        padding: 10,
        ratio: 350 / 150,
        children: [
          FutureBuilder<bool>(
            future: thunderbirdInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.thunderbird =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(
                        iconString: "thunderbird", iconSize: 64),
                    title: "Thunderbird",
                    text: AppLocalizations.of(context)!.thunderbirdDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.thunderbird =
                          !AfterInstallationService.thunderbird;
                    });
              }
              return Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: jitsiMeetInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.jitsiMeet =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "jitsi", iconSize: 64),
                    title: "Jitsi Meet",
                    text: AppLocalizations.of(context)!.jitsiDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.jitsiMeet =
                          !AfterInstallationService.jitsiMeet;
                    });
              }
              return Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: elementInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.element =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "element", iconSize: 64),
                    title: "Element",
                    text: AppLocalizations.of(context)!.elementDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.element =
                          !AfterInstallationService.element;
                    });
              }
              return Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: discordInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.discord =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "discord", iconSize: 64),
                    title: "Discord",
                    text: AppLocalizations.of(context)!.discordDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.discord =
                          !AfterInstallationService.discord;
                    });
              }
              return Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: zoomInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.zoom =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                    icon:
                        const SystemIcon(iconString: "zoom-zoom", iconSize: 64),
                    title: "Zoom",
                    text: AppLocalizations.of(context)!.zoomDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.zoom =
                          !AfterInstallationService.zoom;
                    });
              }
              return Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: microsoftTeamsInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.microsoftTeams =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(
                        iconString: "microsoft-teams", iconSize: 64),
                    title: "Microsoft Teams",
                    text: AppLocalizations.of(context)!.teamsDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.microsoftTeams =
                          !AfterInstallationService.microsoftTeams;
                    });
              }
              return Center(child: MintYProgressIndicatorCircle());
            },
          ),
        ],
      ),
      bottom: MintYButtonNext(
        route: const AfterInstallationAutomaticConfigurationEntry(),
        onPressedFuture: () async {
          await AfterInstallationService.applyCommunicationSituation();
        },
      ),
    );
  }
}
