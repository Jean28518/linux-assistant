import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

/// Don't needed to called on Snap or Flatpak.
/// Should only be asked at potential danger uninstall like on apt or zypper
class UninstallerQuestion extends StatelessWidget {
  String action;
  UninstallerQuestion({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    String app = action.split(":")[1];
    return MintYPage(
      title: AppLocalizations.of(context)!.uninstallApp(app),
      contentElements: [
        Icon(
          Icons.warning,
          color: Colors.red,
          size: 128,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          AppLocalizations.of(context)!.uninstallAppWarning(app),
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButtonNavigate(
            route: const MainSearchLoader(),
            text: Text(
              AppLocalizations.of(context)!.cancel,
              style: MintY.heading4,
            ),
            onPressed: () {
              Linux.commandQueue.clear();
            },
          ),
          const SizedBox(
            width: 10,
          ),
          MintYButtonNavigate(
            route: RunCommandQueue(
                title: AppLocalizations.of(context)!.uninstallApp(app),
                route: const MainSearchLoader()),
            text: Text(
              AppLocalizations.of(context)!.uninstallApp(app),
              style: MintY.heading4White,
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
