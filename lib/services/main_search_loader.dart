import 'package:flutter/material.dart';
import 'package:linux_helper/layouts/main_search.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/models/action_entry_list.dart';
import 'package:linux_helper/models/enviroment.dart';
import 'package:linux_helper/services/config_handler.dart';
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

  Future<ActionEntryList> prepare() async {
    // prepare config
    ConfigHandler configHandler = ConfigHandler();
    await configHandler.loadConfigFromFile();

    // Load environment
    Map<String, dynamic> environmentMap =
        configHandler.getValueUnsafe("environment", <String, dynamic>{});
    if (environmentMap.isEmpty) {
      Environment environment = await Linux.getCurrentEnviroment();
      Linux.currentEnviroment = environment;
      configHandler.setValue("environment", environment.toJson());
    } else {
      Linux.currentEnviroment = Environment.fromJson(environmentMap);
    }

    print(Linux.currentEnviroment.toJson());

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
