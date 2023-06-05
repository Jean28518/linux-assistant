import 'package:flutter/material.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/widgets/single_bar_chart.dart';
import 'package:linux_assistant/services/linux.dart';

class DiskSpace extends StatelessWidget {
  const DiskSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> diskSpaces = Linux.runCommandWithCustomArgumentsAndGetStdOut(
        "python3",
        ["${Linux.executableFolder}additional/python/get_diskspace.py"]);

    return FutureBuilder<String>(
      future: diskSpaces,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<String> lines = snapshot.data!.split("\n");
          List<Widget> barCharts = [];
          for (String line in lines) {
            List<String> values = line.split("\t");
            if (values.length >= 6 && values[5] != "/boot/efi") {
              barCharts.add(
                SingleBarChart(
                  value: double.parse(
                        values[4].replaceAll("%", ""),
                      ) /
                      100,
                  text: "${getDisklabel(values[5])}: ${values[4]}",
                  tooltip: "${values[2]}/${values[1]}",
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
