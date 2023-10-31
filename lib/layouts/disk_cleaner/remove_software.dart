import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/widgets/system_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RemoveSoftwareWidget extends StatelessWidget {
  late Widget routeAfterRemoval;
  RemoveSoftwareWidget({super.key, required this.routeAfterRemoval});

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> installedSoftware = _getInstalledSoftware();
    return FutureBuilder(
        future: installedSoftware,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> installedSoftwareList =
                snapshot.data! as List<dynamic>;
            return MintYGrid(
              padding: 10,
              ratio: 2,
              widgetSize: 450,
              children: [
                for (var flatpak
                    in installedSoftwareList[0] as List<List<String>>)
                  MintYCardWithIconAndAction(
                    icon: SystemIcon(iconString: flatpak[0]),
                    title: flatpak[1],
                    text: flatpak[2],
                    buttonText: AppLocalizations.of(context)!.remove,
                    onPressed: () async {
                      await Linux.removeApplications([flatpak[0]],
                          softwareManager: SOFTWARE_MANAGERS.FLATPAK);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RunCommandQueue(
                                title: AppLocalizations.of(context)!
                                    .uninstallApp(flatpak[1]),
                                route: routeAfterRemoval,
                              )));
                    },
                  ),
                for (var snap in installedSoftwareList[1] as List<String>)
                  MintYCardWithIconAndAction(
                    icon: SystemIcon(iconString: snap),
                    title: snap,
                    text: "(Snap)",
                    buttonText: AppLocalizations.of(context)!.remove,
                    onPressed: () async {
                      await Linux.removeApplications([snap],
                          softwareManager: SOFTWARE_MANAGERS.SNAP);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RunCommandQueue(
                                title: AppLocalizations.of(context)!
                                    .uninstallApp(snap),
                                route: routeAfterRemoval,
                              )));
                    },
                  ),
              ],
            );
          }
          return const MintYProgressIndicatorCircle();
        });
  }
}

Future<List<dynamic>> _getInstalledSoftware() {
  return Future.wait([
    Linux.getInstalledFlatpaks(),
    Linux.getInstalledSnaps(),
  ]);
}
