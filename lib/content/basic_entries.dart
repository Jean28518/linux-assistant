import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<ActionEntry> getBasicEntries(BuildContext context) {
  return [
    ActionEntry(
      name: AppLocalizations.of(context)!.password,
      description: AppLocalizations.of(context)!.changePasswordDescription,
      action: "change_user_password",
      iconWidget: const Icon(
        Icons.password,
        size: 48,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.userProfile,
      description: AppLocalizations.of(context)!.changeUserProfile,
      action: "open_usersettings",
      iconWidget: const Icon(
        Icons.person,
        size: 48,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.systemInformation,
      description:
          "${getNiceStringOfDistrosEnum(Linux.currentenvironment.distribution)} ${Linux.currentenvironment.version.toString()} ${getNiceStringOfDesktopsEnum(Linux.currentenvironment.desktop)}",
      action: "open_systeminformation",
      iconWidget: const Icon(
        Icons.info_rounded,
        size: 48,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.introductionToLinuxAssistant,
      description:
          AppLocalizations.of(context)!.introductionToLinuxAssistantDescription,
      action: "open_introduction",
      iconWidget: const Icon(
        Icons.question_mark,
        size: 48,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.linuxAssistantKeyboardShortcut,
      description:
          AppLocalizations.of(context)!.setUpLinuxAssistantKeyboardShortcut,
      action: "setup_linux_assistant_shortcut",
      iconWidget: const Icon(
        Icons.keyboard,
        size: 48,
      ),
    ),
  ];
}
