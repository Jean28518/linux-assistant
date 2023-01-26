import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/main.dart';
import 'package:linux_assistant/models/linux_command.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';

class LinuxAssistantUpdater {
  static Map? newestVersionInformation;

  /// Only searches, if the last successfull search is 7 days old, otherwise returns false;
  static Future<bool> isNewerVersionAvailable() async {
    // Check if we should already search
    ConfigHandler configHandler = ConfigHandler();
    DateTime lastSearch = DateTime.parse(
        configHandler.getValueUnsafe("last-searched-for-update", "1970-01-01"));
    if (DateTime.now().difference(lastSearch).inDays < 7) {
      return false;
    }

    http.Response response = await http
        .get(Uri.parse(
            "https://api.github.com/repos/Jean28518/linux-assistant/releases/latest"))
        .timeout(Duration(seconds: 1));

    Map responseMap = json.decode(response.body);
    newestVersionInformation = responseMap;
    String newestVersion = responseMap["name"].replaceAll("v", "");

    String newDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await configHandler.setValue("last-searched-for-update", newDate);

    return isVersionGreaterThanCurrent(newestVersion);
  }

  /// example for [version] would be: "3.4.19"
  static bool isVersionGreaterThanCurrent(String version) {
    List<String> currentVersionList =
        CURRENT_LINUX_ASSISTANT_VERSION.split(".");
    assert(currentVersionList.length == 3);
    List<String> versionList = version.split(".");
    assert(versionList.length == 3);

    for (int i = 0; i < 3; i++) {
      if (int.parse(versionList[i]) > int.parse(currentVersionList[i])) {
        return true;
      } else if (int.parse(versionList[i]) < int.parse(currentVersionList[i])) {
        return false;
      } else {
        // This version index is equal. Look to the indizes after.
      }
    }
    // If they are equal return false.
    return false;
  }

  /// Only adds commands to Linux.commandQueue.
  static void updateLinuxAssistantToNewestVersion() {
    assert(newestVersionInformation != null);
    for (Map asset in newestVersionInformation!["assets"]) {
      // Debian based systems
      if (asset["content_type"] == "application/vnd.debian.binary-package" &&
          Linux.usesCurrentEnvironmentDebPackages()) {
        String downloadURL = asset["browser_download_url"];
        if (downloadURL.isEmpty) {
          print(
              "Error while updating Linux-Assistant to newest version. Download URL empty.");
          return;
        }
        String fileName = downloadURL.split("/").last;
        Linux.commandQueue.add(LinuxCommand(
            userId: Linux.currentenvironment.currentUserId,
            command: "wget $downloadURL -P /tmp/"));
        Linux.commandQueue.add(LinuxCommand(
            userId: 0, command: "/usr/bin/apt install /tmp/$fileName -y"));
      }
      // RPM
      if (asset["content_type"] == "application/x-rpm" &&
          Linux.usesCurrentEnvironmentRPMPackages()) {
        String downloadURL = asset["browser_download_url"];
        if (downloadURL.isEmpty) {
          print(
              "Error while updating Linux-Assistant to newest version. Download URL empty.");
          return;
        }
        String fileName = downloadURL.split("/").last;
        Linux.commandQueue.add(LinuxCommand(
            userId: Linux.currentenvironment.currentUserId,
            command: "wget $downloadURL -P /tmp/"));
        if (Linux.currentenvironment.installedSoftwareManagers
            .contains(SOFTWARE_MANAGERS.ZYPPER)) {
          Linux.commandQueue.add(LinuxCommand(
              userId: 0,
              command:
                  "${Linux.getExecutablePathOfSoftwareManager(SOFTWARE_MANAGERS.ZYPPER)} --non-interactive  --no-gpg-checks install /tmp/$fileName"));
        }
      }
    }
  }
}
