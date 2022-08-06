import 'dart:io';

import 'package:linux_helper/enums/browsers.dart';
import 'package:linux_helper/enums/desktops.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/models/enviroment.dart';

class Linux {
  static Environment currentEnviroment = Environment();

  static void runCommand(String command) async {
    List<String> arguments = command.split(' ');
    String exec = arguments.removeAt(0);

    print("Running linux command: " + command);
    var result = await Process.run(exec, arguments, runInShell: true);
    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
    }
    print(result.stdout);
  }

  static void runCommandWithCustomArguments(
      String exec, List<String> arguments) async {
    print("Running linux command: " +
        exec +
        " with arguments: " +
        arguments.toString());
    var result = await Process.run(exec, arguments, runInShell: true);
    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
    }
    print(result.stdout);
  }

  static void runCommandWithCustomArgumentsAndGetStdOut(
      String exec, List<String> arguments) async {
    print("Running linux command: " +
        exec +
        " with arguments: " +
        arguments.toString());
    var result = await Process.run(exec, arguments, runInShell: true);
    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
    }
    return (result.stdout);
  }

  static Future<String> runCommandAndGetStdout(String command) async {
    List<String> arguments = command.split(' ');
    String exec = arguments.removeAt(0);
    var result = await Process.run(exec, arguments, runInShell: true);
    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
    }
    return (result.stdout);
  }

  static String getHomeDirectory() {
    String? home = Platform.environment["HOME"];
    if (home != null) {
      if (!home.endsWith("/")) {
        home += "/";
      }
      return home;
    } else {
      return "";
    }
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

    // Get Bookmarks:
    if (currentEnviroment.desktop != DESKTOPS.KDE) {
      String home = await getHomeDirectory();
      String bookmarksLocation = home + "/.config/gtk-3.0/bookmarks";
      String bookmarksString =
          await runCommandAndGetStdout("cat " + bookmarksLocation);
      List<String> bookmarkCandidates = bookmarksString.split("\n");
      for (String bookmarkCandidate in bookmarkCandidates) {
        String bookmark = bookmarkCandidate.split(" ")[0];
        if (bookmark.startsWith("file://")) {
          folders.add(bookmark.replaceFirst("file://", ""));
        }
      }
    }

    List<ActionEntry> actionEntries = [];
    for (String folder in folders) {
      String folderName = folder.split('/').last;
      ActionEntry entry =
          ActionEntry(folderName, 'Open ' + folder, "openfolder:" + folder);
      entry.priority = -10;
      actionEntries.add(entry);
    }
    return actionEntries;
  }

  static Future<List<ActionEntry>> getAllAvailableApplications() async {
    String applicationsString = await runCommandAndGetStdout(
        "python3 python/get_applications.py " +
            "--lang=" +
            currentEnviroment.language +
            " --desktop=" +
            getStringOfDesktopEnum(currentEnviroment.desktop));
    List<String> applications = applicationsString.split('\n');
    List<ActionEntry> actionEntries = [];
    List<String> filter = _getApplicationEntryFilter();
    for (String applicationString in applications) {
      List<String> values = applicationString.split('\t');

      if (values.length < 3) {
        continue;
      }

      String app_id = values[0].split("/").last.replaceAll(".desktop", "");
      // Apply Filter:
      if (filter.contains(app_id)) {
        continue;
      }
      ActionEntry entry =
          ActionEntry(values[1], values[2], "openapp:" + values[0]);

      if (values.length >= 4) {
        entry.iconURI = values[3];
      }

      if (values.length >= 5) {
        entry.keywords = values[4].split(';');
      }
      entry.priority = -5;
      actionEntries.add(entry);
    }
    return actionEntries;
  }

  static List<String> _getApplicationEntryFilter() {
    // Add here the filename of the desktop files (without .desktop)
    List<String> filter = [];

    // ---------------------------------------------------------------------- //
    return filter;
  }

  static Future<List<ActionEntry>> getRecentFiles() async {
    String recentFileString =
        await runCommandAndGetStdout("python3 python/get_recent_files_2.py");
    List<String> recentFiles = recentFileString.split("\n");
    List<ActionEntry> actionEntries = [];
    for (String recentFile in recentFiles) {
      String fileName = recentFile.split("/").last;
      ActionEntry actionEntry =
          ActionEntry(fileName, "Open " + recentFile, "openfile:" + recentFile);
      actionEntries.add(actionEntry);
    }
    return actionEntries;
  }
}
