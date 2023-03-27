import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/run_command_queue.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class PowerMode extends StatefulWidget {
  const PowerMode({super.key});

  @override
  State<PowerMode> createState() => _PowerModeState();
}

class _PowerModeState extends State<PowerMode> {
  Future<bool> isPowerProfilesCtrlAvailable =
      File("/usr/bin/powerprofilesctl").exists();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isPowerProfilesCtrlAvailable,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return FutureBuilder<Map>(
            future: getModesWithCurrentState(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MintYPage(
                  title: AppLocalizations.of(context)!.powerMode,
                  customContentElement: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Power Saver
                        snapshot.data!.containsKey("power-saver")
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.battery_saver,
                                    color: MintY.currentColor,
                                    size: 96,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.powerSaver,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  MintYButton(
                                    text: Text(
                                      snapshot.data!["power-saver"]
                                          ? AppLocalizations.of(context)!.active
                                          : AppLocalizations.of(context)!
                                              .activate,
                                      style: MintY.heading4White,
                                    ),
                                    color: snapshot.data!["power-saver"]
                                        ? MintY.currentColor
                                        : Colors.black54,
                                    onPressed: () async {
                                      if (!snapshot.data!["power-saver"]) {
                                        await Linux.runCommandAndGetStdout(
                                            "powerprofilesctl set power-saver");
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(width: 32),
                        // Balanced
                        snapshot.data!.containsKey("power-saver")
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.balance,
                                    color: MintY.currentColor,
                                    size: 96,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.balanced,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  MintYButton(
                                    text: Text(
                                      snapshot.data!["balanced"]
                                          ? AppLocalizations.of(context)!.active
                                          : AppLocalizations.of(context)!
                                              .activate,
                                      style: MintY.heading4White,
                                    ),
                                    color: snapshot.data!["balanced"]
                                        ? MintY.currentColor
                                        : Colors.black54,
                                    onPressed: () async {
                                      if (!snapshot.data!["balanced"]) {
                                        await Linux.runCommandAndGetStdout(
                                            "powerprofilesctl set balanced");
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(width: 32),
                        // Performance
                        snapshot.data!.containsKey("performance")
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.speed,
                                    color: MintY.currentColor,
                                    size: 96,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.performance,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  MintYButton(
                                    text: Text(
                                      snapshot.data!["performance"]
                                          ? AppLocalizations.of(context)!.active
                                          : AppLocalizations.of(context)!
                                              .activate,
                                      style: MintY.heading4White,
                                    ),
                                    color: snapshot.data!["performance"]
                                        ? MintY.currentColor
                                        : Colors.black54,
                                    onPressed: () async {
                                      if (!snapshot.data!["performance"]) {
                                        Linux.runCommandAndGetStdout(
                                            "powerprofilesctl set performance");
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  bottom: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MintYButtonNavigate(
                        route: const MainSearchLoader(),
                        text: Text(AppLocalizations.of(context)!.backToSearch,
                            style: MintY.heading4White),
                        color: MintY.currentColor,
                      ),
                    ],
                  ),
                );
              } else {
                return const MintYLoadingPage();
              }
            },
          );
        } else if (snapshot.hasData && !snapshot.data!) {
          // Install powerprofilesctl
          return MintYPage(
              title: AppLocalizations.of(context)!
                  .installX("power-profiles-daemon"),
              contentElements: [
                Text(
                  AppLocalizations.of(context)!
                      .installPowerProfilesDeamonDescription,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ],
              bottom: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MintYButtonNavigate(
                    route: const MainSearchLoader(),
                    text: Text(AppLocalizations.of(context)!.backToSearch,
                        style: MintY.heading4),
                  ),
                  const SizedBox(width: 16),
                  MintYButtonNext(
                    onPressedFuture: () async {
                      await Linux.installApplications(
                          ["power-profiles-daemon"]);
                    },
                    route: RunCommandQueue(
                        route: const PowerMode(),
                        title: AppLocalizations.of(context)!
                            .installX("power-profiles-daemon")),
                  ),
                ],
              ));
        } else {
          return const MintYLoadingPage();
        }
      },
    );
  }

  Future<Map> getModesWithCurrentState() async {
    String output = await Linux.runCommandAndGetStdout("powerprofilesctl");
    Map<String, bool> modes = {};

    for (var line in output.split("\n")) {
      if (line.contains("performance")) {
        modes["performance"] = line.contains("*");
      }
      if (line.contains("power-saver")) {
        modes["power-saver"] = line.contains("*");
      }
      if (line.contains("balanced")) {
        modes["balanced"] = line.contains("*");
      }
    }

    return modes;
  }
}
