import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/after_installation/communication_software.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationOfficeSelection extends StatelessWidget {
  const AfterInstallationOfficeSelection({super.key});

  static Future<bool> libreOfficeInstalled = Linux.areApplicationsInstalled([
    "libreoffice",
    "libreoffice-common",
    "libreoffice-still",
    "libreoffice-fresh",
    "org.libreoffice.LibreOffice",
    "libreoffice-writer"
  ]);
  static Future<bool> onlOfficeInstalled = Linux.areApplicationsInstalled(
      ["org.onlyoffice.desktopeditors", "onlyoffice-desktopeditors"]);
  static Future<bool> wpsInstalled =
      Linux.areApplicationsInstalled(["com.wps.Office"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MintYPage(
        title: AppLocalizations.of(context)!.officeSelection,
        contentElements: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<bool>(
                future: libreOfficeInstalled,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AfterInstallationService.libreOffice[0] =
                        snapshot.data.toString() == 'true';
                    AfterInstallationService.libreOffice[1] =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                        icon: const SystemIcon(
                            iconString: "libreoffice", iconSize: 150),
                        title: "Libre Office",
                        text: AppLocalizations.of(context)!
                            .libreOfficeDescription,
                        selected: snapshot.data.toString() == 'true',
                        onPressed: () {
                          AfterInstallationService.libreOffice[1] =
                              !AfterInstallationService.libreOffice[1];
                        });
                  }
                  return const MintYProgressIndicatorCircle();
                },
              ),
              const SizedBox(
                width: 10,
              ),
              FutureBuilder<bool>(
                future: onlOfficeInstalled,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AfterInstallationService.onlyOffice[0] =
                        snapshot.data.toString() == 'true';
                    AfterInstallationService.onlyOffice[1] =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                        icon: const SystemIcon(
                            iconString: "onlyoffice", iconSize: 150),
                        title: "Only Office",
                        text:
                            AppLocalizations.of(context)!.onlyOfficeDescription,
                        selected: snapshot.data.toString() == 'true',
                        onPressed: () {
                          AfterInstallationService.onlyOffice[1] =
                              !AfterInstallationService.onlyOffice[1];
                        });
                  }
                  return const MintYProgressIndicatorCircle();
                },
              ),
              const SizedBox(
                width: 10,
              ),
              FutureBuilder<bool>(
                future: wpsInstalled,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AfterInstallationService.wpsOffice[0] =
                        snapshot.data.toString() == 'true';
                    AfterInstallationService.wpsOffice[1] =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                      icon: const SystemIcon(
                          iconString: "wps-office", iconSize: 150),
                      title: "WPS Office",
                      text: AppLocalizations.of(context)!.wpsOfficeDescription,
                      selected: snapshot.data.toString() == 'true',
                      onPressed: () {
                        AfterInstallationService.wpsOffice[1] =
                            !AfterInstallationService.wpsOffice[1];
                      },
                    );
                  }
                  return const MintYProgressIndicatorCircle();
                },
              ),
            ],
          ),
        ],
        bottom: MintYButtonNext(
          route: const AfterInstallationCommunicationSoftwareSelection(),
          onPressedFuture: () async {
            await AfterInstallationService.applyCurrentOfficeSituation();
          },
        ),
      ),
    );
  }
}
