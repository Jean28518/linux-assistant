import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
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
    return SizedBox(
      width: min(600, MediaQuery.of(context).size.width - 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)!.distribution}: ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                width: 16,
              ),
              MintYButton(
                text: Text(
                  getNiceStringOfDistrosEnum(environment.distribution),
                  style: MintY.heading4White,
                ),
                color: MintY.currentColor,
                width: 150,
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
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)!.desktop}: ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                width: 16,
              ),
              MintYButton(
                text: Text(
                  getNiceStringOfDesktopsEnum(environment.desktop),
                  style: MintY.heading4White,
                ),
                color: MintY.currentColor,
                width: 150,
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
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)!.language}: ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 150,
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: environment.language,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  autofocus: true,
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
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _openDistributionSelection(context) {
    var distros = DISTROS.values.toList();
    // Sort the distros by their name
    distros.sort((a, b) => a.name.compareTo(b.name));
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Text(
            "${AppLocalizations.of(context)!.selectYourDistribution}:",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: ListView.builder(
              // primary: true,
              itemCount: distros.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MintYButton(
                    text: Text(
                      getNiceStringOfDistrosEnum(distros[index]),
                      style: MintY.heading4White,
                    ),
                    color: MintY.currentColor,
                    onPressed: (() {
                      setState(() {
                        environment.distribution = distros[index];
                        configHandler.setValue(
                            "distribution", environment.distribution.name);
                        Navigator.of(context).pop();
                      });
                    }),
                  ),
                );
              },
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
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Text(
            "${AppLocalizations.of(context)!.selectYourDesktop}:",
            style: Theme.of(context).textTheme.headlineLarge,
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
                        getNiceStringOfDesktopsEnum(DESKTOPS.values[index]),
                        style: MintY.heading4White,
                      ),
                      color: MintY.currentColor,
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
