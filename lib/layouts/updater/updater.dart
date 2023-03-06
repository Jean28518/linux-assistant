import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/services/updater.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LinuxAssistantUpdatePage extends StatelessWidget {
  const LinuxAssistantUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> newVersionAvailable =
        LinuxAssistantUpdater.isNewerVersionAvailable();
    return FutureBuilder<bool>(
      future: newVersionAvailable,
      builder: (context, snapshot) {
        if (snapshot.hasData && (snapshot.data!)) {
          return MintYPage(
            title: AppLocalizations.of(context)!.update,
            contentElements: [
              Text(
                AppLocalizations.of(context)!.aNewVersionIsAvailable,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.doYouWantToUpdateNow,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
            bottom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButtonNavigate(
                  route: MainSearchLoader(),
                  text: Text(
                    AppLocalizations.of(context)!.later,
                    style: MintY.heading4,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MintYButtonNavigate(
                  onPressed: () {
                    LinuxAssistantUpdater.updateLinuxAssistantToNewestVersion();
                  },
                  route: RunCommandQueue(
                      message: AppLocalizations.of(context)!
                          .linuxAssistantIsUpdating,
                      title: AppLocalizations.of(context)!.update,
                      route: const MainSearchLoader()),
                  text: Text(
                    AppLocalizations.of(context)!.updateNow,
                    style: MintY.heading4White,
                  ),
                  color: MintY.currentColor,
                ),
              ],
            ),
          );
        } else if (snapshot.hasData || snapshot.hasError) {
          return const MainSearchLoader();
        } else {
          return const MintYLoadingPage();
        }
      },
    );
  }
}
