import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/greeter/environment_selection.dart';
import 'package:linux_assistant/layouts/greeter/start_after_installation.dart';
import 'package:linux_assistant/layouts/loading_indicator.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/models/environment.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IsYourEnvironmentCorrectView extends StatelessWidget {
  const IsYourEnvironmentCorrectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Environment> environment =
        Linux.recognizeEnvironmentFirstInitialization();
    return FutureBuilder<Environment>(
      future: environment,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return MintYPage(
            contentElements: [
              Text(
                AppLocalizations.of(context)!.isTheRecognizedSystemCorrect,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "${AppLocalizations.of(context)!.distribution}: ${getNiceStringOfDistrosEnum(snapshot.data!.distribution)} ${snapshot.data!.version}\n${AppLocalizations.of(context)!.desktop}: ${getNiceStringOfDesktopsEnum(snapshot.data!.desktop)}\n${AppLocalizations.of(context)!.language}: ${snapshot.data!.language}",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ],
            bottom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButtonNavigate(
                  text: Text(
                    AppLocalizations.of(context)!.noIWantToChange,
                    style: MintY.heading3,
                  ),
                  route: const EnvironmentSelectionView(),
                ),
                const SizedBox(
                  width: 10,
                ),
                MintYButtonNavigate(
                  text: Text(
                    AppLocalizations.of(context)!.yes,
                    style: MintY.heading3White,
                  ),
                  color: Colors.blue,
                  route: const StartAfterInstallationRoutineQuestion(),
                ),
              ],
            ),
          );
        } else {
          return LoadingIndicator(
            text: AppLocalizations.of(context)!.recognizingSystem,
          );
        }
      }),
    );
  }
}
