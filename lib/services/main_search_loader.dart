import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_helper/enums/browsers.dart';
import 'package:linux_helper/layouts/action_entry_card.dart';
import 'package:linux_helper/layouts/main_search.dart';
import 'package:linux_helper/layouts/recommendation_card.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/models/action_entry_list.dart';
import 'package:linux_helper/services/action_handler.dart';
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
    ActionEntry("Systeminformation", "Linux Mint 20.3 Cinnamon",
        "open_systeminformation"),
    ActionEntry("Update", "TestBeschreibung", ""),
    ActionEntry("Apps", "TestBeschreibung", ""),
    ActionEntry("Health", "TestBeschreibung", ""),
    ActionEntry("Security", "TestBeschreibung", ""),
    ActionEntry("Driver", "TestBeschreibung", ""),
    ActionEntry("Desktop", "TestBeschreibung", ""),
    ActionEntry("Printer", "TestBeschreibung", ""),
  ];

  Future<ActionEntryList> prepareActionEntries() async {
    ActionEntryList returnValue = ActionEntryList(entries: []);
    returnValue.entries.addAll(basicEntries);
    var folderEntries = await Linux.getAllFolderEntriesOfUser();
    returnValue.entries.addAll(folderEntries);
    var applicationEntries = await Linux.getAllAvailableApplications();
    returnValue.entries.addAll(applicationEntries);
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    futureActionEntryList = prepareActionEntries();
    return FutureBuilder<ActionEntryList>(
      future: futureActionEntryList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (MainSearch(actionEntries: snapshot.data!.entries));
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 80,
                  width: 80,
                )
              ],
            ),
          );
        }
      },
    );
  }
}
