import 'dart:io';

import 'package:linux_helper/enums/browsers.dart';
import 'package:linux_helper/enums/desktops.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/models/enviroment.dart';

class Linux {
  static Enviroment currentEnviroment = Enviroment();

  static void runCommand(String command) async {
    List<String> arguments = command.split(' ');
    String exec = arguments.removeAt(0);

    print("Running linux command: " + command);
    var result = await Process.run(exec, arguments, runInShell: true);
    if (result.stderr is String) {
      print(result.stderr);
    }
    print(result.stdout);
  }

  static Future<String> runCommandAndGetStdout(String command) async {
    List<String> arguments = command.split(' ');
    String exec = arguments.removeAt(0);
    var result = await Process.run(exec, arguments, runInShell: true);
    if (result.stderr is String) {
      print(result.stderr);
    }
    return (result.stdout);
  }

  static void changeUserPasswordDialog() {
    switch (currentEnviroment.desktop) {
      case DESKTOPS.CINNAMON:
        openUserSettings();
        break;
      default:
    }
  }

  static void openUserSettings() {
    switch (currentEnviroment.desktop) {
      case DESKTOPS.CINNAMON:
        runCommand("cinnamon-settings user");
        break;
      default:
    }
  }

  static void openSystemInformation() {
    switch (currentEnviroment.desktop) {
      case DESKTOPS.CINNAMON:
        runCommand("cinnamon-settings info &");
        break;
      default:
    }
  }

  static void openWebbrowserSeach(String searchterm) {
    runCommand("firefox --search '" + searchterm + "'");
  }

  static void openWebbrowserWithSite(String website) {
    assert(Uri.parse(website).isAbsolute);
    runCommand(getWebbrowserCommand(currentEnviroment.browser) + " " + website);
  }

  static String getWebbrowserCommand(var browser) {
    switch (browser) {
      case BROWSERS.FIREFOX:
        return "firefox";
      case BROWSERS.CHROMIUM:
        return "chromium";
      default:
        return "#";
    }
  }

  static Future<List<ActionEntry>> getAllFolderEntriesOfUser() async {
    String foldersString =
        await runCommandAndGetStdout("python3 python/get_folder_structure.py");
    List<String> folders = foldersString.split('\n');
    List<ActionEntry> actionEntries = [];
    for (String folder in folders) {
      String folderName = folder.split('/').last;
      ActionEntry entry =
          ActionEntry(folderName, 'Open ' + folder, "openfolder:" + folder);
      actionEntries.add(entry);
    }
    return actionEntries;
  }
}
