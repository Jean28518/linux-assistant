import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/layouts/after_installation/after_installation_entry.dart';
import 'package:linux_assistant/layouts/main_search.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/layouts/security_check/overview.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class ActionHandler {
  /// The callback is usually the clear function.
  static Future<void> handleActionEntry(ActionEntry actionEntry,
      VoidCallback callback, BuildContext context) async {
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
        Linux.openOrInstallWarpinator(context, callback);
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

    if (actionEntry.action.startsWith("apt-install:")) {
      String pkg = actionEntry.action.replaceFirst("apt-install:", "");
      await Linux.installApplications([pkg],
          preferredSoftwareManager: SOFTWARE_MANAGERS.APT);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RunCommandQueue(
                  title: "APT",
                  message: "Your package will be installed in a few moments...",
                  route: MainSearchLoader(),
                )),
      );
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
