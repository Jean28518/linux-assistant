import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/after_installation/activate_hotkey.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_entry.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationCommunicationSoftwareSelection extends StatelessWidget {
  const AfterInstallationCommunicationSoftwareSelection({super.key});

  static Future<bool> thunderbirdInstalled = Linux.areApplicationsInstalled(
      ["thunderbird", "mozillathunderbird", "org.mozilla.Thunderbird"]);
  static Future<bool> jitsiMeetInstalled =
      Linux.areApplicationsInstalled(["org.jitsi.jitsi-meet"]);
  static Future<bool> elementInstalled =
      Linux.areApplicationsInstalled(["im.riot.Riot", "element-desktop"]);
  static Future<bool> signalInstalled =
      Linux.areApplicationsInstalled(["org.signal.Signal", "signal-desktop"]);
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
                AfterInstallationService.thunderbird[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.thunderbird[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon:
                      const SystemIcon(iconString: "thunderbird", iconSize: 64),
                  title: "Thunderbird",
                  text: AppLocalizations.of(context)!.thunderbirdDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.thunderbird[1] =
                        !AfterInstallationService.thunderbird[1];
                  },

                  /// Display warning text if installed version will be removed by user
                  infoText: snapshot.data.toString() == 'true'
                      ? Text(
                          AppLocalizations.of(context)!
                              .thisApplicationWillBeRemoved,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : null,
                  showInfoTextAtThisSelectionState: false,
                );
              }
              return const Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: jitsiMeetInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.jitsiMeet[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.jitsiMeet[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "jitsi", iconSize: 64),
                  title: "Jitsi Meet",
                  text: AppLocalizations.of(context)!.jitsiDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.jitsiMeet[1] =
                        !AfterInstallationService.jitsiMeet[1];
                  },

                  /// Display warning text if installed version will be removed by user
                  infoText: snapshot.data.toString() == 'true'
                      ? Text(
                          AppLocalizations.of(context)!
                              .thisApplicationWillBeRemoved,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : null,
                  showInfoTextAtThisSelectionState: false,
                );
              }
              return const Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: elementInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.element[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.element[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "element", iconSize: 64),
                  title: "Element",
                  text: AppLocalizations.of(context)!.elementDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.element[1] =
                        !AfterInstallationService.element[1];
                  },

                  /// Display warning text if installed version will be removed by user
                  infoText: snapshot.data.toString() == 'true'
                      ? Text(
                          AppLocalizations.of(context)!
                              .thisApplicationWillBeRemoved,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : null,
                  showInfoTextAtThisSelectionState: false,
                );
              }
              return const Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: signalInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.signal[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.signal[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "signal", iconSize: 64),
                  title: "Signal",
                  text: AppLocalizations.of(context)!.signalDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.signal[1] =
                        !AfterInstallationService.signal[1];
                  },

                  /// Display warning text if installed version will be removed by user
                  infoText: snapshot.data.toString() == 'true'
                      ? Text(
                          AppLocalizations.of(context)!
                              .thisApplicationWillBeRemoved,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : null,
                  showInfoTextAtThisSelectionState: false,
                );
              }
              return const Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: discordInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.discord[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.discord[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "discord", iconSize: 64),
                  title: "Discord",
                  text: AppLocalizations.of(context)!.discordDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.discord[1] =
                        !AfterInstallationService.discord[1];
                  },

                  /// Display warning text if installed version will be removed by user
                  infoText: snapshot.data.toString() == 'true'
                      ? Text(
                          AppLocalizations.of(context)!
                              .thisApplicationWillBeRemoved,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : null,
                  showInfoTextAtThisSelectionState: false,
                );
              }
              return const Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: zoomInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.zoom[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.zoom[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "zoom-zoom", iconSize: 64),
                  title: "Zoom",
                  text: AppLocalizations.of(context)!.zoomDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.zoom[1] =
                        !AfterInstallationService.zoom[1];
                  },

                  /// Display warning text if installed version will be removed by user
                  infoText: snapshot.data.toString() == 'true'
                      ? Text(
                          AppLocalizations.of(context)!
                              .thisApplicationWillBeRemoved,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : null,
                  showInfoTextAtThisSelectionState: false,
                );
              }
              return const Center(child: MintYProgressIndicatorCircle());
            },
          ),
          FutureBuilder<bool>(
            future: microsoftTeamsInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.microsoftTeams[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.microsoftTeams[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(
                      iconString: "microsoft-teams", iconSize: 64),
                  title: "Microsoft Teams",
                  text: AppLocalizations.of(context)!.teamsDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.microsoftTeams[1] =
                        !AfterInstallationService.microsoftTeams[1];
                  },

                  /// Display warning text if installed version will be removed by user
                  infoText: snapshot.data.toString() == 'true'
                      ? Text(
                          AppLocalizations.of(context)!
                              .thisApplicationWillBeRemoved,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        )
                      : null,
                  showInfoTextAtThisSelectionState: false,
                );
              }
              return const Center(child: MintYProgressIndicatorCircle());
            },
          ),
        ],
      ),
      bottom: MintYButtonNext(
        route: ActivateHotkeyQuestion(
          route: const AfterInstallationAutomaticConfigurationEntry(),
        ),
        onPressedFuture: () async {
          await AfterInstallationService.applyCommunicationSituation();
        },
      ),
    );
  }
}
