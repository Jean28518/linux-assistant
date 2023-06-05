import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/widgets/success_message.dart';
import 'package:linux_assistant/widgets/warning_message.dart';

class LinuxHealthOverview extends StatefulWidget {
  const LinuxHealthOverview({super.key});

  @override
  State<LinuxHealthOverview> createState() => _LinuxHealthOverviewStat();
}

class _LinuxHealthOverviewStat extends State<LinuxHealthOverview> {
  Timer? reloadTimer;

  @override
  Widget build(BuildContext context) {
    late Future<String> output = Linux.runPythonScript("check_linux_health.py");
    reloadTimer ??=
        Timer.periodic(const Duration(seconds: 5), (timer) => setState(() {}));

    return FutureBuilder<String>(
      future: output,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> lines = snapshot.data!.split("\n");

          String uptimeLength = "";
          String uptimeUnit = "";
          bool uptimeWarning = false;
          List<Widget> diskWarnings = [];
          int processes = 0;
          int zombies = 0;
          int removableDevices = 0;
          int swaps = 0;
          List<List<dynamic>> topMemoryProcesses = [];
          List<List<dynamic>> topCPUProcesses = [];
          for (int i = 0; i < lines.length; i++) {
            String line = lines[i];
            if (line.startsWith("uptime: ")) {
              uptimeLength = line.replaceAll("uptime: ", "");
              if (uptimeLength.length > 4) {
                uptimeWarning = true;
              }

              if (uptimeLength.length < 3) {
                uptimeUnit = AppLocalizations.of(context)!.minutes;
              } else if (line.contains("days")) {
                uptimeUnit = AppLocalizations.of(context)!.days;
                uptimeLength = uptimeLength.replaceAll("days", "");
              } else {
                uptimeUnit = AppLocalizations.of(context)!.hours;
              }

              // Read Diskspaces
              for (int j = i + 1; true; j++) {
                String line = lines[j];
                if (line.startsWith("processes: ")) {
                  break;
                }
                List<String> values = line.split("\t");
                if (int.parse(values[4].replaceAll("%", "")) > 90) {
                  WarningMessage warningMessage = WarningMessage(
                      text: "${AppLocalizations.of(context)!.diskspaceWarning1}"
                          "${values[0]} ${values[5]}"
                          "${AppLocalizations.of(context)!.diskspaceWarning2}"
                          "${values[3]}");
                  diskWarnings.add(warningMessage);
                }
              }
            }

            if (line.startsWith("processes: ")) {
              processes = int.parse(line.replaceAll("processes: ", ""));
            }
            if (line.startsWith("zombies: ")) {
              zombies = int.parse(line.replaceAll("zombies: ", ""));
            }
            if (line.startsWith("removable_devices: ")) {
              removableDevices =
                  int.parse(line.replaceAll("removable_devices: ", ""));
            }
            if (line.startsWith("swaps: ")) {
              swaps = int.parse(line.replaceAll("swaps: ", ""));
            }

            if (line.startsWith("Top 3 Memory:")) {
              topMemoryProcesses.add([
                AppLocalizations.of(context)!.memoryUsage,
                AppLocalizations.of(context)!.process
              ]);
              // Read Top 3 Memory
              for (int j = 1; j <= 3; j++) {
                String line = lines[j + i];
                List<String> values = line.split(" ");
                topMemoryProcesses.add(["${values[0]}%", values[1]]);
              }
            }

            if (line.startsWith("Top 3 CPU:")) {
              topCPUProcesses.add([
                AppLocalizations.of(context)!.cpuUsage,
                AppLocalizations.of(context)!.process
              ]);
              // Read Top 3 Memory
              for (int j = 1; j <= 3; j++) {
                String line = lines[j + i];
                List<String> values = line.split(" ");
                topCPUProcesses.add(["${values[0]}%", values[1]]);
              }
            }
          }

          return MintYPage(
            title: AppLocalizations.of(context)!.linuxHealth,
            contentElements: [
              Text(
                AppLocalizations.of(context)!.runtime,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              uptimeWarning
                  ? WarningMessage(
                      text: AppLocalizations.of(context)!
                          .uptimeWarning(uptimeLength, uptimeUnit))
                  : SuccessMessage(
                      text: AppLocalizations.of(context)!
                          .uptimePass(uptimeLength, uptimeUnit)),
              zombies == 0
                  ? SuccessMessage(
                      text: AppLocalizations.of(context)!
                          .processesWithZombiesMessage(processes, zombies))
                  : WarningMessage(
                      text: AppLocalizations.of(context)!
                          .processesWithZombiesMessage(processes, zombies)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.topMemoryProcesses,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MintYTable(data: topMemoryProcesses),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.topCPUProcesses,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MintYTable(data: topCPUProcesses),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                AppLocalizations.of(context)!.memoryAndStorage,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              diskWarnings.isEmpty
                  ? SuccessMessage(
                      text: AppLocalizations.of(context)!.diskspacePass,
                    )
                  : Column(
                      children: diskWarnings,
                    ),
              removableDevices == 0
                  ? SuccessMessage(
                      text: AppLocalizations.of(context)!.removableDevicesPass)
                  : WarningMessage(
                      text: AppLocalizations.of(context)!
                          .removableDevicesWarning(removableDevices)),
              swaps == 0
                  ? WarningMessage(
                      text: AppLocalizations.of(context)!.swapsWarning)
                  : SuccessMessage(
                      text: AppLocalizations.of(context)!.swapsPass),
            ],
            bottom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButtonNavigate(
                  route: const MainSearchLoader(),
                  color: MintY.currentColor,
                  text: Text(
                    AppLocalizations.of(context)!.backToSearch,
                    style: MintY.heading4White,
                  ),
                  onPressed: () => reloadTimer?.cancel(),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return MintYLoadingPage(
              text: AppLocalizations.of(context)!.analysingLinuxHealth);
        }
      },
    );
  }
}
