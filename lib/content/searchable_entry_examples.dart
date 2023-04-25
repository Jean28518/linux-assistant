import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<ActionEntry> getSearchableEntryExamples(BuildContext context) {
  return [
    ActionEntry(
      name: AppLocalizations.of(context)!.applications,
      description: AppLocalizations.of(context)!.applicationSearchDescription,
      action: "just_callback",
      iconWidget: Icon(
        Icons.apps,
        size: 64,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.folders,
      description: AppLocalizations.of(context)!.folderSearchDescription,
      action: "just_callback",
      iconWidget: Icon(
        Icons.folder,
        size: 64,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.recentFiles,
      description: AppLocalizations.of(context)!.recentFilesDescription,
      action: "just_callback",
      iconWidget: Icon(
        Icons.description,
        size: 64,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.browserBookmarks,
      description: AppLocalizations.of(context)!.browserBookmarksDescription,
      action: "just_callback",
      iconWidget: Icon(
        Icons.bookmark,
        size: 64,
        color: MintY.currentColor,
      ),
    ),
    ActionEntry(
      name: AppLocalizations.of(context)!.urls,
      description: AppLocalizations.of(context)!.urlsDescription,
      action: "just_callback",
      iconWidget: Icon(
        Icons.link,
        size: 64,
        color: MintY.currentColor,
      ),
    ),
  ];
}
