import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/office_selection.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationBrowserSelection extends StatelessWidget {
  AfterInstallationBrowserSelection({super.key});

  static Future<bool> firefoxInstalled = Linux.areApplicationsInstalled(
      ["firefox", "mozillafirefox", "firefox-esr"]);
  static Future<bool> chromiumInstalled =
      Linux.areApplicationsInstalled(["chromium"]);
  static Future<bool> braveInstalled =
      Linux.areApplicationsInstalled(["com.brave.Browser"]);
  static Future<bool> googleChromeStableInstalled =
      Linux.areApplicationsInstalled(
          ["google-chrome-stable", "com.google.Chrome"]);

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
                AfterInstallationService.firefox =
                    snapshot.data.toString() == 'true';
                if (snapshot.hasData) {
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "firefox", iconSize: 64),
                    title: "Firefox",
                    text: AppLocalizations.of(context)!.firefoxDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.firefox =
                          !AfterInstallationService.firefox;
                    },
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
                  AfterInstallationService.chromium =
                      snapshot.data.toString() == 'true';
                  return MintYSelectableEntryWithIconHorizontal(
                    icon:
                        const SystemIcon(iconString: "chromium", iconSize: 64),
                    title: "Chromium",
                    text: AppLocalizations.of(context)!.chromiumDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.chromium =
                          !AfterInstallationService.chromium;
                    },
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
                  AfterInstallationService.brave =
                      snapshot.data.toString() == 'true';
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(iconString: "brave", iconSize: 64),
                    title: "Brave",
                    text: AppLocalizations.of(context)!.braveDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.brave =
                          !AfterInstallationService.brave;
                    },
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
                  AfterInstallationService.googleChrome =
                      snapshot.data.toString() == 'true';
                  return MintYSelectableEntryWithIconHorizontal(
                    icon: const SystemIcon(
                        iconString: "google-chrome", iconSize: 64),
                    title: "Google Chrome",
                    text: AppLocalizations.of(context)!.chromeDescription,
                    selected: snapshot.data.toString() == 'true',
                    onPressed: () {
                      AfterInstallationService.googleChrome =
                          !AfterInstallationService.googleChrome;
                    },
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
