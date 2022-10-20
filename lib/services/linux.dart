import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:linux_assistant/enums/browsers.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/enviroment.dart';

class Linux {
  static Environment currentEnviroment = Environment();
  static String executableFolder = "";

  static void runCommand(String command,
      {Map<String, String>? environment}) async {
    List<String> arguments = command.split(' ');
    String exec = arguments.removeAt(0);

    print("Running linux command: " + command);
    var result = await Process.run(exec, arguments,
        runInShell: true, environment: environment);
    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
    }
    print(result.stdout);
  }

  static void runCommandWithCustomArguments(String exec, List<String> arguments,
      {Map<String, String>? environment}) async {
    print("Running linux command: " +
        exec +
        " with arguments: " +
        arguments.toString());
    var result = await Process.run(exec, arguments,
        runInShell: true, environment: environment);
    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
    }
    print(result.stdout);
  }

  static Future<String> runCommandWithCustomArgumentsAndGetStdOut(
      String exec, List<String> arguments,
      {bool getErrorMessages = false, Map<String, String>? environment}) async {
    print("Running linux command: " +
        exec +
        " with arguments: " +
        arguments.toString());
    var result = await Process.run(exec, arguments,
        runInShell: true, environment: environment);

    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
      if (getErrorMessages) {
        String returnValue = result.stderr;
        returnValue += result.stdout;
        return returnValue;
      }
    }
    return (result.stdout);
  }

  static Future<String> runCommandAndGetStdout(String command,
      {Map<String, String>? environment}) async {
    List<String> arguments = command.split(' ');
    String exec = arguments.removeAt(0);
    var result = await Process.run(exec, arguments,
        runInShell: true, environment: environment);
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

  static void openOrInstallWarpinator() async {
    bool does_warpinator_exist = await File("/usr/bin/warpinator").exists();
    if (does_warpinator_exist) {
      runCommand("/usr/bin/warpinator");
      return;
    } else {
      does_warpinator_exist =
          await isSpecificFlatpakInstalled("org.x.Warpinator");
      if (does_warpinator_exist) {
        runCommand("/usr/bin/flatpak run org.x.Warpinator");
        return;
      }
    }
    // if no warpinator is installed at all:
    installApplication("warpinator");
  }

  static void installApplication(String appCode,
      {SOFTWARE_MANAGERS? preferredSoftwareManager}) async {
    preferredSoftwareManager ??= currentEnviroment.preferredSoftwareManager;

    // Move preferred software manager to the start of the list
    currentEnviroment.installedSoftwareManagers
        .insert(0, preferredSoftwareManager!);
    currentEnviroment.installedSoftwareManagers.removeAt(currentEnviroment
        .installedSoftwareManagers
        .lastIndexOf(preferredSoftwareManager));

    for (SOFTWARE_MANAGERS softwareManager
        in currentEnviroment.installedSoftwareManagers) {
      if (softwareManager == SOFTWARE_MANAGERS.APT) {
        // Check, if package is available:
        String output = await Linux.runCommandAndGetStdout(
            "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} show $appCode");
        if (!output.contains("Package: ")) {
          continue;
        }

        runCommand(
            "pkexec ${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install $appCode -y",
            environment: {"DEBIAN_FRONTEND": "noninteractive"});
        return;
      }

      if (softwareManager == SOFTWARE_MANAGERS.FLATPAK) {
        // Check, if package is available:
        String output = await Linux.runCommandAndGetStdout(
            "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} search $appCode");
        if (output.split("\n").length != 2) {
          continue;
        }

        String repo = output.split("\t").last.replaceAll("\n", "");

        runCommand(
            "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} install $repo $appCode --system -y --noninteractive");
        return;
      }

      if (softwareManager == SOFTWARE_MANAGERS.SNAP) {
        // Check, if package is available:
        String output = await Linux.runCommandAndGetStdout(
            "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.SNAP)} info $appCode");
        if (output.split("\n").length < 5) {
          continue;
        }

        runCommand(
            "pkexec ${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.SNAP)} install $appCode");
        return;
      }
    }
  }

  static Future<bool> isSpecificFlatpakInstalled(flatpak_id) async {
    String flatpakList = await runCommandAndGetStdout("/usr/bin/flatpak list");
    return flatpakList.contains(flatpak_id);
  }

  static void openWebbrowserSeach(String searchterm) {
    runCommandWithCustomArguments("firefox", ["--search", searchterm]);
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
    String foldersString = await runCommandWithCustomArgumentsAndGetStdOut(
        "python3",
        ["${executableFolder}additional/python/get_folder_structure.py"]);
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
      ActionEntry entry = ActionEntry(
          name: folderName,
          description: 'Open ' + folder,
          action: "openfolder:" + folder);
      entry.priority = -10;
      actionEntries.add(entry);
    }
    return actionEntries;
  }

  static Future<List<ActionEntry>> getAllAvailableApplications() async {
    String applicationsString =
        await runCommandWithCustomArgumentsAndGetStdOut("python3", [
      "${executableFolder}additional/python/get_applications.py",
      "--lang=${currentEnviroment.language}",
      "--desktop=${currentEnviroment.desktop.toString()}"
    ]);

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
      ActionEntry entry = ActionEntry(
          name: values[1],
          description: values[2],
          action: "openapp:" + values[0]);

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
    String recentFileString = await runCommandWithCustomArgumentsAndGetStdOut(
        "/usr/bin/python3",
        ["${executableFolder}additional/python/get_recent_files.py"]);
    List<String> recentFiles = recentFileString.split("\n");
    List<ActionEntry> actionEntries = [];
    for (String recentFile in recentFiles) {
      String fileName = recentFile.split("/").last;
      ActionEntry actionEntry = ActionEntry(
          name: fileName,
          description: "Open " + recentFile,
          action: "openfile:" + recentFile);
      actionEntry.priority = -15;
      actionEntries.add(actionEntry);
    }
    return actionEntries;
  }

  static Future<Environment> getCurrentEnviroment() async {
    String commandOutput = await runCommandWithCustomArgumentsAndGetStdOut(
        "python3", ["${executableFolder}additional/python/get_enviroment.py"]);
    List<String> lines = commandOutput.split("\n");
    Environment newEnvironment = Environment();

    // get OS:
    if (lines[0].contains("Linux Mint")) {
      newEnvironment.distribution = DISTROS.LINUX_MINT;
    } else if (lines[0].toLowerCase().contains("ubuntu")) {
      newEnvironment.distribution = DISTROS.UBUNTU;
    } else if (lines[0].toLowerCase().contains("debian")) {
      newEnvironment.distribution = DISTROS.DEBIAN;
    }

    // get version:
    newEnvironment.version = double.parse(lines[1]);

    // get desktop:
    if (lines[2].toLowerCase().contains("gnome")) {
      newEnvironment.desktop = DESKTOPS.GNOME;
    } else if (lines[2].toLowerCase().contains("cinnamon")) {
      newEnvironment.desktop = DESKTOPS.CINNAMON;
    } else if (lines[2].toLowerCase().contains("kde")) {
      newEnvironment.desktop = DESKTOPS.KDE;
    } else if (lines[2].toLowerCase().contains("xfce")) {
      newEnvironment.desktop = DESKTOPS.XFCE;
    }

    // get language
    newEnvironment.language = lines[3];

    // get default browser
    if (lines[4].toLowerCase().contains("brave")) {
      newEnvironment.browser = BROWSERS.BRAVE;
    } else if (lines[4].toLowerCase().contains("chrome")) {
      newEnvironment.browser = BROWSERS.CHROME;
    } else if (lines[4].toLowerCase().contains("chromium")) {
      newEnvironment.browser = BROWSERS.CHROMIUM;
    } else if (lines[4].toLowerCase().contains("edge")) {
      newEnvironment.browser = BROWSERS.EDGE;
    } else if (lines[4].toLowerCase().contains("firefox")) {
      newEnvironment.browser = BROWSERS.FIREFOX;
    } else if (lines[4].toLowerCase().contains("opera")) {
      newEnvironment.browser = BROWSERS.OPERA;
    }

    for (int i = 0; i < SOFTWARE_MANAGERS.values.length; i++) {
      if (await File(
              getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.values[i]))
          .exists()) {
        newEnvironment.installedSoftwareManagers
            .add(SOFTWARE_MANAGERS.values[i]);
      }
    }

    return newEnvironment;
  }

  static String getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS input) {
    switch (input) {
      case SOFTWARE_MANAGERS.FLATPAK:
        return "/usr/bin/flatpak";
      case SOFTWARE_MANAGERS.SNAP:
        return "/usr/bin/snap";
      case SOFTWARE_MANAGERS.APT:
        return "/usr/bin/apt";
      default:
        return "";
    }
  }

  // Returns local path when app is run in debug
  static String getExecutableFolder() {
    if (kDebugMode) {
      String pwd = "";
      if (Platform.environment['PWD'] != null) {
        pwd = Platform.environment['PWD']!;
        pwd += "/";
      }
      return pwd;
    }
    String wholePath = Platform.resolvedExecutable;
    List<String> parts = wholePath.split("/");
    parts.removeLast(); // remove executable file
    String returnValue = "/";
    for (String part in parts) {
      returnValue = "${returnValue}/${part}";
    }
    returnValue = "${returnValue}/";
    return returnValue;
  }
}
