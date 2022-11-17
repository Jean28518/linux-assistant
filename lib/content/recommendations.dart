import 'package:flutter/material.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<ActionEntry> getRecommendations(BuildContext context) {
  return [
    ActionEntry(
      name: AppLocalizations.of(context)!.securityCheck,
      description: AppLocalizations.of(context)!.securityCheckDescription,
      action: "security_check",
      iconWidget: const Icon(
        Icons.safety_check,
        size: 48,
      ),
    ),
    ActionEntry(
      name: "Warpinator",
      description: AppLocalizations.of(context)!.warpinatorDescription,
      action: "send_files_via_warpinator",
      iconWidget: const Icon(
        Icons.send,
        size: 48,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.afterInstallation,
      description: AppLocalizations.of(context)!.afterInstallationDescription,
      action: "after_installation",
      iconWidget: const Icon(
        Icons.start,
        size: 48,
      ),
    ),
  ];
}
