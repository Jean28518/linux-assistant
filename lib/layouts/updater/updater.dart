import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/services/updater.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/services/weekly_tasks.dart';

class LinuxAssistantUpdatePage extends StatelessWidget {
  const LinuxAssistantUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> weeklyTasks = WeeklyTasks.doWeekleyTasks();

    return FutureBuilder<void>(
      future: weeklyTasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            LinuxAssistantUpdater.isNewerVersionAvailable()) {
          return MintYPage(
            title: AppLocalizations.of(context)!.update,
            contentElements: [
              Text(
                AppLocalizations.of(context)!.aNewVersionIsAvailable,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.doYouWantToUpdateNow,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            bottom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButtonNavigate(
                  route: const MainSearchLoader(),
                  text: Text(
                    AppLocalizations.of(context)!.later,
                    style: MintY.heading4,
                  ),
                ),
                const SizedBox(
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
        } else if (snapshot.connectionState == ConnectionState.done ||
            snapshot.hasError) {
          return const MainSearchLoader();
        } else {
          return const MintYLoadingPage();
        }
      },
    );
  }
}
