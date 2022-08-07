import 'package:flutter/material.dart';
import 'package:linux_helper/enums/desktops.dart';
import 'package:linux_helper/enums/distros.dart';
import 'package:linux_helper/layouts/greeter/is_environment_correct.dart';
import 'package:linux_helper/layouts/mintY.dart';
import 'package:linux_helper/models/enviroment.dart';
import 'package:linux_helper/services/config_handler.dart';
import 'package:linux_helper/services/linux.dart';
import 'package:linux_helper/services/main_search_loader.dart';

class EnvironmentSelectionView extends StatefulWidget {
  const EnvironmentSelectionView({Key? key}) : super(key: key);

  @override
  State<EnvironmentSelectionView> createState() =>
      _EnvironmentSelectionViewState();
}

class _EnvironmentSelectionViewState extends State<EnvironmentSelectionView> {
  Environment environment = Linux.currentEnviroment;
  Environment oldEnvironment = Linux.currentEnviroment;
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
                "Distribution: ",
                style: MintY.heading1,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Version: ",
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
                    hintText: environment.version.toString(),
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                  autofocus: true,
                  style: TextStyle(fontSize: 24),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (double.tryParse(value) != null) {
                        environment.version = double.parse(value);
                      }
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
              Text(
                "Desktop: ",
                style: MintY.heading1,
              ),
              SizedBox(
                width: 16,
              ),
              MintYButton(
                text: Text(
                  getNiceStringOfDesktopsEnum(environment.desktop),
                  style: MintY.heading2,
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
                "Language code: ",
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
                text: const Text(
                  "Cancel",
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
                text: const Text(
                  "Next",
                  style: MintY.heading2White,
                ),
                color: Colors.blue,
                onPressed: () {
                  Linux.currentEnviroment = environment;
                  ConfigHandler configHandler = ConfigHandler();
                  configHandler.setValue("environment", environment.toJson());
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
  }

  Widget _openDistributionSelection(context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Select your distribution:",
                style: MintY.heading1,
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
              const Text(
                "Select your desktop:",
                style: MintY.heading1,
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
