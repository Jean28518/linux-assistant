import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/after_installation/office_selection.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationBrowserSelection extends StatelessWidget {
  const AfterInstallationBrowserSelection({super.key});

  static Future<bool> firefoxInstalled = Linux.areApplicationsInstalled(
      ["firefox", "mozillafirefox", "firefox-esr"]);
  static Future<bool> chromiumInstalled =
      Linux.areApplicationsInstalled(["chromium", "org.chromium.Chromium"]);
  static Future<bool> braveInstalled =
      Linux.areApplicationsInstalled(["com.brave.Browser", "brave"]);
  static Future<bool> googleChromeStableInstalled =
      Linux.areApplicationsInstalled(
          ["google-chrome-stable", "com.google.Chrome"]);
  static Future<bool> vivadiInstalled =
      Linux.areApplicationsInstalled(["vivaldi", "com.vivaldi.Vivaldi"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MintYPage(
        title: AppLocalizations.of(context)!.browserSelection,
        customContentElement: MintYGrid(
          children: [
            FutureBuilder(
              future: firefoxInstalled,
              builder: (context, snapshot) {
                AfterInstallationService.firefox[0] =
                    snapshot.data.toString() == 'true';
                AfterInstallationService.firefox[1] =
                    snapshot.data.toString() == 'true';
                if (snapshot.hasData) {
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "firefox", iconSize: 64),
                    title: "Firefox",
                    text: AppLocalizations.of(context)!.firefoxDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.firefox[1] =
                          !AfterInstallationService.firefox[1];
                    },

                    /// Display warning text if installed version will be removed by user
                    infoText: snapshot.data.toString() == 'true'
                        ? Text(
                            AppLocalizations.of(context)!
                                .thisApplicationWillBeRemoved,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          )
                        : null,
                    showInfoTextAtThisSelectionState: false,
                  );
                } else {
                  return const MintYProgressIndicatorCircle();
                }
              },
            ),
            FutureBuilder(
              future: chromiumInstalled,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AfterInstallationService.chromium[0] =
                      snapshot.data.toString() == 'true';
                  AfterInstallationService.chromium[1] =
                      snapshot.data.toString() == 'true';
                  return MintYSelectableEntryWithIconHorizontal(
                    icon:
                        const SystemIcon(iconString: "chromium", iconSize: 64),
                    title: "Chromium",
                    text: AppLocalizations.of(context)!.chromiumDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.chromium[1] =
                          !AfterInstallationService.chromium[1];
                    },

                    /// Display warning text if installed version will be removed by user
                    infoText: snapshot.data.toString() == 'true'
                        ? Text(
                            AppLocalizations.of(context)!
                                .thisApplicationWillBeRemoved,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          )
                        : null,
                    showInfoTextAtThisSelectionState: false,
                  );
                } else {
                  return const MintYProgressIndicatorCircle();
                }
              },
            ),
            FutureBuilder(
              future: braveInstalled,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AfterInstallationService.brave[0] =
                      snapshot.data.toString() == 'true';
                  AfterInstallationService.brave[1] =
                      snapshot.data.toString() == 'true';
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "brave", iconSize: 64),
                    title: "Brave",
                    text: AppLocalizations.of(context)!.braveDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.brave[1] =
                          !AfterInstallationService.brave[1];
                    },

                    /// Display warning text if installed version will be removed by user
                    infoText: snapshot.data.toString() == 'true'
                        ? Text(
                            AppLocalizations.of(context)!
                                .thisApplicationWillBeRemoved,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          )
                        : null,
                    showInfoTextAtThisSelectionState: false,
                  );
                } else {
                  return const MintYProgressIndicatorCircle();
                }
              },
            ),
            FutureBuilder(
              future: googleChromeStableInstalled,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AfterInstallationService.googleChrome[0] =
                      snapshot.data.toString() == 'true';
                  AfterInstallationService.googleChrome[1] =
                      snapshot.data.toString() == 'true';
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(
                        iconString: "google-chrome", iconSize: 64),
                    title: "Google Chrome",
                    text: AppLocalizations.of(context)!.chromeDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.googleChrome[1] =
                          !AfterInstallationService.googleChrome[1];
                    },

                    /// Display warning text if installed version will be removed by user
                    infoText: snapshot.data.toString() == 'true'
                        ? Text(
                            AppLocalizations.of(context)!
                                .thisApplicationWillBeRemoved,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          )
                        : null,
                    showInfoTextAtThisSelectionState: false,
                  );
                } else {
                  return const MintYProgressIndicatorCircle();
                }
              },
            ),
            FutureBuilder(
              future: vivadiInstalled,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AfterInstallationService.vivaldi[0] =
                      snapshot.data.toString() == 'true';
                  AfterInstallationService.vivaldi[1] =
                      snapshot.data.toString() == 'true';
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "vivaldi", iconSize: 64),
                    title: "Vivaldi",
                    text: AppLocalizations.of(context)!.vivaldiDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.vivaldi[1] =
                          !AfterInstallationService.vivaldi[1];
                    },

                    /// Display warning text if installed version will be removed by user
                    infoText: snapshot.data.toString() == 'true'
                        ? Text(
                            AppLocalizations.of(context)!
                                .thisApplicationWillBeRemoved,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          )
                        : null,
                    showInfoTextAtThisSelectionState: false,
                  );
                } else {
                  return const MintYProgressIndicatorCircle();
                }
              },
            ),
          ],
        ),
        bottom: MintYButtonNext(
          route: const AfterInstallationOfficeSelection(),
          onPressedFuture: () async {
            await AfterInstallationService.applyCurrentBrowserSituation();
          },
        ),
      ),
    );
  }
}
