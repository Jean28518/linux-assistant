import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/after_installation/activate_hotkey.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_entry.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/l10n/app_localizations.dart';

class AfterInstallationUtilitiesSelection extends StatelessWidget {
  const AfterInstallationUtilitiesSelection({super.key});

  static Future<bool> keepassxcInstalled = Linux.areApplicationsInstalled(
      ["keepassxc", "org.keepassxc.KeePassXC"]);
  static Future<bool> bitwardenInstalled = Linux.areApplicationsInstalled(
      ["bitwarden", "com.bitwarden.desktop"]);
  static Future<bool> pikaBackupInstalled = Linux.areApplicationsInstalled(
      ["pika-backup", "org.gnome.World.PikaBackup"]);
  static Future<bool> nextcloudInstalled = Linux.areApplicationsInstalled(
      ["nextcloud-desktop", "nextcloud-client", "com.nextcloud.desktopclient.nextcloud"]);
  static Future<bool> vortaInstalled = Linux.areApplicationsInstalled(
      ["vorta", "com.borgbase.Vorta"]);
  static Future<bool> obsidianInstalled = Linux.areApplicationsInstalled(
      ["obsidian", "md.obsidian.Obsidian"]);
  static Future<bool> terminalToolsInstalled = Linux.areApplicationsInstalled(
      ["ncdu"]);

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: AppLocalizations.of(context)!.utilitiesSelection,
      customContentElement: MintYGrid(
        padding: 10,
        ratio: 350 / 150,
        children: [
          FutureBuilder<bool>(
            future: keepassxcInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.keepassxc[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.keepassxc[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "keepassxc", iconSize: 64),
                  title: "KeePassXC",
                  text: AppLocalizations.of(context)!.keepassxcDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.keepassxc[1] =
                        !AfterInstallationService.keepassxc[1];
                  },
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
            future: bitwardenInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.bitwarden[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.bitwarden[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "bitwarden", iconSize: 64),
                  title: "Bitwarden",
                  text: AppLocalizations.of(context)!.bitwardenDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.bitwarden[1] =
                        !AfterInstallationService.bitwarden[1];
                  },
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
            future: pikaBackupInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.pikaBackup[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.pikaBackup[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "pika-backup", iconSize: 64),
                  title: "Pika Backup",
                  text: AppLocalizations.of(context)!.pikaDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.pikaBackup[1] =
                        !AfterInstallationService.pikaBackup[1];
                  },
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
            future: nextcloudInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.nextcloudClient[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.nextcloudClient[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "nextcloud", iconSize: 64),
                  title: "Nextcloud Client",
                  text: AppLocalizations.of(context)!.nextcloudDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.nextcloudClient[1] =
                        !AfterInstallationService.nextcloudClient[1];
                  },
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
            future: vortaInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.vorta[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.vorta[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "vorta", iconSize: 64),
                  title: "Vorta",
                  text: AppLocalizations.of(context)!.vortaDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.vorta[1] =
                        !AfterInstallationService.vorta[1];
                  },
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
            future: obsidianInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.obsidian[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.obsidian[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "obsidian", iconSize: 64),
                  title: "Obsidian",
                  text: AppLocalizations.of(context)!.obsidianDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.obsidian[1] =
                        !AfterInstallationService.obsidian[1];
                  },
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
            future: terminalToolsInstalled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AfterInstallationService.terminalTools[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.terminalTools[1] =
                    snapshot.data.toString() == 'true';
                return MintYSelectableEntryWithIconHorizontal(
                  icon: const SystemIcon(iconString: "utilities-terminal", iconSize: 64),
                  title: "Terminal Tools",
                  text: AppLocalizations.of(context)!.terminalToolsDescription,
                  selected: snapshot.data.toString() == 'true',
                  onPressed: () {
                    AfterInstallationService.terminalTools[1] =
                        !AfterInstallationService.terminalTools[1];
                  },
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
          await AfterInstallationService.applyUtilitiesSituation();
        },
      ),
    );
  }
}
