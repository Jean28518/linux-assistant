import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/greeter/is_environment_correct.dart';
import 'package:linux_assistant/layouts/loading_indicator.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/models/environment.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> runFirstStartup = shouldRunFirstStartUp();
    return FutureBuilder<bool>(
      future: runFirstStartup,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return getStartScreenView(context);
          } else {
            return MainSearchLoader();
          }
        } else {
          return LoadingIndicator();
        }
      },
    );
  }

  Future<bool> shouldRunFirstStartUp() async {
    // prepare config
    ConfigHandler configHandler = ConfigHandler();
    bool runFirstStartUp =
        await configHandler.getValue("runFirstStartUp", true);
    return runFirstStartUp;
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
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  AppLocalizations.of(context)!.linuxAssistantLongDescription,
                  style: Theme.of(context).textTheme.bodyText1,
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
