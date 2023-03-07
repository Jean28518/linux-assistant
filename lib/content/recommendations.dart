import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/services/linux.dart';

List<ActionEntry> getRecommendations(BuildContext context) {
  return [
    ActionEntry(
      name: AppLocalizations.of(context)!.securityCheck,
      description: AppLocalizations.of(context)!.securityCheckDescription,
      action: "security_check",
      iconWidget: Icon(
        Icons.safety_check,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: "Warpinator",
      description: AppLocalizations.of(context)!.warpinatorDescription,
      action: "send_files_via_warpinator",
      iconWidget: Icon(
        Icons.send,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.afterInstallation,
      description: AppLocalizations.of(context)!.afterInstallationDescription,
      action: "after_installation",
      iconWidget: Icon(
        Icons.start,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.linuxHealth,
      description: AppLocalizations.of(context)!.linuxHealthDescription,
      action: "linux_health",
      iconWidget: Icon(
        Icons.monitor_heart,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: "Redshift",
      description: AppLocalizations.of(context)!.redshiftDescription,
      action: "redshift",
      iconWidget: Icon(
        Icons.remove_red_eye,
        size: 48,
        color: MintY.currentColor,
      ),
    ),
  ];
}
