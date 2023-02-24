import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class ShutdownDialog extends StatelessWidget {
  ShutdownDialog({super.key});
  int minutes = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.shutdown,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.shutdownIn,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      // height: 50,
                      child: TextField(
                        onChanged: (value) {
                          if (int.tryParse(value) != null) {
                            minutes = int.parse(value);
                          }
                        },
                        onSubmitted: (value) {
                          shutdown();
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                        autofocus: true,
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.minutes,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MintYButton(
                  text: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: MintY.heading4,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                MintYButtonNavigate(
                  route: const MainSearchLoader(),
                  color: MintY.currentColor,
                  text: Text(
                    AppLocalizations.of(context)!.shutdown,
                    style: MintY.heading4White,
                  ),
                  onPressed: () {
                    shutdown();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void shutdown() {
    Linux.runCommand("/sbin/shutdown $minutes");
  }
}
