import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/disk_cleaner/clean_disk.dart';
import 'package:linux_assistant/linux/linux_filesystem.dart';
import 'package:linux_assistant/widgets/single_bar_chart.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiskSpace extends StatelessWidget {
  DiskSpace({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Future<List<DeviceInfo>> systemDevices = LinuxFilesystem.disks();
    return FutureBuilder<List<DeviceInfo>>(
      future: systemDevices,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<DeviceInfo> devices = snapshot.data!;
          List<Widget> barCharts = [];
          for (DeviceInfo device in devices) {
            if (device.mountPoint != "/boot/efi") {
              barCharts.add(
                SingleBarChart(
                    value: device.usedPercent / 100,
                    text: "${getDisklabel(device.mountPoint)}: "
                        "${device.usedPercent}%",
                    tooltip: "${device.sizeUsed}/${device.size}",
                    fillColor: device.usedPercent > 89
                        ? Colors.red
                        : const Color.fromARGB(255, 141, 141, 141),
                    customWidgetBetweenAtBottom: device.usedPercent > 89
                        ? InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CleanDiskPage(mountpoint: device.mountPoint),
                            )),
                            child: Text(AppLocalizations.of(context)!.clean),
                          )
                        : null),
              );
              barCharts.add(const SizedBox(
                width: 20,
              ));
            }
          }
          barCharts.removeLast();
          return Card(
            child: Container(
              width: min(MediaQuery.of(context).size.width - 700,
                  barCharts.length * 55.0),
              height: 150,
              padding: const EdgeInsets.all(10),
              child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: barCharts.length,
                    itemBuilder: (context, index) {
                      return barCharts[index];
                    },
                  )),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }

  String getDisklabel(text) {
    String label = text.split("/").last;
    if (label == "") {
      label = getNiceStringOfDistrosEnum(Linux.currentenvironment.distribution);
    }
    return label;
  }
}
