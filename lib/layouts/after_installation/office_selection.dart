import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/communication_software.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:linux_assistant/services/after_installation_service.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterInstallationOfficeSelection extends StatelessWidget {
  const AfterInstallationOfficeSelection({super.key});

  static Future<bool> libreOfficeInstalled =
      Linux.areApplicationsInstalled(["libreoffice-common"]);
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
                    AfterInstallationService.libreOffice =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                        icon: const SystemIcon(
                            iconString: "libreoffice", iconSize: 150),
                        title: "Libre Office",
                        text: AppLocalizations.of(context)!
                            .libreOfficeDescription,
                        selected: snapshot.data.toString() == 'true',
                        onPressed: () {
                          AfterInstallationService.libreOffice =
                              !AfterInstallationService.libreOffice;
                        });
                  }
                  return MintYProgressIndicatorCircle();
                },
              ),
              SizedBox(
                width: 10,
              ),
              FutureBuilder<bool>(
                future: onlOfficeInstalled,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AfterInstallationService.onlyOffice =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                        icon: const SystemIcon(
                            iconString: "onlyoffice", iconSize: 150),
                        title: "Only Office",
                        text:
                            AppLocalizations.of(context)!.onlyOfficeDescription,
                        selected: snapshot.data.toString() == 'true',
                        onPressed: () {
                          AfterInstallationService.onlyOffice =
                              !AfterInstallationService.onlyOffice;
                        });
                  }
                  return MintYProgressIndicatorCircle();
                },
              ),
              SizedBox(
                width: 10,
              ),
              FutureBuilder<bool>(
                future: wpsInstalled,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AfterInstallationService.wpsOffice =
                        snapshot.data.toString() == 'true';
                    return MintYSelectableCardWithIcon(
                      icon: const SystemIcon(
                          iconString: "wps-office", iconSize: 150),
                      title: "WPS Office",
                      text: AppLocalizations.of(context)!.wpsOfficeDescription,
                      selected: snapshot.data.toString() == 'true',
                      onPressed: () {
                        AfterInstallationService.wpsOffice =
                            !AfterInstallationService.wpsOffice;
                      },
                    );
                  }
                  return MintYProgressIndicatorCircle();
                },
              ),
            ],
          ),
        ],
        bottom: MintYButtonNext(
          route: AfterInstallationCommunicationSoftwareSelection(),
          onPressedFuture: () async {
            await AfterInstallationService.applyCurrentOfficeSituation();
          },
        ),
      ),
    );
  }
}
