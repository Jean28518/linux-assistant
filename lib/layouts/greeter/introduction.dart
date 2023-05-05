import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/updater/updater.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';

class GreeterIntroduction extends StatelessWidget {
  final bool forceOpen;
  const GreeterIntroduction({super.key, this.forceOpen = false});

  @override
  Widget build(BuildContext context) {
    ConfigHandler configHandler = ConfigHandler();
    bool runIntroduction =
        configHandler.getValueUnsafe("runIntroduction", true);
    if (!runIntroduction && !forceOpen) {
      return const LinuxAssistantUpdatePage();
    }
    return MintYPage(
      title: AppLocalizations.of(context)!.introduction,
      contentElements: [
        Text(
          AppLocalizations.of(context)!.theFollowingContentCanBeSearched,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        MintYFeature(
          heading: AppLocalizations.of(context)!.applications,
          description:
              AppLocalizations.of(context)!.applicationSearchDescription,
          icon: Icon(
            Icons.apps,
            size: 64,
            color: MintY.currentColor,
          ),
        ),
        MintYFeature(
          heading: AppLocalizations.of(context)!.folders,
          description: AppLocalizations.of(context)!.folderSearchDescription,
          icon: Icon(
            Icons.folder,
            size: 64,
            color: MintY.currentColor,
          ),
        ),
        MintYFeature(
          heading: AppLocalizations.of(context)!.recentFiles,
          description: AppLocalizations.of(context)!.recentFilesDescription,
          icon: Icon(
            Icons.description,
            size: 64,
            color: MintY.currentColor,
          ),
        ),
        MintYFeature(
          heading: AppLocalizations.of(context)!.browserBookmarks,
          description:
              AppLocalizations.of(context)!.browserBookmarksDescription,
          icon: Icon(
            Icons.web,
            size: 64,
            color: MintY.currentColor,
          ),
        ),
        MintYFeature(
          heading: AppLocalizations.of(context)!.specialFunctions,
          description:
              AppLocalizations.of(context)!.specialFunctionsDescription,
          icon: Icon(
            Icons.star,
            size: 64,
            color: MintY.currentColor,
          ),
        ),
        MintYFeature(
          heading: AppLocalizations.of(context)!.hint,
          description: AppLocalizations.of(context)!
              .youCanOpenLinuxAssistantWithHotkey(Linux.get_hotkey_modifier()),
          icon: Icon(
            Icons.lightbulb,
            size: 64,
            color: MintY.currentColor,
          ),
        ),
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButtonNavigate(
            route: const LinuxAssistantUpdatePage(),
            color: MintY.currentColor,
            text: Text(
              AppLocalizations.of(context)!.letsStart,
              style: MintY.heading4White,
            ),
            onPressed: (() {
              ConfigHandler configHandler = ConfigHandler();
              configHandler.setValue("runIntroduction", false);
            }),
          )
        ],
      ),
    );
  }
}
