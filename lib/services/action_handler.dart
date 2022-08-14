import 'package:flutter/material.dart';
import 'package:linux_helper/enums/desktops.dart';
import 'package:linux_helper/layouts/after_installation/after_installation_entry.dart';
import 'package:linux_helper/layouts/main_search.dart';
import 'package:linux_helper/layouts/security_check.dart/overview.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/services/linux.dart';

class ActionHandler {
  static void handleActionEntry(
      ActionEntry actionEntry, VoidCallback callback, BuildContext context) {
    print(actionEntry.action);

    switch (actionEntry.action) {
      case "change_user_password":
        Linux.changeUserPasswordDialog();
        callback();
        break;
      case "open_systeminformation":
        Linux.openSystemInformation();
        callback();
        break;
      case "open_usersettings":
        Linux.openUserSettings();
        callback();
        break;
      case "send_files_via_warpinator":
        Linux.openOrInstallWarpinator();
        callback();
        break;
      case "security_check":
        MainSearch.unregisterHotkeysForKeyboardUse();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SecurityCheckOverview()),
        );
        break;
      case "after_installation":
        MainSearch.unregisterHotkeysForKeyboardUse();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AfterInstallationEntry()),
        );
        break;
      default:
    }

    if (actionEntry.action.startsWith("websearch:")) {
      Linux.openWebbrowserSeach(
          actionEntry.action.replaceFirst("websearch:", ""));
      callback();
    }

    if (actionEntry.action.startsWith("openwebsite:")) {
      Linux.openWebbrowserWithSite(
          actionEntry.action.replaceFirst("openwebsite:", ""));
      callback();
    }

    if (actionEntry.action.startsWith("openfolder:")) {
      Linux.runCommandWithCustomArguments(
          "xdg-open", [actionEntry.action.replaceFirst("openfolder:", "")]);
      callback();
    }

    if (actionEntry.action.startsWith("openfile:")) {
      String file = actionEntry.action.replaceFirst("openfile:", "");
      Linux.runCommandWithCustomArguments("xdg-open", [file]);
      callback();
    }

    if (actionEntry.action.startsWith("openapp:")) {
      if (Linux.currentEnviroment.desktop == DESKTOPS.KDE) {
        Linux.runCommand("kioclient exec " +
            actionEntry.action.replaceFirst("openapp:", ""));
      } else {
        String filepath = actionEntry.action.replaceFirst("openapp:", "");
        String file = filepath.split("/").last;
        String filename = file.replaceAll(".desktop", "");
        Linux.runCommand("gtk-launch " + filename);
      }

      callback();
    }
  }

  static void handleRecommendation() {}
}
