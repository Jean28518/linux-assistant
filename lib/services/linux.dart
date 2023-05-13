import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/browsers.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/environment.dart';
import 'package:linux_assistant/models/linux_command.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/hashing.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Linux {
  static Environment currentenvironment = Environment();
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
    switch (currentenvironment.distribution) {
      case DISTROS.MXLINUX:
        openUserSettings();
        break;
      default:
    }
    switch (currentenvironment.desktop) {
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
    switch (currentenvironment.distribution) {
      case DISTROS.MXLINUX:
        runCommand("mx-user");
        break;
      default:
    }
    switch (currentenvironment.desktop) {
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
    switch (currentenvironment.distribution) {
      case DISTROS.MXLINUX:
        runCommand("quick-system-info-gui");
        break;
      default:
    }
    switch (currentenvironment.desktop) {
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
          title: AppLocalizations.of(context)!.installX("Warpinator"),
          route: MainSearchLoader(),
          message: AppLocalizations.of(context)!
              .installingXDescription("Warpinator")),
    ));
  }

  /// [callback] is used for clearing and reoading the search.
  static void openOrInstallHardInfo(
      BuildContext context, VoidCallback callback) async {
    bool does_app_exist = await File("/usr/bin/hardinfo").exists();
    if (does_app_exist) {
      runCommand("/usr/bin/hardinfo");
      callback();
      return;
    } else {
      // if app is not installed:
      await installApplications(["hardinfo"]);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RunCommandQueue(
            title: AppLocalizations.of(context)!.installX("HardInfo"),
            route: MainSearchLoader(),
            message: AppLocalizations.of(context)!
                .installingXDescription("HardInfo")),
      ));
    }
  }

  /// [callback] is used for clearing and reoading the search.
  static void openOrInstallRedshift(
      BuildContext context, VoidCallback callback) async {
    bool does_app_exist = File("/usr/bin/redshift-gtk").existsSync();
    if (does_app_exist) {
      MintY.showMessage(context,
          AppLocalizations.of(context)!.redshiftIsInstalledAlready, callback);

      return;
    } else {
      // if app is not installed:
      await installApplications(["redshift-gtk"]);
      if (currentenvironment.desktop == DESKTOPS.KDE) {
        await installApplications(["plasma-applet-redshift-control"]);
      }
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RunCommandQueue(
            title: AppLocalizations.of(context)!.installX("Redshift"),
            route: MainSearchLoader(),
            message: AppLocalizations.of(context)!
                .installingXDescription("Redshift")),
      ));
    }
  }

  /// Tries to install one of the appCodes. Stops after one was successfully found.
  /// First elements of the list will be priorized.
  /// Doesn't run the command instantly, only puts the commands in to [Linux.commandQueue].
  static Future<void> installApplications(List<String> appCodes,
      {SOFTWARE_MANAGERS? preferredSoftwareManager}) async {
    preferredSoftwareManager ??= currentenvironment.preferredSoftwareManager;

    // Move preferred software manager to the start of the list
    currentenvironment.installedSoftwareManagers
        .insert(0, preferredSoftwareManager);
    currentenvironment.installedSoftwareManagers.removeAt(currentenvironment
        .installedSoftwareManagers
        .lastIndexOf(preferredSoftwareManager));

    for (String appCode in appCodes) {
      for (SOFTWARE_MANAGERS softwareManager
          in currentenvironment.installedSoftwareManagers) {
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

        if (softwareManager == SOFTWARE_MANAGERS.ZYPPER) {
          // Check, if package is available:
          bool available = await isZypperPackageAvailable(appCode);
          if (!available) {
            continue;
          }

          commandQueue.add(
            LinuxCommand(
              command:
                  "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive install $appCode",
              userId: 0,
              environment: {},
            ),
          );
          return;
        }

        if (softwareManager == SOFTWARE_MANAGERS.FLATPAK) {
          print("!228");
          // Check, if package is available:
          String repo = await isFlatpakAvailable(appCode);
          print("Repo: $repo");
          if (repo == "") {
            continue;
          }

          commandQueue.add(
            LinuxCommand(
              command:
                  "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} install $repo $appCode --system -y --noninteractive",
              userId: 0,
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
    if (!currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.APT)) {
      return false;
    }
    String output = await runCommandAndGetStdout("/usr/bin/dpkg -l $appCode");
    return output.contains("ii  $appCode");
  }

  static Future<bool> isSpecificZypperPackageInstalled(appCode) async {
    if (!currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.ZYPPER)) {
      return false;
    }
    String output = await runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive info $appCode",
        environment: {"LC_ALL": "C"});
    return output.replaceAll(" ", "").contains("Installed:Yes");
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

      // Zypper
      bool isZypperPackageInstalled =
          await isSpecificZypperPackageInstalled(appCode);
      if ((softwareManager == null ||
              softwareManager == SOFTWARE_MANAGERS.ZYPPER) &&
          isZypperPackageInstalled) {
        commandQueue.add(
          LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive remove $appCode",
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
            userId: currentenvironment.currentUserId,
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
    if (currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.APT)) {
      for (String appCode in appCodes) {
        bool isDebianPackageInstalled =
            await isSpecificDebPackageInstalled(appCode);
        if (isDebianPackageInstalled) {
          return true;
        }
      }
    }
    if (currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.ZYPPER)) {
      for (String appCode in appCodes) {
        bool isZypperPackageInstalled =
            await isSpecificZypperPackageInstalled(appCode);
        if (isZypperPackageInstalled) {
          return true;
        }
      }
    }
    if (currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.FLATPAK)) {
      for (String appCode in appCodes) {
        bool isFlatpakInstalled = await isSpecificFlatpakInstalled(appCode);
        if (isFlatpakInstalled) {
          return true;
        }
      }
    }
    if (currentenvironment.installedSoftwareManagers
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

  static Future<bool> isZypperPackageAvailable(String appCode) async {
    String output = await runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} info $appCode");
    return !output.contains(" not found.");
  }

  /// returns the source under which the Flatpak is available, otherwise empty String
  static Future<String> isFlatpakAvailable(String appCode) async {
    String output = await Linux.runCommandAndGetStdout(
        "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.FLATPAK)} search $appCode");
    if (output.split("\n").length >= 2) {
      List<String> lines = output.split("\n");
      for (String line in lines) {
        if (line.split("\t").contains(appCode)) {
          return line.split("\t").last.replaceAll("\n", "");
        }
      }
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
      available = await isZypperPackageAvailable(appCode);
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
    Linux.currentenvironment.installedSoftwareManagers
        .add(SOFTWARE_MANAGERS.FLATPAK);
  }

  static void openWebbrowserSeach(String searchterm) {
    searchterm = searchterm.replaceAll(" ", "+");
    runCommand("/usr/bin/xdg-open https://duckduckgo.com/?q=$searchterm");
  }

  static void openWebbrowserWithSite(String website) {
    if (!website.startsWith("http")) {
      website = "https://$website";
    }
    runCommand("/usr/bin/xdg-open $website");
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
    String foldersString =
        await runCommandWithCustomArgumentsAndGetStdOut("python3", [
      "${executableFolder}additional/python/get_folder_structure.py",
      "--recursion_depth=${ConfigHandler().getValueUnsafe("folder_recursion_depth", 3)}"
    ]);
    List<String> folders = foldersString.split('\n');

    // Get Bookmarks:
    if (currentenvironment.desktop != DESKTOPS.KDE) {
      String home = getHomeDirectory();
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
    } else if (currentenvironment.desktop == DESKTOPS.KDE) {
      List<String> lines =
          await File("${getHomeDirectory()}/.local/share/user-places.xbel")
              .readAsLines();
      for (String line in lines) {
        if (line.contains("<bookmark href=\"file://")) {
          folders.add(line
              .replaceAll("<bookmark href=\"file://", "")
              .replaceAll("\">", ""));
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
      folder = folder.trim();
      if (!folder.endsWith("/")) {
        folder = "$folder/";
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
      "--lang=${currentenvironment.language}",
      "--desktop=${currentenvironment.desktop.toString()}"
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
          description: "${AppLocalizations.of(context)!.openX} $recentFile",
          action: "openfile:$recentFile");
      actionEntry.priority = -15;
      actionEntries.add(actionEntry);
    }
    return actionEntries;
  }

  static Future<Environment> getCurrentEnvironment() async {
    String commandOutput = await runCommandWithCustomArgumentsAndGetStdOut(
        "python3", ["${executableFolder}additional/python/get_environment.py"]);
    List<String> lines = commandOutput.split("\n");
    Environment newEnvironment = Environment();

    // get OS:
    if (lines[0].contains("Linux Mint")) {
      newEnvironment.distribution = DISTROS.LINUX_MINT;
    } else if (lines[0].toLowerCase().contains("pop!_os")) {
      newEnvironment.distribution = DISTROS.POPOS;
    } else if (lines[0].toLowerCase().contains("opensuse")) {
      newEnvironment.distribution = DISTROS.OPENSUSE;
    } else if (lines[0].toLowerCase().contains("kde neon")) {
      newEnvironment.distribution = DISTROS.KDENEON;
    } else if (lines[0].toLowerCase().contains("mxlinux")) {
      newEnvironment.distribution = DISTROS.MXLINUX;
    } else if (lines[0].toLowerCase().contains("zorin")) {
      newEnvironment.distribution = DISTROS.ZORINOS;
    } else if (lines[0].toLowerCase().contains("ubuntu")) {
      newEnvironment.distribution = DISTROS.UBUNTU;
    } else if (lines[0].toLowerCase().contains("debian")) {
      newEnvironment.distribution = DISTROS.DEBIAN;
    }

    // get version:
    newEnvironment.versionString = lines[1];
    // Only use first two numbers of version number
    List<String> splitVer = lines[1].split(".");
    if (splitVer.length >= 2) {
      lines[1] = splitVer[0] + "." + splitVer[1];
    } else {
      lines[1] = splitVer[0];
    }
    if (double.tryParse(lines[1]) == null) {
      newEnvironment.version = -1.0;
    } else {
      newEnvironment.version = double.parse(lines[1]);
    }

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
    newEnvironment.wayland = lines[5].contains("wayland");

    for (int i = 0; i < SOFTWARE_MANAGERS.values.length; i++) {
      if (await File(
              getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.values[i]))
          .exists()) {
        newEnvironment.installedSoftwareManagers
            .add(SOFTWARE_MANAGERS.values[i]);
      }
    }

    // Get user id
    newEnvironment.currentUserId = await getUserIdOfCurrentUser();

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
      case SOFTWARE_MANAGERS.ZYPPER:
        return "/usr/bin/zypper";
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
    String returnValue = "";
    for (String part in parts) {
      if (part.trim().isEmpty) {
        continue;
      }
      returnValue = "${returnValue}/${part}";
    }
    returnValue = "${returnValue}/";
    return returnValue;
  }

  /// Only adds commands to the command queue
  static void installMultimediaCodecs() async {
    switch (currentenvironment.distribution) {
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
      case DISTROS.ZORINOS:
      case DISTROS.KDENEON:
        commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.APT)} install ubuntu-restricted-extras -y",
            environment: {"DEBIAN_FRONTEND": "noninteractive"}));
        break;
      case DISTROS.OPENSUSE:
        String file = await getEtcOsRelease();
        bool tumbleweed = file.toLowerCase().contains("tumbleweed");

        if (tumbleweed) {
          commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive addrepo -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman",
          ));
        } else {
          // LEAP:
          // String releasever = "";
          // if (Platform.environment.containsKey("releasever")) {
          //   releasever = Platform.environment["releasever"]!;
          // }
          commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive addrepo -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_\$releasever/' packman",
          ));
        }

        commandQueue.add(LinuxCommand(
          userId: 0,
          command:
              "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive refresh",
        ));
        commandQueue.add(LinuxCommand(
          userId: 0,
          command:
              "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive dist-upgrade --from packman --allow-vendor-change",
        ));
        commandQueue.add(LinuxCommand(
          userId: 0,
          command:
              "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive install --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec-full vlc-codecs",
        ));

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
      commandList.add("${executableFolder}additional/python/run_script.py");
    } else {
      executable = "${executableFolder}additional/python/run_script.py";
    }
    commandList.add(filename);

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
  static Future<void> applyAutomaticConfigurationAfterInstallation(
      {bool applyUpdatesSinceRelease = true,
      bool installMultimediaCodecs_ = true,
      bool setupAutomaticSnapshots = true,
      bool installNvidiaDriversAutomatically = true,
      bool setupAutomaticUpdates = true}) async {
    if (applyUpdatesSinceRelease) {
      await updateAllPackages();
    }
    if (installMultimediaCodecs_) {
      installMultimediaCodecs();
    }
    if (setupAutomaticSnapshots) {
      await enableAutomaticSnapshots();
    }
    if (installNvidiaDriversAutomatically) {
      commandQueue.add(LinuxCommand(
          userId: 0,
          command:
              "python3 ${executableFolder}additional/python/install_nvidia_driver.py"));
    }
    if (setupAutomaticUpdates) {
      await enableAutomaticUpdates();
    }
  }

  /// Only appends commands to [commandQueue]
  static Future<void> enableAutomaticUpdates() async {
    switch (currentenvironment.distribution) {
      case DISTROS.OPENSUSE:
        await ensureApplicationInstallation(
            ["yast2-online-update-configuration"]);
        commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "ln -s /usr/lib/YaST2/bin/online_update /etc/cron.daily/"));
        break;
      default:
        commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "python3 ${executableFolder}additional/python/setup_automatic_updates_debian.py"));
    }
  }

  /// Only appends commands to [commandQueue]
  static Future<void> enableAutomaticSnapshots() async {
    await ensureApplicationInstallation(["timeshift"]);
    commandQueue.add(LinuxCommand(
        userId: 0,
        command:
            "python3 ${executableFolder}additional/python/setup_automatic_snapshots.py"));
  }

  /// Only appends commands to [commandQueue]
  static Future<void> updateAllPackages() async {
    if (currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.APT)) {
      commandQueue.add(LinuxCommand(
        userId: 0,
        command: "/usr/bin/apt update",
        environment: {"DEBIAN_FRONTEND": "noninteractive"},
      ));
      commandQueue.add(LinuxCommand(
        userId: 0,
        command: "/usr/bin/apt dist-upgrade -y",
        environment: {"DEBIAN_FRONTEND": "noninteractive"},
      ));
    } else {
      if (currentenvironment.installedSoftwareManagers
          .contains(SOFTWARE_MANAGERS.ZYPPER)) {
        // Check if we are in tumbleweed:
        String file = await getEtcOsRelease();
        if (file.toLowerCase().contains("tumbleweed")) {
          // Tumbleweed
          commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive dup",
          ));
        } else {
          // Leap or other
          commandQueue.add(LinuxCommand(
            userId: 0,
            command:
                "${getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive up",
          ));
        }
      }
    }

    if (currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.FLATPAK)) {
      commandQueue.add(LinuxCommand(
        userId: 0,
        command: "/usr/bin/flatpak upgrade -y",
        environment: {"DEBIAN_FRONTEND": "noninteractive"},
      ));
    }

    if (currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.SNAP)) {
      commandQueue.add(LinuxCommand(
        userId: 0,
        command: "/usr/bin/snap refresh",
        environment: {"DEBIAN_FRONTEND": "noninteractive"},
      ));
    }
  }

  static Future<String> getEtcOsRelease() async {
    return await File("/etc/os-release").readAsString();
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

  static Future<int> getUserIdOfCurrentUser() async {
    String output = await Linux.runCommandAndGetStdout("id -u");
    return int.parse(output);
  }

  /// Only returns results if keyword is longer than 3 and there are under 100 results.
  static Future<List<ActionEntry>> getInstallableAptPackagesForKeyword(
      BuildContext context, String keyword) async {
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
            Icons.download_rounded,
            size: 48,
          ),
          name: AppLocalizations.of(context)!.installX(line),
          description: "Install via apt",
          action: "apt-install:$line",
          priority: -20));
    }
    return results;
  }

  /// Only returns results if keyword is longer than 3 and there are under 100 results.
  static Future<List<ActionEntry>> getInstallableZypperPackagesForKeyword(
      String keyword) async {
    if (keyword.length <= 3) {
      return [];
    }
    String output = await runCommandWithCustomArgumentsAndGetStdOut(
        getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER),
        ["--non-interactive", "search", keyword]);
    output = output.trim();
    List<String> lines = output.split("\n");

    // Cancel search, if too many search results.
    if (lines.length > 104) {
      return [];
    }

    List<ActionEntry> results = [];
    for (String line in lines) {
      if (line.trim() == "" || line.split("|").length < 4) {
        continue;
      }
      List<String> lineParts = line.split("|");
      String packageName = lineParts[1].trim();

      // Skip table head
      if (packageName == "Name") {
        continue;
      }

      // if already installed, skip entry
      if (lineParts[0].trim() == "i") {
        continue;
      }

      results.add(ActionEntry(
          iconWidget: Icon(
            Icons.archive,
            size: 48,
          ),
          name: "Install $packageName",
          description: "Install via zypper",
          action: "zypper-install:$packageName",
          priority: -20));
    }
    return results;
  }

  /// Used while startup of the application
  static Future<void> loadCurrentEnvironment() async {
    currentenvironment = await getCurrentEnvironment();
    ConfigHandler configHandler = ConfigHandler();
    await configHandler.ensureConfigIsLoaded();
    currentenvironment.distribution = configHandler.getValueUnsafe(
        "distribution", currentenvironment.distribution);
    currentenvironment.version =
        configHandler.getValueUnsafe("version", currentenvironment.version);
    currentenvironment.versionString = configHandler.getValueUnsafe(
        "versionString", currentenvironment.versionString);
    currentenvironment.desktop =
        configHandler.getValueUnsafe("desktop", currentenvironment.desktop);
    currentenvironment.browser =
        configHandler.getValueUnsafe("browser", currentenvironment.browser);
    currentenvironment.language =
        configHandler.getValueUnsafe("language", currentenvironment.language);

    bool nvidiaCardInstalled = await isNvidiaCardInstalledOnSystem();
    bool nouveauRunning = await isNouveauCurrentGraphicsDriver();
    currentenvironment.nvidiaCardAndNouveauRunning =
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
        path = path.trim();
        if (!path.endsWith("/")) {
          path = "$path/";
        }
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

  static Future<List<ActionEntry>> getBrowserBookmarks(
      BuildContext context) async {
    String outputString = await runPythonScript("get_bookmarks.py");
    List<String> lines = outputString.split("\n");
    List<ActionEntry> returnValue = [];
    for (String line in lines) {
      List<String> elements = line.split("\t");
      if (elements.length == 2) {
        returnValue.add(ActionEntry(
            name: elements[0],
            description:
                "${AppLocalizations.of(context)!.openX} ${elements[1]}",
            action: "openwebsite:${elements[1]}",
            priority: -5.0));
      }
    }
    return returnValue;
  }

  static Future<bool> isDarkThemeEnabled() async {
    switch (currentenvironment.desktop) {
      case DESKTOPS.CINNAMON:
        String output = await runCommandAndGetStdout(
            "gsettings get org.cinnamon.desktop.interface gtk-theme");
        return output.toLowerCase().contains("dark");
      case DESKTOPS.GNOME:
        String output = await runCommandAndGetStdout(
            "gsettings get org.gnome.desktop.interface gtk-theme");
        return output.toLowerCase().contains("dark");
      case DESKTOPS.XFCE:
        String output = await runCommandAndGetStdout(
            "xfconf-query -c xfwm4 -p /general/theme");
        return output.toLowerCase().contains("dark");
      case DESKTOPS.KDE:
        String kdeGlobals =
            "${Linux.getHomeDirectory()}/.config/kdedefaults/kdeglobals";

        if (await File(kdeGlobals).exists()) {
          String contents = await File(kdeGlobals).readAsString();
          return contents.toLowerCase().contains("dark");
        } else {
          return false;
        }
      default:
        return false;
    }
  }

  static void activateSystemHotkeyForLinuxAssistant() {
    if (get_hotkey_modifier() == "<Alt>") {
      Linux.runPythonScript("setup_keybinding.py", arguments: ["--alt"]);
    } else {
      Linux.runPythonScript("setup_keybinding.py");
    }
  }

  static String get_hotkey_modifier() {
    if (currentenvironment.desktop == DESKTOPS.KDE) {
      return "<Alt>";
    }
    switch (currentenvironment.distribution) {
      case DISTROS.POPOS:
      case DISTROS.ZORINOS:
        return "<Alt>";
      default:
        return "<Super/Windows> ";
    }
  }

  static bool usesCurrentEnvironmentDebPackages() {
    switch (currentenvironment.distribution) {
      case DISTROS.DEBIAN:
      case DISTROS.MXLINUX:
      case DISTROS.LINUX_MINT:
      case DISTROS.POPOS:
      case DISTROS.ZORINOS:
      case DISTROS.KDENEON:
      case DISTROS.UBUNTU:
        return true;

      default:
        return false;
    }
  }

  static bool usesCurrentEnvironmentRPMPackages() {
    switch (currentenvironment.distribution) {
      case DISTROS.OPENSUSE:
        return true;
      default:
        return false;
    }
  }

  /// removes all rights for others at the home folder
  static Future<void> fixHomeFolderPermissions() async {
    runCommandWithCustomArguments(
        "/usr/bin/chmod", ["o-rwx", Linux.getHomeDirectory()]);
  }

  static Future<void> openAdditionalSoftwareSourcesSettings() async {
    if (File("/usr/bin/software-properties-gtk").existsSync()) {
      runCommand("/usr/bin/software-properties-gtk");
      return;
    }
    switch (currentenvironment.distribution) {
      case DISTROS.UBUNTU:
      case DISTROS.ZORINOS:
        runCommand("/usr/bin/software-properties-gtk");
        break;
      case DISTROS.LINUX_MINT:
        runCommandWithCustomArguments("/usr/bin/pkexec", ["mintsources"]);
        break;
      case DISTROS.OPENSUSE:
        runCommandWithCustomArguments(
            "xdg-su", ["-c", "/sbin/yast2 repositories"]);
        break;
      case DISTROS.MXLINUX:
        runCommand("/usr/bin/mx-repo-manager");
        break;
      case DISTROS.KDENEON:
        runCommand("/usr/bin/plasma-discover");
        break;
      case DISTROS.DEBIAN:
      case DISTROS.POPOS:
        runCommandWithCustomArguments("xdg-open", ["/etc/apt/sources.list.d/"]);
        break;
      default:
    }
  }

  static Future<bool> isFileExecutable(String filePath) async {
    var stat = await FileStat.stat(filePath);
    var mode = stat.mode.toRadixString(8).substring(3);

    // Example values for variable 'mode': '755', '644' etc.
    // If any of the three numbers is uneven, the file is marked as executable.
    return int.parse(mode[0]) % 2 != 0 ||
        int.parse(mode[1]) % 2 != 0 ||
        int.parse(mode[2]) % 2 != 0;
  }

  static void runExecutableInTerminal(String executablePath) async {
    String term = await Linux.runPythonScript("get_terminal_emulator.py");
    if ((term = term.trim()) == "gnome-terminal") {
      Linux.runCommandWithCustomArguments(term, ["--", executablePath]);
    } else {
      Linux.runCommandWithCustomArguments(term, ["-e", executablePath]);
    }
  }

  static void shutdown({int minutes = 0}) {
    Linux.runCommand("/sbin/shutdown $minutes");
  }

  static Future<List<ActionEntry>> getAvailableFlatpaks(
      BuildContext context) async {
    String homeDir = Linux.getHomeDirectory();

    List<ActionEntry> returnValue = [];
    try {
      String installedFlatpaks =
          await Linux.runCommandWithCustomArgumentsAndGetStdOut(
              "/usr/bin/flatpak", ["list", "--app", "--columns=application"]);

      File flathubIndexFile =
          File("$homeDir.config/linux-assistant/flathub_index.json");
      List<dynamic> responseMap =
          json.decode(flathubIndexFile.readAsStringSync());
      for (Map<String, dynamic> app in responseMap) {
        if (!installedFlatpaks
            .contains(app["flatpakAppId"].toString().trim())) {
          ActionEntry entry = ActionEntry(
            name: AppLocalizations.of(context)!
                .installX("${app["name"]} (Flatpak)"),
            description: app["summary"],
            action: "flatpak-install:${app["flatpakAppId"]}",
            priority: -19.0,
            iconWidget: const Icon(
              Icons.archive_rounded,
              size: 48,
            ),
          );
          returnValue.add(entry);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return returnValue;
  }

  static Future<String> getUserAndHostname() async {
    final int id = currentenvironment.currentUserId;
    try {
      final String hostname = (await runCommandAndGetStdout("hostname")).trim();
      final String user = (await runCommandAndGetStdout("id -nu $id")).trim();
      return "$user@$hostname";
    } catch (e) {
      return "";
    }
  }

  static Future<String> getOsPrettyName() async {
    try {
      return (await File("/etc/os-release").readAsString())
          .split("\n")
          .firstWhere((x) => x.startsWith("PRETTY_NAME"))
          .split('"')
          .elementAt(1);
    } catch (e) {
      return "";
    }
  }

  static Future<String> getCpuModel() async {
    try {
      final List<String> cpuinfo =
          (await File("/proc/cpuinfo").readAsString()).split("\n");

      int cores = cpuinfo.where((x) => x.contains("model name")).length;
      String model = cpuinfo
          .firstWhere((x) => x.contains("model name"))
          .replaceFirst("model name", "")
          .replaceFirst(":", "")
          .replaceFirst("CPU", "")
          .replaceFirst("with Radeon Graphics", "")
          // Remove everything in parentheses
          .replaceAll(RegExp(r'\s?\(([^\)]+)\)'), "")
          // Remove clock speed
          .replaceAll(RegExp(r'\s?[@].*'), "")
          .trim();

      return "$model ($cores)";
    } catch (e) {
      return "";
    }
  }

  static Future<String> getGpuModel() async {
    try {
      return (await runCommandAndGetStdout("glxinfo -B"))
          .split("\n")
          .firstWhere((x) => x.startsWith("OpenGL renderer string"))
          .replaceFirst("OpenGL renderer string:", "")
          .replaceFirst("Mesa DRI", "")
          // Remove everything in parentheses
          .replaceAll(RegExp(r'\s?\(([^\)]+)\)'), "")
          // Remove everything after /
          .replaceAll(RegExp(r'[\/].*'), "")
          .trim();
    } catch (e) {
      return "";
    }
  }

  static Future<String> getKernelVersion() async {
    try {
      return (await File("/proc/version").readAsString())
          .split(" ")
          .elementAt(2)
          .split("-")
          .elementAt(0);
    } catch (e) {
      return "";
    }
  }
}
