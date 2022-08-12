import 'package:linux_helper/enums/desktops.dart';
import 'package:linux_helper/enums/distros.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/services/linux.dart';

final basicEntries = [
  ActionEntry(
      name: "Password",
      description: "Change password of current user",
      action: "change_user_password"),
  ActionEntry(
      name: "User Profile",
      description: "Change userdetails",
      action: "open_usersettings"),
  ActionEntry(
      name: "System information",
      description:
          "${getNiceStringOfDistrosEnum(Linux.currentEnviroment.distribution)} ${Linux.currentEnviroment.version.toString()} ${getNiceStringOfDesktopsEnum(Linux.currentEnviroment.desktop)}",
      action: "open_systeminformation"),
];
