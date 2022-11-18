import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/greeter/is_environment_correct.dart';
import 'package:linux_assistant/layouts/loading_indicator.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/models/enviroment.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                AppLocalizations.of(context)!.yourLinuxAssistant,
                style: MintY.heading1,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  AppLocalizations.of(context)!.linuxAssistantLongDescription,
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
