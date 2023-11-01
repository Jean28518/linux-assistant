import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/disk_cleaner/clean_timeshift.dart';
import 'package:linux_assistant/layouts/disk_cleaner/biggest_folders.dart';
import 'package:linux_assistant/layouts/disk_cleaner/cleaner_select_disk.dart';
import 'package:linux_assistant/layouts/disk_cleaner/remove_software.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/linux/linux_filesystem.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

class CleanDiskPage extends StatelessWidget {
  late String mountpoint;
  CleanDiskPage({super.key, required this.mountpoint});

  @override
  Widget build(BuildContext context) {
    String displayName = mountpoint;
    if (displayName == "/") {
      displayName =
          getNiceStringOfDistrosEnum(Linux.currentenvironment.distribution);
    }
    return MintYPage(
      title: AppLocalizations.of(context)!.cleanX(displayName),
      contentElements: [
        // Disk usage
        _getDiskUsageWidget(context),
        // Automatic cleanup
        Text(
          AppLocalizations.of(context)!.automaticCleanup,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          AppLocalizations.of(context)!.automaticCleanupDescription,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MintYButton(
                onPressed: () => Linux.cleanDiskspace(context, mountpoint),
                text: Text(AppLocalizations.of(context)!.automaticCleanup,
                    style: MintY.heading4White),
                color: MintY.currentColor,
              ),
            )
          ],
        ),
        // biggest folders
        Text(
          AppLocalizations.of(context)!.allBiggestFolders,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width - 50,
          child: BiggestFoldersWidget(
            path: mountpoint,
          ),
        ),
        // Timeshift
        if (Directory('$mountpoint/timeshift/snapshots/').existsSync())
          Text(
            "Timeshift",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        if (Directory('$mountpoint/timeshift/snapshots/').existsSync())
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width - 50,
            child: TimeshiftCleanWidget(
              routeAfterRemoval: CleanDiskPage(mountpoint: mountpoint),
              mountpoint: mountpoint,
            ),
          ),
        // Remove software
        if (mountpoint == "/")
          Text(
            AppLocalizations.of(context)!.removeSoftware,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        if (mountpoint == "/")
          RemoveSoftwareWidget(
              routeAfterRemoval: CleanDiskPage(mountpoint: mountpoint)),
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButton(
            text: Text(AppLocalizations.of(context)!.back,
                style: MintY.heading4White),
            color: MintY.currentColor,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CleanerSelectDiskPage(),
            )),
          ),
        ],
      ),
    );
  }

  Widget _getDiskUsageWidget(BuildContext context) {
    return FutureBuilder(
      future: LinuxFilesystem.disks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DeviceInfo> disks = snapshot.data! as List<DeviceInfo>;
          DeviceInfo? found;
          for (DeviceInfo disk in disks) {
            if (disk.mountPoint == mountpoint) {
              found = disk;
            }
          }
          if (found == null) {
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: found.usedPercent.toDouble() / 100.0,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    color: found.usedPercent > 89
                        ? Colors.red
                        : MintY.currentColor,
                    borderRadius: BorderRadius.circular(7),
                    minHeight: 15,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.diskUsage +
                        ": " +
                        found.sizeUsed +
                        " / " +
                        found.size +
                        " (" +
                        found.usedPercent.toString() +
                        "%)",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }
        }
        return const MintYProgressIndicatorCircle();
      },
    );
  }
}
