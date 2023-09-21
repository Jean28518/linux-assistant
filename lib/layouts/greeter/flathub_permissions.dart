import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FlathubPermissionsPage extends StatelessWidget {
  const FlathubPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: AppLocalizations.of(context)!.welcome,
      contentElements: [
        Text(
          AppLocalizations.of(context)!.flathubPermissionsDescription,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: SelectableText(
                "flatpak override --user io.github.jean28518.Linux-Assistant --talk-name=org.freedesktop.Flatpak",
                style: MintY.heading4White,
              ),
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.pleaseRestartLinuxAssistant,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
