import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/disk_cleaner/clean_disk.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/linux/linux_filesystem.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/widgets/system_icon.dart';

class CleanerSelectDiskPage extends StatelessWidget {
  const CleanerSelectDiskPage({super.key});

  @override
  Widget build(BuildContext context) {
    var disks = LinuxFilesystem.disks();

    return MintYPage(
      title: "Speicherplatz freigeben",
      customContentElement: FutureBuilder(
          future: disks,
          builder: ((context, snapshot) {
            List<Widget> cards = [];
            if (snapshot.hasData) {
              for (var disk in snapshot.data! as List<DeviceInfo>) {
                cards.add(MintYCardWithIconAndAction(
                  icon: SystemIcon(iconString: "disks"),
                  title: disk.mountPoint == "/"
                      ? getNiceStringOfDistrosEnum(
                          Linux.currentenvironment.distribution)
                      : disk.mountPoint,
                  text:
                      "${disk.filesystem} (${disk.size}) - ${disk.sizeFree} ${AppLocalizations.of(context)!.free}",
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CleanDiskPage(mountpoint: disk.mountPoint),
                  )),
                  buttonText: AppLocalizations.of(context)!.clean,
                  customWidgetBetweenButtonAndText: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LinearProgressIndicator(
                      value: disk.usedPercent.toDouble() / 100.0,
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      color: disk.usedPercent > 89
                          ? Colors.red
                          : MintY.currentColor,
                      borderRadius: BorderRadius.circular(2),
                      minHeight: 5,
                    ),
                  ),
                ));
              }
              return MintYGrid(
                children: cards,
                padding: 10,
                ratio: 1.3,
                widgetSize: 300,
              );
            }
            return MintYProgressIndicatorCircle();
          })),
      bottom: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        MintYButtonNavigate(
          route: MainSearchLoader(),
          text: Text(AppLocalizations.of(context)!.backToSearch,
              style: MintY.heading4White),
          color: MintY.currentColor,
        )
      ]),
    );
  }
}
