import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_helper/enums/distros.dart';
import 'package:linux_helper/layouts/single_bar_chart.dart';
import 'package:linux_helper/services/linux.dart';

class DiskSpace extends StatelessWidget {
  const DiskSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> diskSpaces =
        Linux.runCommandAndGetStdout("python3 python/get_diskspace.py");

    return FutureBuilder<String>(
      future: diskSpaces,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<String> lines = snapshot.data!.split("\n");
          List<Widget> barCharts = [];
          List<Text> descriptions = [];
          for (String line in lines) {
            List<String> values = line.split("\t");
            if (values.length >= 6 && values[5] != "/boot/efi") {
              barCharts.add(
                SingleBarChart(
                  value: double.parse(
                        values[4].replaceAll("%", ""),
                      ) /
                      100,
                  text: getDisklabel(values[5]) + ": " + values[4],
                  tooltip: values[2] + "/" + values[1],
                ),
              );
              barCharts.add(SizedBox(
                width: 20,
              ));
            }
          }
          barCharts.removeLast();
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: barCharts,
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }

  String getDisklabel(text) {
    String label = text.split("/").last;
    if (label == "") {
      label = getNiceStringOfDistrosEnum(Linux.currentEnviroment.distribution);
    }
    return label;
  }
}
