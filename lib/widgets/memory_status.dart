import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linux_assistant/linux/linux_system.dart';
import 'package:linux_assistant/widgets/hardware_info.dart';
import 'package:linux_assistant/widgets/single_bar_chart.dart';
import 'package:linux_assistant/services/linux.dart';

class SystemStatus extends StatefulWidget {
  const SystemStatus({Key? key}) : super(key: key);

  @override
  State<SystemStatus> createState() => _SystemStatusState();
}

Future<List<Object>> _getAllFutures() async {
  return await Future.wait([
    Linux.runCommand("free -m", hostOnFlatpak: false),
    LinuxSystem.getCpuAverageLoad(),
  ]);
}

class _SystemStatusState extends State<SystemStatus> {
  // Start clock timer for refresh every 2 seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 2), (Timer t) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var allFutures = _getAllFutures();
    return FutureBuilder<List<Object>>(
      future: allFutures,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String outputFreeM = snapshot.data![0] as String;
          List<String> lines = outputFreeM.split("\n");
          List<Widget> widgets = [];

          // CPU
          // double is in snapshot.data[1] (List<Object>)
          double cpuLoad = snapshot.data![1] as double;
          widgets.add(SingleBarChart(
            value: cpuLoad < 0.9 ? cpuLoad + 0.1 : max(cpuLoad, 1),
            fillColor:
                cpuLoad < 1 ? const Color.fromARGB(255, 70, 153, 221) : Colors.red,
            tooltip: "${(cpuLoad * 100).toStringAsFixed(2)}% (~1 min)",
            text: "CPU",
          ));

          widgets.add(const SizedBox(
            width: 15,
          ));

          // RAM
          if (lines.length >= 2) {
            List<String> values = convertLineToList(lines[1]);
            widgets.add(SingleBarChart(
              value: double.parse(values[2]) / double.parse(values[1]),
              fillColor: const Color.fromARGB(255, 193, 119, 243),
              tooltip: "${convertToGB(values[2])}/${convertToGB(values[1])}",
              text: "RAM",
            ));
          }

          widgets.add(const SizedBox(
            width: 15,
          ));

          // SWAP:
          if (lines.length >= 3) {
            List<String> values = convertLineToList(lines[2]);
            widgets.add(SingleBarChart(
              value: double.parse(values[2]) / double.parse(values[1]),
              fillColor: const Color.fromARGB(255, 223, 157, 58),
              tooltip: "${convertToGB(values[2])}/${convertToGB(values[1])}",
              text: "Swap",
            ));

            widgets.add(const SizedBox(
              width: 15,
            ));
          }

          // Remove last space widget if the swap is not available
          widgets.removeLast();

          widgets.add(const SizedBox(
            width: 20,
          ));

          widgets.add(const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HardwareInfo(),
            ],
          ));

          return Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: widgets,
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  List<String> convertLineToList(String line) {
    List<String> values = line.split(" ");
    values.removeWhere((element) => element == "");
    return values;
  }

  String convertToGB(string) {
    double value = double.parse(string);
    value /= 100;
    int v1 = value.ceil();
    double v2 = v1 / 10;
    return "${v2}G";
  }
}
