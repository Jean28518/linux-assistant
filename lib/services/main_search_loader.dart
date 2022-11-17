import 'package:flutter/material.dart';
import 'package:linux_assistant/content/basic_entries.dart';
import 'package:linux_assistant/content/recommendations.dart';
import 'package:linux_assistant/layouts/loading_indicator.dart';
import 'package:linux_assistant/layouts/main_search.dart';
import 'package:linux_assistant/models/action_entry_list.dart';
import 'package:linux_assistant/services/linux.dart';

class MainSearchLoader extends StatefulWidget {
  const MainSearchLoader({Key? key}) : super(key: key);

  @override
  State<MainSearchLoader> createState() => _MainSearchLoaderState();
}

class _MainSearchLoaderState extends State<MainSearchLoader> {
  late Future<ActionEntryList> futureActionEntryList;

  Future<ActionEntryList> prepare() async {
    // rescan regular environment
    Linux.updateEnvironmentAtNormalStartUp();

    // prepare Action Entries
    ActionEntryList returnValue = ActionEntryList(entries: []);
    returnValue.entries.addAll(recommendations);
    returnValue.entries.addAll(basicEntries);
    var folderEntries = await Linux.getAllFolderEntriesOfUser();
    returnValue.entries.addAll(folderEntries);
    var applicationEntries = await Linux.getAllAvailableApplications();
    returnValue.entries.addAll(applicationEntries);
    var recentFiles = await Linux.getRecentFiles();
    returnValue.entries.addAll(recentFiles);
    var favoriteFiles = await Linux.getFavoriteFiles();
    returnValue.entries.addAll(favoriteFiles);
    var additionalFolders =
        Linux.getFoldersOfActionEntries(returnValue.entries);
    returnValue.entries.addAll(additionalFolders);

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
