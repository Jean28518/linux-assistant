import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/linux/linux_filesystem.dart';
import 'package:linux_assistant/linux/linux_process.dart';
import 'package:linux_assistant/linux/linux_system.dart';
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
    int maxProcs = 3;
    var futures = [
      LinuxFilesystem.disks(),
      LinuxProcess.processCount(),
      LinuxProcess.topProcessesByCpu(maxProcs),
      LinuxProcess.topProcessesByMemory(maxProcs),
      LinuxProcess.zombieCount(),
      LinuxSystem.hasSwap(),
      LinuxSystem.uptime()
    ];

    reloadTimer ??=
        Timer.periodic(const Duration(seconds: 5), (timer) => setState(() {}));

    return FutureBuilder(
      future: Future.wait(futures),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasData) {
          List<Object> results = snapshot.data!;
          var devices = results[0] as List<DeviceInfo>;
          var procCount = results[1] as int;
          var topProcsCpu = results[2] as List<ProcessStat>;
          var topProcsMem = results[3] as List<ProcessStat>;
          var zombies = results[4] as int;
          var hasSwap = results[5] as bool;
          var uptime = results[6] as Uptime;

          var removableCount = devices.where((x) => x.isRemovable).length;
          List<Widget> diskWarnings = [];
          for (var device in devices) {
            if (device.usedPercent > 90) {
              var warningMessage = WarningMessage(
                  text: "${AppLocalizations.of(context)!.diskspaceWarning1}"
                      "${device.filesystem} ${device.mountPoint}"
                      "${AppLocalizations.of(context)!.diskspaceWarning2}"
                      "${device.sizeFree}");
              diskWarnings.add(warningMessage);
            }
          }

          List<List<dynamic>> topCPUProcesses = [
            [
              AppLocalizations.of(context)!.cpuUsage,
              AppLocalizations.of(context)!.process
            ]
          ];

          for (var stat in topProcsCpu) {
            topCPUProcesses.add(["${stat.metricValue}%", stat.processName]);
          }

          List<List<dynamic>> topMemoryProcesses = [
            [
              AppLocalizations.of(context)!.memoryUsage,
              AppLocalizations.of(context)!.process
            ]
          ];

          for (var stat in topProcsMem) {
            topMemoryProcesses.add(["${stat.metricValue}%", stat.processName]);
          }

          String uptimeUnitText;
          switch (uptime.unit) {
            case "m":
              uptimeUnitText = AppLocalizations.of(context)!.minutes;
              break;
            case "h":
              uptimeUnitText = AppLocalizations.of(context)!.hours;
              break;
            default:
              uptimeUnitText = AppLocalizations.of(context)!.days;
              break;
          }

          bool uptimeWarning =
              uptime.unit == "d" || (uptime.unit == "h" && uptime.value >= 10);

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
                          .uptimeWarning(uptime.value, uptimeUnitText))
                  : SuccessMessage(
                      text: AppLocalizations.of(context)!
                          .uptimePass(uptime.value, uptimeUnitText)),
              zombies == 0
                  ? SuccessMessage(
                      text: AppLocalizations.of(context)!
                          .processesWithZombiesMessage(procCount, zombies))
                  : WarningMessage(
                      text: AppLocalizations.of(context)!
                          .processesWithZombiesMessage(procCount, zombies)),
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
              removableCount == 0
                  ? SuccessMessage(
                      text: AppLocalizations.of(context)!.removableDevicesPass)
                  : WarningMessage(
                      text: AppLocalizations.of(context)!
                          .removableDevicesWarning(removableCount)),
              hasSwap
                  ? SuccessMessage(
                      text: AppLocalizations.of(context)!.swapsPass)
                  : WarningMessage(
                      text: AppLocalizations.of(context)!.swapsWarning),
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
