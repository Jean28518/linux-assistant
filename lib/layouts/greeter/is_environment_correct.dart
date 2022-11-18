import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/greeter/environment_selection.dart';
import 'package:linux_assistant/layouts/loading_indicator.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/models/enviroment.dart';
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
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.isTheRecognizedSystemCorrect,
                  style: MintY.heading1,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "${AppLocalizations.of(context)!.distribution}: ${getNiceStringOfDistrosEnum(snapshot.data!.distribution)} ${snapshot.data!.version}\n${AppLocalizations.of(context)!.desktop}: ${getNiceStringOfDesktopsEnum(snapshot.data!.desktop)}\n${AppLocalizations.of(context)!.language}: ${snapshot.data!.language}",
                  style: MintY.heading2,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MintYButton(
                      text: Text(
                        AppLocalizations.of(context)!.noIWantToChange,
                        style: MintY.heading2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EnvironmentSelectionView()),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    MintYButton(
                      text: Text(
                        AppLocalizations.of(context)!.yes,
                        style: MintY.heading2White,
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainSearchLoader()),
                        );
                      },
                    ),
                  ],
                )
              ],
            )),
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
