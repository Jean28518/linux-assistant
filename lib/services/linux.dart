import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/enums/browsers.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/enviroment.dart';
import 'package:linux_assistant/models/linux_command.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/hashing.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Linux {
  static Environment currentEnviroment = Environment();
  static String executableFolder = "";

  /// Commands in it can be run at once by [Linux.executeCommandQueue()]
  /// or by opening the page "RunCommandQueue"
  static List<LinuxCommand> commandQueue = [];

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
        String returnValue = result.stdout;
        returnValue += result.stderr;
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
    String output = result.stdout.toString() + "\n";
    if (result.stderr is String && !result.stderr.toString().isEmpty) {
      print(result.stderr);
      output += result.stderr.toString();
    }
    return output;
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
    switch (currentEnviroment.distribution) {
      case DISTROS.MXLINUX:
        openUserSettings();
        break;
      default:
    }
    switch (currentEnviroment.desktop) {
      case DESKTOPS.CINNAMON:
        openUserSettings();
        break;
      case DESKTOPS.GNOME:
        openUserSettings();
        break;
      case DESKTOPS.XFCE:
        openUserSettings();
        break;
      default:
    }
  }

  static void openUserSettings() {
    switch (currentEnviroment.distribution) {
      case DISTROS.MXLINUX:
        runCommand("mx-user");
        break;
      default:
    }
    switch (currentEnviroment.desktop) {
      case DESKTOPS.CINNAMON:
        runCommand("cinnamon-settings user");
        break;
      case DESKTOPS.GNOME:
        runCommand("gnome-control-center user-accounts");
        break;
      case DESKTOPS.XFCE:
        runCommand("users-admin");
        break;
      default:
    }
  }

  static void openSystemInformation() {
    switch (currentEnviroment.distribution) {
      case DISTROS.MXLINUX:
        runCommand("quick-system-info-gui");
        break;
      default:
    }
    switch (currentEnviroment.desktop) {
      case DESKTOPS.CINNAMON:
        runCommand("cinnamon-settings info");
        break;
      case DESKTOPS.GNOME:
        runCommand("gnome-control-center info-overview");
        break;
      case DESKTOPS.XFCE:
        runCommand("xfce4-about");
        break;
      default:
    }
  }

  /// [callback] is used for clearing and reoading the search.
  static void openOrInstallWarpinator(
      BuildContext context, VoidCallback callback) async {
    bool does_warpinator_exist = await File("/usr/bin/warpinator").exists();
    if (does_warpinator_exist) {
      runCommand("/usr/bin/warpinator");
      callback();
      return;
    } else {
      does_warpinator_exist =
          await isSpecificFlatpakInstalled("org.x.Warpinator");
      if (does_warpinator_exist) {
        runCommand("/usr/bin/flatpak run org.x.Warpinator");
        callback();
        return;
      }
    }
    // if no warpinator is installed at all:
    await installApplications(["warpinator", "org.x.Warpinator"]);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RunCommandQueue(
          title: "Install Warpinator",
          route: MainSearchLoader(),
          message:
              "Installing Warpinator...\nYou have to reopen the Warpinator entry after."),
    ));
  }

  /// Tries to install one of the appCodes. Stops after one was successfully found.
  /// First elements of the list will be priorized.
  /// Doesn't run the command instantly, only puts the commands in to [Linux.commandQueue].
  static Future<void> installApplications(List<String> appCodes,
      {SOFTWARE_MANAGERS? preferredSoftwareManager}) async {
    preferredSoftwareManager ??= currentEnviroment.preferredSoftwareManager;

    // Move preferred software manager to the start of the list
    currentEnviroment.installedSoftwareManagers
        .insert(0, preferredSoftwareManager!);
    currentEnviroment.installedSoftwareManagers.removeAt(currentEnviroment
        .installedSoftwareManagers
        .lastIndexOf(preferredSoftwareManager));

    for (String appCode in appCodes) {
      for (SOFTWARE_MANAGERS softwareManager
          in currentEnviroment.installedSoftwareManagers) {
        if (softwareManager == SOFTWARE_MANAGERS.APT) {
          // Check, if package is available:
          bool available = await isDebPackageAvailable(appCode);
          if (!available) {
            continue;
          }

          commandQueue.add(
            LinuxCommand(
              command:
                  "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install $appCode -y",
              userId: 0,
              environment: {"DEBIAN_FRONTEND": "noninteractive"},
            ),
          );
          return;
        }

        if (softwareManager == SOFTWARE_MANAGERS.FLATPAK) {
          // Check, if package is available:
          String repo = await isFlatpakAvailable(appCode);
          if (repo == "") {
            continue;
          }

          commandQueue.add(
            LinuxCommand(
              command:
                  "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} install $repo $appCode --system -y --noninteractive",
              userId: currentEnviroment.currentUserId,
            ),
          );
          return;
        }

        if (softwareManager == SOFTWARE_MANAGERS.SNAP) {
          // Check, if package is available:
          bool available = await isSnapAvailable(appCode);
          if (!available) {
            continue;
          }

          commandQueue.add(
            LinuxCommand(
              command:
                  "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.SNAP)} install $appCode",
              userId: 0,
              environment: {"DEBIAN_FRONTEND": "noninteractive"},
            ),
          );
          return;
        }
      }
    }
  }

  static Future<bool> isSpecificFlatpakInstalled(String appCode) async {
    // Only accept appCodes with two '.' in it. Example: 'com.example.app'
    if (".".allMatches(appCode).length != 2) {
      return false;
    }
    String flatpakList = await runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} list --columns=application");
    return flatpakList.toLowerCase().contains(appCode.toLowerCase());
  }

  static Future<bool> isSpecificDebPackageInstalled(appCode) async {
    String output = await runCommandAndGetStdout("/usr/bin/dpkg -l $appCode");
    return output.contains("ii  $appCode");
  }

  static Future<bool> isSpecificSnapInstalled(appCode) async {
    String output = await runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.SNAP)} info $appCode");
    return output.contains("installed: ");
  }

  /// Tries to uninstall all appCodes.
  /// If you don't specify the softwareManager it will be tried to remove the application with all Software Managers
  static Future<void> removeApplications(List<String> appCodes,
      {SOFTWARE_MANAGERS? softwareManager}) async {
    for (String appCode in appCodes) {
      // Deb Package
      bool isDebianPackageInstalled =
          await isSpecificDebPackageInstalled(appCode);
      if ((softwareManager == null ||
              softwareManager == SOFTWARE_MANAGERS.APT) &&
          isDebianPackageInstalled) {
        commandQueue.add(
          LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} remove $appCode -y",
            environment: {"DEBIAN_FRONTEND": "noninteractive"},
          ),
        );
      }

      // Flatpak
      bool isFlatpakInstalled = await isSpecificFlatpakInstalled(appCode);
      print(isFlatpakInstalled);
      if ((softwareManager == null ||
              softwareManager == SOFTWARE_MANAGERS.FLATPAK) &&
          isFlatpakInstalled) {
        commandQueue.add(
          LinuxCommand(
            userId: currentEnviroment.currentUserId,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} remove $appCode -y --noninteractive",
          ),
        );
      }

      // Snap
      bool isSnapInstalled = await isSpecificSnapInstalled(appCode);
      if ((softwareManager == null ||
              softwareManager == SOFTWARE_MANAGERS.SNAP) &&
          isSnapInstalled) {
        commandQueue.add(
          LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.SNAP)} remove $appCode",
          ),
        );
      }
    }
  }

  // Returns true, if one of these application is installed.
  static Future<bool> areApplicationsInstalled(List<String> appCodes) async {
    if (currentEnviroment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.APT)) {
      for (String appCode in appCodes) {
        bool isDebianPackageInstalled =
            await isSpecificDebPackageInstalled(appCode);
        if (isDebianPackageInstalled) {
          return true;
        }
      }
    }
    if (currentEnviroment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.FLATPAK)) {
      for (String appCode in appCodes) {
        bool isFlatpakInstalled = await isSpecificFlatpakInstalled(appCode);
        if (isFlatpakInstalled) {
          return true;
        }
      }
    }
    if (currentEnviroment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.SNAP)) {
      for (String appCode in appCodes) {
        bool isSnapInstalled = await isSpecificSnapInstalled(appCode);
        if (isSnapInstalled) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<bool> isDebPackageAvailable(String appCode) async {
    String output = await runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} show $appCode");
    return output.contains("Package: ") &&
        !output.contains("No packages found");
  }

  /// returns the source under which the Flatpak is available, otherwise empty String
  static Future<String> isFlatpakAvailable(String appCode) async {
    String output = await Linux.runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} search $appCode");
    if (output.split("\n").length == 2) {
      return output.split("\t").last.replaceAll("\n", "");
    }
    return "";
  }

  static Future<bool> isSnapAvailable(String appCode) async {
    String output = await Linux.runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.SNAP)} info $appCode");
    return output.split("\n").length > 5;
  }

  /// returns true, if at least one of the app codes is available
  static Future<bool> areApplicationsAvailable(List<String> appCodes) async {
    for (String appCode in appCodes) {
      bool available = await isDebPackageAvailable(appCode);
      if (available) {
        return true;
      }
      available = await isSnapAvailable(appCode);
      if (available) {
        return true;
      }
      String repo = await isFlatpakAvailable(appCode);
      if (repo != "") {
        return true;
      }
    }
    return false;
  }

  /// If [installed] == false, it will be ensured that the app is not installed on the system
  /// If [installed] == true, it will be ensured that the app will be installed on the system
  ///
  /// Tries to install at least one appCode in [appCodes] or tries to remove all appCodes
  /// Doesn't run the command instantly, only puts the commands in to the commandQueue.
  static Future<void> ensureApplicationInstallation(List<String> appCodes,
      {bool installed = true}) async {
    bool initial = await areApplicationsInstalled(appCodes);
    print("App: $appCodes initial: $initial installed: $installed");
    if (installed && !initial) {
      await installApplications(appCodes);
    } else if (!installed && initial) {
      await removeApplications(appCodes);
    }
  }

  /// After calling this function the command queue should be run
  static Future<void> setUpFlatpak() async {
    await ensureApplicationInstallation(["flatpak"]);
    commandQueue.add(LinuxCommand(
        userId: 0,
        command:
            "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"));
    // We set this temporally to easily add flatpaks to the system. It will be written to config at next startup (if the installation of flatpak really succeded)
    Linux.currentEnviroment.installedSoftwareManagers
        .add(SOFTWARE_MANAGERS.FLATPAK);
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

  static Future<List<ActionEntry>> getAllFolderEntriesOfUser(
      BuildContext context) async {
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
          if (!bookmark.endsWith("/")) {
            bookmark = "$bookmark/";
          }
          String folder = bookmark.replaceFirst("file://", "");

          // Sometimes broken bookmarks are also available at systems. Filter them out.
          if (Directory(folder).existsSync()) {
            folders.add(folder);
          }
        }
      }
    }

    List<ActionEntry> actionEntries = [];
    for (String folder in folders) {
      List<String> elements = folder.split("/");
      if (elements.length < 2) {
        continue;
      }
      String folderName = elements[elements.length - 1];
      if (folderName.trim() == "") {
        folderName = elements[elements.length - 2];
      }
      ActionEntry entry = ActionEntry(
          name: folderName,
          description: AppLocalizations.of(context)!.openX + " " + folder,
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
    for (String applicationString in applications) {
      List<String> values = applicationString.split('\t');

      if (values.length < 3) {
        continue;
      }

      String app_id = values[0].split("/").last.replaceAll(".desktop", "");

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

  static Future<List<ActionEntry>> getRecentFiles(BuildContext context) async {
    String recentFileString = await runCommandWithCustomArgumentsAndGetStdOut(
        "/usr/bin/python3",
        ["${executableFolder}additional/python/get_recent_files.py"]);
    List<String> recentFiles = recentFileString.split("\n");
    List<ActionEntry> actionEntries = [];
    for (String recentFile in recentFiles) {
      String fileName = recentFile.split("/").last;
      ActionEntry actionEntry = ActionEntry(
          name: fileName,
          description: AppLocalizations.of(context)!.openX + " " + recentFile,
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
    } else if (lines[0].toLowerCase().contains("mxlinux")) {
      newEnvironment.distribution = DISTROS.MXLINUX;
    } else if (lines[0].toLowerCase().contains("pop!_os")) {
      newEnvironment.distribution = DISTROS.POPOS;
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

    // Get user id
    String output = await Linux.getUserIdOfCurrentUser();
    newEnvironment.currentUserId = int.parse(output);

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

  static void installMultimediaCodecs() async {
    switch (currentEnviroment.distribution) {
      case DISTROS.DEBIAN:
      case DISTROS.MXLINUX:
        // await Linux.runCommandAndGetStdout(
        //     "pkexec /usr/bin/apt-add-repository contrib");
        // await Linux.runCommandAndGetStdout(
        //     "pkexec ${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} update");
        // await Linux.runCommandAndGetStdout(
        //     "pkexec ${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install vlc libavcodec-extra libdvd-pkg -y",
        //     environment: {"DEBIAN_FRONTEND": "noninteractive"});

        // Currently do not add other repositories without warning, so we won't install libdvd-pkg
        commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install vlc libavcodec-extra -y",
            environment: {"DEBIAN_FRONTEND": "noninteractive"}));
        break;
      case DISTROS.LINUX_MINT:
        commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install mint-meta-codecs -y",
            environment: {"DEBIAN_FRONTEND": "noninteractive"}));
        break;
      case DISTROS.UBUNTU:
      case DISTROS.POPOS:
        commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install ubuntu-restricted-extras -y",
            environment: {"DEBIAN_FRONTEND": "noninteractive"}));
        break;

      default:
    }
  }

  /// Python script has to be in the additional/python folder.
  /// Example: [filename] = example.py
  static Future<String> runPythonScript(String filename,
      {bool root = false,
      List<String> arguments = const [],
      bool getErrorMessages = true}) async {
    List<String> commandList = [];
    String executable = "";
    if (root) {
      executable = "pkexec";
      commandList.add("/usr/bin/python3");
    } else {
      executable = "/usr/bin/python3";
    }
    commandList.add("${executableFolder}additional/python/$filename");

    commandList.addAll(arguments);

    return runCommandWithCustomArgumentsAndGetStdOut(executable, commandList,
        getErrorMessages: getErrorMessages);
  }

  static Future<bool> isNvidiaCardInstalledOnSystem() async {
    String output = await runCommandAndGetStdout("lshw");
    output = output.toLowerCase();
    return output.contains("nvidia");
  }

  static Future<bool> isNouveauCurrentGraphicsDriver() async {
    String output = await runCommandAndGetStdout("lspci -nnk");
    output = output.toLowerCase();
    return output.contains("kernel driver in use: nouveau");
  }

  /// Puts all commands into [Linux.commandQueue]
  static void applyAutomaticConfigurationAfterInstallation(
      {bool installMultimediaCodecs_ = true,
      bool setupAutomaticSnapshots = true,
      bool installNvidiaDriversAutomatically = true,
      bool setupAutomaticUpdates = true}) async {
    if (installMultimediaCodecs_) {
      installMultimediaCodecs();
    }
    if (setupAutomaticSnapshots) {
      commandQueue.add(LinuxCommand(
          userId: 0,
          command:
              "python3 ${executableFolder}additional/python/setup_automatic_snapshots.py"));
    }
    if (installNvidiaDriversAutomatically) {
      commandQueue.add(LinuxCommand(
          userId: 0,
          command:
              "python3 ${executableFolder}additional/python/install_nvidia_driver.py"));
    }
    if (setupAutomaticUpdates) {
      commandQueue.add(LinuxCommand(
          userId: 0,
          command:
              "python3 ${executableFolder}additional/python/setup_automatic_updates.py"));
    }
  }

  static Future<List<ActionEntry>> getFavoriteFiles(
      BuildContext context) async {
    String output = await runPythonScript("get_favorite_files.py");
    output = output.trim();
    List<String> list = output.split("\n");

    List<ActionEntry> actionEntries = [];
    for (String e in list) {
      String fileName = e.split("/").last;
      ActionEntry actionEntry = ActionEntry(
          name: fileName,
          description: AppLocalizations.of(context)!.openX + " " + e,
          action: "openfile:" + e);
      actionEntry.priority = -5;
      actionEntries.add(actionEntry);
    }
    return actionEntries;
  }

  static Future<String> executeCommandQueue() async {
    if (commandQueue.length == 0) {
      return "No actions in queue.";
    }

    String string = "";
    for (LinuxCommand command in commandQueue) {
      String line = "\"${command.userId}\";\"${command.command}\";";
      command.environment?.forEach((key, value) {
        line += "\"$key='$value'\";";
      });
      string += "$line\n";
    }

    // Example of a line:
    // "0";"apt update";"DEBIAN_NONINTERACTIVE='true'";
    commandQueue.clear();

    String checksum = Hashing.getMd5OfString(string);

    File file = File('/tmp/linux_assistant_commands');
    file.writeAsString(string);

    String output = await runPythonScript("run_multiple_commands.py",
        arguments: ["--md5=$checksum"], root: true);

    return output;
  }

  static Future<String> getUserIdOfCurrentUser() {
    return Linux.runCommandAndGetStdout("id -u");
  }

  /// Only returns results if keyword is longer than 3 and there are under 100 results.
  static Future<List<ActionEntry>> getInstallableAptPackagesForKeyword(
      String keyword) async {
    if (keyword.length <= 3) {
      return [];
    }
    String output = await runPythonScript("search_available_apt_packages.py",
        arguments: ["--keyword='$keyword'"], getErrorMessages: false);
    output = output.trim();
    List<String> lines = output.split("\n");

    // Cancel search, if too many search results.
    if (lines.length > 100) {
      return [];
    }

    List<ActionEntry> results = [];
    for (String line in lines) {
      if (line.trim() == "") {
        continue;
      }
      results.add(ActionEntry(
          iconWidget: Icon(
            Icons.archive,
            size: 48,
          ),
          name: "Install $line",
          description: "Install via apt",
          action: "apt-install:$line",
          priority: -20));
    }
    return results;
  }

  static Future<Environment> recognizeEnvironmentFirstInitialization() async {
    ConfigHandler configHandler = ConfigHandler();
    Environment environment = await Linux.getCurrentEnviroment();
    Linux.currentEnviroment = environment;
    configHandler.setValue("environment", environment.toJson());
    return environment;
  }

  static Future<void> updateEnvironmentAtNormalStartUp() async {
    Environment environment = await Linux.getCurrentEnviroment();
    Linux.currentEnviroment.browser = environment.browser;
    Linux.currentEnviroment.currentUserId = environment.currentUserId;
    Linux.currentEnviroment.desktop = environment.desktop;
    Linux.currentEnviroment.installedSoftwareManagers =
        environment.installedSoftwareManagers;

    ConfigHandler configHandler = ConfigHandler();
    configHandler.setValue("environment", Linux.currentEnviroment.toJson());

    bool nvidiaCardInstalled = await isNvidiaCardInstalledOnSystem();
    bool nouveauRunning = await isNouveauCurrentGraphicsDriver();
    currentEnviroment.nvidiaCardAndNouveauRunning =
        nvidiaCardInstalled && nouveauRunning;
  }

  /// Returns new list of found folder entries.
  static List<ActionEntry> getFoldersOfActionEntries(
      BuildContext context, List<ActionEntry> currentEntries) {
    List<String> allPaths = [];

    currentEntries.forEach((element) {
      if (element.action.startsWith("openfile:")) {
        String path = element.action.replaceFirst("openfile:", "");
        List<String> singleFolders = path.split("/");
        singleFolders.removeLast(); // We don't need the filename.

        // Build every path.
        for (int i = 0; i < singleFolders.length; i++) {
          String path = "/";
          for (int j = 0; j <= i; j++) {
            if ((singleFolders[j] != "")) {
              path += "${singleFolders[j]}/";
            }
          }
          if (!allPaths.contains(path)) {
            allPaths.add(path);
          }
        }
      }
    });

    List<ActionEntry> newEntries = [];
    allPaths.forEach((path) {
      List<String> elements = path.split("/");
      if (elements.length > 1) {
        String name = elements[elements.length - 2];
        ActionEntry newEntry = ActionEntry(
            name: name,
            description: AppLocalizations.of(context)!.openX + " $path",
            action: "openfolder:$path",
            priority: -10.0);
        newEntries.add(newEntry);
      }
    });
    return newEntries;
  }
}
