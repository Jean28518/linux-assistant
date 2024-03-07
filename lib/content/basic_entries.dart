import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/main.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<ActionEntry> getBasicEntries(BuildContext context) {
  return [
    ActionEntry(
      name: AppLocalizations.of(context)!.password,
      description: AppLocalizations.of(context)!.changePasswordDescription,
      action: "change_user_password",
      iconWidget: Icon(
        Icons.password,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.userProfile,
      description: AppLocalizations.of(context)!.changeUserProfile,
      action: "open_usersettings",
      iconWidget: Icon(
        Icons.person,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.systemInformation,
      description:
          "${getNiceStringOfDistrosEnum(Linux.currentenvironment.distribution)} ${Linux.currentenvironment.versionString} ${getNiceStringOfDesktopsEnum(Linux.currentenvironment.desktop)}",
      action: "open_systeminformation",
      iconWidget: Icon(
        Icons.info_rounded,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.introductionToLinuxAssistant,
      description:
          AppLocalizations.of(context)!.introductionToLinuxAssistantDescription,
      action: "open_introduction",
      iconWidget: Icon(
        Icons.question_mark,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.linuxAssistantKeyboardShortcut,
      description: AppLocalizations.of(context)!
          .setUpLinuxAssistantKeyboardShortcut(Linux.get_hotkey_modifier()),
      action: "setup_linux_assistant_shortcut",
      iconWidget: Icon(
        Icons.keyboard,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: "HardInfo",
      description: AppLocalizations.of(context)!.hardInfoDescription,
      action: "hard_info",
      iconWidget: Icon(
        Icons.speed,
        size: 48,
        color: MintY.currentColor,
      ),
      disableEntryIf: () {
        return [DISTROS.FEDORA].contains(Linux.currentenvironment.distribution);
      },
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.shutdown,
      description: AppLocalizations.of(context)!.shutdownDescription,
      action: "shutdown",
      iconWidget: Icon(
        Icons.power_settings_new,
        size: 48,
        color: MintY.currentColor,
      ),
    ),

    /// Should imitate the terminal command 'exit'
    ActionEntry(
      name: AppLocalizations.of(context)!.exit,
      description: AppLocalizations.of(context)!.exitDescription,
      action: "exit",
      iconWidget: Icon(
        Icons.close,
        size: 48,
        color: MintY.currentColor,
      ),
    ),

    ActionEntry(
      name: AppLocalizations.of(context)!.update,
      description: AppLocalizations.of(context)!.updateSystemDescription,
      action: "update_system",
      iconWidget: Icon(
        Icons.update,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.installMultimediaCodecs,
      description:
          AppLocalizations.of(context)!.installMultimediaCodecsDescription,
      action: "install_multimedia_codecs",
      iconWidget: Icon(
        Icons.play_circle,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.automaticUpdateManagerConfiguration,
      description: AppLocalizations.of(context)!
          .automaticUpdateManagerConfigurationDescription,
      action: "enable_automatic_updates",
      iconWidget: Icon(
        Icons.auto_mode,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.automaticSnapshots,
      description: AppLocalizations.of(context)!.automaticSnapshotsDescription,
      action: "enable_automatic_snapshots",
      iconWidget: Icon(
        Icons.settings_backup_restore,
        size: 48,
        color: MintY.currentColor,
      ),
      disableEntryIf: () {
        return [DISTROS.OPENSUSE, DISTROS.FEDORA]
            .contains(Linux.currentenvironment.distribution);
      },
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.versionOfLinuxAssistant,
      description: Linux.currentenvironment.runningInFlatpak
          ? "v$CURRENT_LINUX_ASSISTANT_VERSION (Flatpak)"
          : "v$CURRENT_LINUX_ASSISTANT_VERSION",
      action: "just_callback",
      iconWidget: Icon(
        Icons.info_rounded,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.fixPackageManager,
      description: AppLocalizations.of(context)!.fixPackageManagerDescription,
      action: "fix_package_manager",
      iconWidget: Icon(Icons.bug_report, size: 48, color: MintY.currentColor),
      keywords: ["fix", "package", "manager", "apt", "dpkg", "rpm", "zypper"],
    ),
  ];
}
