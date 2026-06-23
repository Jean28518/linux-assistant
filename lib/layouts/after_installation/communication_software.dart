import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/after_installation/utilities_selection.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/l10n/app_localizations.dart';

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

  static Future<bool> whatsieInstalled =
      Linux.areApplicationsInstalled(["whatsie", "com.ktechpit.whatsie"]);
  static Future<bool> telegramInstalled = Linux.areApplicationsInstalled(
      ["telegram-desktop", "org.telegram.desktop"]);
  static Future<bool> threemaInstalled =
      Linux.areApplicationsInstalled(["threema", "ch.threema.threema-desktop"]);

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
            future: whatsieInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.whatsie[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.whatsie[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "whatsie", iconSize: 64),
                  title: "Whatsie",
                  text: AppLocalizations.of(context)!.whatsieDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.whatsie[1] =
                        !AfterInstallationService.whatsie[1];
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
            future: telegramInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.telegram[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.telegram[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "telegram", iconSize: 64),
                  title: "Telegram",
                  text: AppLocalizations.of(context)!.telegramDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.telegram[1] =
                        !AfterInstallationService.telegram[1];
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
            future: threemaInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.threema[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.threema[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "threema", iconSize: 64),
                  title: "Threema",
                  text: AppLocalizations.of(context)!.threemaDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.threema[1] =
                        !AfterInstallationService.threema[1];
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
        ],
      ),
      bottom: MintYButtonNext(
        route: const AfterInstallationUtilitiesSelection(),
        onPressedFuture: () async {
          await AfterInstallationService.applyCommunicationSituation();
        },
      ),
    );
  }
}
