import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/greeter/activate_hotkey.dart';
import 'package:linux_assistant/layouts/greeter/is_environment_correct.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/models/environment.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnvironmentSelectionView extends StatefulWidget {
  const EnvironmentSelectionView({Key? key}) : super(key: key);

  @override
  State<EnvironmentSelectionView> createState() =>
      _EnvironmentSelectionViewState();
}

class _EnvironmentSelectionViewState extends State<EnvironmentSelectionView> {
  Environment environment = Linux.currentenvironment;
  Environment oldEnvironment = Linux.currentenvironment;
  ConfigHandler configHandler = ConfigHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.distribution}: ",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                width: 16,
              ),
              MintYButton(
                text: Text(
                  getNiceStringOfDistrosEnum(environment.distribution),
                  style: MintY.heading2,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _openDistributionSelection(context),
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "${AppLocalizations.of(context)!.version}: ",
          //       style: Theme.of(context).textTheme.displayLarge,
          //     ),
          //     SizedBox(
          //       width: 16,
          //     ),
          //     Container(
          //       width: 150,
          //       child: TextField(
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(),
          //           hintText: environment.version.toString(),
          //           hintStyle: TextStyle(fontSize: 24),
          //         ),
          //         autofocus: true,
          //         style: TextStyle(fontSize: 24),
          //         onChanged: (value) {
          //           if (value.isNotEmpty) {
          //             if (double.tryParse(value) != null) {
          //               environment.version = double.parse(value);
          //               configHandler.setValue("version", environment.version);
          //             }
          //           } else {
          //             environment.version = oldEnvironment.version;
          //           }
          //         },
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: 32,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.desktop}: ",
                style: MintY.heading1,
              ),
              SizedBox(
                width: 16,
              ),
              MintYButton(
                text: Text(
                  getNiceStringOfDesktopsEnum(environment.desktop),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _openDesktopSelection(context),
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.language}: ",
                style: MintY.heading1,
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                width: 150,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: environment.language,
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                  autofocus: true,
                  style: TextStyle(fontSize: 24),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      environment.language = value;
                    } else {
                      environment.version = oldEnvironment.version;
                    }
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MintYButton(
                text: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: MintY.heading2,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const IsYourEnvironmentCorrectView()),
                  );
                },
              ),
              const SizedBox(
                width: 32,
              ),
              MintYButton(
                text: Text(
                  AppLocalizations.of(context)!.next,
                  style: MintY.heading4White,
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivateHotkeyQuestion()),
                  );
                },
              ),
            ],
          )
        ],
      )),
    );
  }

  Widget _openDistributionSelection(context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${AppLocalizations.of(context)!.selectYourDistribution}:",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    // primary: true,
                    itemCount: DISTROS.values.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MintYButton(
                          text: Text(
                              getNiceStringOfDistrosEnum(DISTROS.values[index]),
                              style: MintY.heading2),
                          onPressed: (() {
                            setState(() {
                              environment.distribution = DISTROS.values[index];
                              configHandler.setValue(
                                  "distribution", environment.distribution);
                              Navigator.of(context).pop();
                            });
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _openDesktopSelection(context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${AppLocalizations.of(context)!.selectYourDesktop}:",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    // primary: true,
                    itemCount: DESKTOPS.values.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MintYButton(
                          text: Text(
                              getNiceStringOfDesktopsEnum(
                                  DESKTOPS.values[index]),
                              style: MintY.heading2),
                          onPressed: (() {
                            setState(() {
                              environment.desktop = DESKTOPS.values[index];
                              configHandler.setValue(
                                  "desktop", environment.desktop);
                              Navigator.of(context).pop();
                            });
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
