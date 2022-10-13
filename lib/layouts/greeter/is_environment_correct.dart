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

class IsYourEnvironmentCorrectView extends StatelessWidget {
  const IsYourEnvironmentCorrectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Environment> environment = recognizeEnvironment();
    return FutureBuilder<Environment>(
      future: environment,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Is your recognized system correct?",
                  style: MintY.heading1,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "System: ${getNiceStringOfDistrosEnum(snapshot.data!.distribution)} ${snapshot.data!.version}\nDesktop: ${getNiceStringOfDesktopsEnum(snapshot.data!.desktop)}\nLanguage: ${snapshot.data!.language}",
                  style: MintY.heading2,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MintYButton(
                      text: const Text(
                        "No, I wan't to change",
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
                      text: const Text(
                        "Yes",
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
            text: "Recognizing system...",
          );
        }
      }),
    );
  }

  Future<Environment> recognizeEnvironment() async {
    ConfigHandler configHandler = ConfigHandler();
    Environment environment = await Linux.getCurrentEnviroment();
    Linux.currentEnviroment = environment;
    configHandler.setValue("environment", environment.toJson());
    return environment;
  }
}
