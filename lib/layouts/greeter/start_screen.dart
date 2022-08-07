import 'package:flutter/material.dart';
import 'package:linux_helper/layouts/greeter/is_environment_correct.dart';
import 'package:linux_helper/layouts/loading_indicator.dart';
import 'package:linux_helper/layouts/mintY.dart';
import 'package:linux_helper/models/enviroment.dart';
import 'package:linux_helper/services/config_handler.dart';
import 'package:linux_helper/services/linux.dart';
import 'package:linux_helper/services/main_search_loader.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> configAvailable = isConfigAvailable();
    return FutureBuilder<bool>(
      future: configAvailable,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return MainSearchLoader();
          } else {
            return getStartScreenView(context);
          }
        } else {
          return LoadingIndicator();
        }
      },
    );
  }

  Future<bool> isConfigAvailable() async {
    // prepare config
    ConfigHandler configHandler = ConfigHandler();
    await configHandler.loadConfigFromFile();

    // Load environment
    Map<String, dynamic> environmentMap =
        configHandler.getValueUnsafe("environment", <String, dynamic>{});
    if (environmentMap.isEmpty) {
      return false;
    } else {
      Linux.currentEnviroment = Environment.fromJson(environmentMap);
      return true;
    }
  }

  Scaffold getStartScreenView(context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Your. Linux. Assistant.",
                style: MintY.heading1,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "Linux Helper is a distribution indenpendent assistant to help and guide you through your daily usage. Just enter some keywords into the search field and find whatever you desire! Linux Helper comes with useful shotcuts to files, folders and applications and also has some routines. Links to settings and e.g. the included PC-Security checker are also available.",
                  style: MintY.paragraph,
                  overflow: TextOverflow.visible,
                ),
              ),
              MintYButtonNext(route: IsYourEnvironmentCorrectView())
            ],
          ),
        ),
      ),
    );
  }
}
