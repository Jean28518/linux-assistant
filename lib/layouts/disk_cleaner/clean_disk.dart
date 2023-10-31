import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/disk_cleaner/clean_timeshift.dart';
import 'package:linux_assistant/layouts/disk_cleaner/biggest_folders.dart';
import 'package:linux_assistant/layouts/disk_cleaner/remove_software.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
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
        // Remove software
        if (mountpoint == "/")
          Text(
            AppLocalizations.of(context)!.removeSoftware,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        if (mountpoint == "/")
          SizedBox(
            height: 500,
            width: MediaQuery.of(context).size.width - 50,
            child: RemoveSoftwareWidget(
                routeAfterRemoval: CleanDiskPage(mountpoint: mountpoint)),
          ),
        // Timeshift
        if (Directory('$mountpoint/timeshift/snapshots/').existsSync())
          Text(
            "Timeshift",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        if (Directory('$mountpoint/timeshift/snapshots/').existsSync())
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width - 50,
            child: TimeshiftCleanWidget(
              routeAfterRemoval: CleanDiskPage(mountpoint: mountpoint),
              mountpoint: mountpoint,
            ),
          )
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButton(
            text: Text(AppLocalizations.of(context)!.back,
                style: MintY.heading4White),
            color: MintY.currentColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
