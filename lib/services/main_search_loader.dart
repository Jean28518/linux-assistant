import 'package:flutter/material.dart';
import 'package:linux_helper/enums/desktops.dart';
import 'package:linux_helper/enums/distros.dart';
import 'package:linux_helper/layouts/loading_indicator.dart';
import 'package:linux_helper/layouts/main_search.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/models/action_entry_list.dart';
import 'package:linux_helper/services/linux.dart';

class MainSearchLoader extends StatefulWidget {
  const MainSearchLoader({Key? key}) : super(key: key);

  @override
  State<MainSearchLoader> createState() => _MainSearchLoaderState();
}

class _MainSearchLoaderState extends State<MainSearchLoader> {
  late Future<ActionEntryList> futureActionEntryList;

  List<ActionEntry> basicEntries = [
    ActionEntry(
        "Password", "Change password of current user", "change_user_password"),
    ActionEntry("User Profile", "Change userdetails", "open_usersettings"),
    ActionEntry(
        "System information",
        "${getNiceStringOfDistrosEnum(Linux.currentEnviroment.distribution)} ${Linux.currentEnviroment.version.toString()} ${getNiceStringOfDesktopsEnum(Linux.currentEnviroment.desktop)}",
        "open_systeminformation"),
    ActionEntry("Update", "coming soon...", ""),
    ActionEntry("Health", "coming soon...", ""),
    ActionEntry("Security", "coming soon...", ""),
    ActionEntry("Driver", "coming soon...", ""),
    ActionEntry("Desktop", "coming soon...", ""),
    ActionEntry("Printer", "coming soon...", ""),
    ActionEntry(
        "Send files",
        "Send files to another device in the local network by using warpinator",
        "send_files_via_warpinator"),
  ];

  Future<ActionEntryList> prepare() async {
    // prepare Action Entries
    ActionEntryList returnValue = ActionEntryList(entries: []);
    returnValue.entries.addAll(basicEntries);
    var folderEntries = await Linux.getAllFolderEntriesOfUser();
    returnValue.entries.addAll(folderEntries);
    var applicationEntries = await Linux.getAllAvailableApplications();
    returnValue.entries.addAll(applicationEntries);
    var recentFiles = await Linux.getRecentFiles();
    returnValue.entries.addAll(recentFiles);
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    futureActionEntryList = prepare();
    return FutureBuilder<dynamic>(
      future: futureActionEntryList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (MainSearch(actionEntries: snapshot.data!.entries));
        } else {
          return LoadingIndicator(text: "Preparing search...");
        }
      },
    );
  }
}
