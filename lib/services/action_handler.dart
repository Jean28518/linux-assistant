import 'package:flutter/material.dart';
import 'package:linux_helper/layouts/search.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/services/linux.dart';

class ActionHandler {
  late MainSearch mainSearch;
  ActionHandler(MainSearch mainSearch) {
    this.mainSearch = mainSearch;
  }

  static void handleActionEntry(
      ActionEntry actionEntry, VoidCallback callback) {
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
  }
}
