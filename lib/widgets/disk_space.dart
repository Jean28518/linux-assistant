import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/linux/linux_filesystem.dart';
import 'package:linux_assistant/widgets/single_bar_chart.dart';
import 'package:linux_assistant/services/linux.dart';

class DiskSpace extends StatelessWidget {
  const DiskSpace({Key? key}) : super(key: key);

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
                  fillColor: const Color.fromARGB(255, 141, 141, 141),
                ),
              );
              barCharts.add(const SizedBox(
                width: 20,
              ));
            }
          }
          barCharts.removeLast();
          return Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: barCharts,
              ),
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
