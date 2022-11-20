import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_entry.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
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
    const double padding = 20;
    List<Widget> content = [
      FutureBuilder<bool>(
        future: thunderbirdInstalled,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AfterInstallationService.thunderbird =
                snapshot.data.toString() == 'true';
            return MintYSelectableCardWithIcon(
                icon:
                    const SystemIcon(iconString: "thunderbird", iconSize: 150),
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
            return MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "jitsi", iconSize: 150),
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
            return MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "element", iconSize: 150),
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
            return MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "discord", iconSize: 150),
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
            AfterInstallationService.zoom = snapshot.data.toString() == 'true';
            return MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "zoom-zoom", iconSize: 150),
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
            return MintYSelectableCardWithIcon(
                icon: const SystemIcon(
                    iconString: "microsoft-teams", iconSize: 150),
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
    ];

    int columsCount =
        ((MediaQuery.of(context).size.width - (2 * padding)) / (440)).round();

    // Insert space Elements for last row, that the elements are something like centered
    if ((content.length % columsCount) != 0) {
      int spacingCounts =
          ((columsCount - (content.length % columsCount)) / 2).floor();
      for (int i = 0; i < spacingCounts; i++) {
        content.insert(
            content.length - content.length % columsCount, Container());
      }
    }
    return Scaffold(
      body: MintYPage(
        title: AppLocalizations.of(context)!.communicationSoftware,
        customContentElement: Expanded(
          child: GridView.count(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(padding),
            crossAxisCount: columsCount,
            childAspectRatio: 350 / 400,
            children: content,
          ),
        ),
        bottom: MintYButtonNext(
          route: const AfterInstallationAutomaticConfigurationEntry(),
          onPressedFuture: () async {
            await AfterInstallationService.applyCommunicationSituation();
          },
        ),
      ),
    );
  }
}
