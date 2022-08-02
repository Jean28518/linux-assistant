import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SingleBarChart extends StatelessWidget {
  late double size;
  late double value;
  late Color backgroundColor;
  late Color fillColor;
  late String text;
  late String tooltip;
  late TextStyle textStyle;

  SingleBarChart({
    Key? key,
    this.value = 0.5,
    this.size = 100,
    this.backgroundColor = const Color.fromARGB(122, 158, 158, 158),
    this.fillColor = const Color.fromARGB(255, 58, 58, 58),
    this.text = "",
    this.textStyle = const TextStyle(),
    this.tooltip = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 30,
          height: size,
          child: BarChart(
            BarChartData(
              maxY: size,
              minY: 0,
              alignment: BarChartAlignment.spaceEvenly,
              barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: backgroundColor,
                      getTooltipItem: ((group, groupIndex, rod, rodIndex) {
                        switch (groupIndex) {
                          case 0:
                            return BarTooltipItem(tooltip, textStyle);
                          default:
                            return null;
                        }
                      }))),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              barGroups: [generateGroupData()],
              titlesData: FlTitlesData(show: false),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }

  BarChartGroupData generateGroupData() {
    return BarChartGroupData(
      x: 0,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 2.5,
          toY: value * (size - 2.5) + 2.5,
          color: fillColor,
          width: 15,
        ),
        BarChartRodData(
          fromY: 0,
          toY: size,
          color: backgroundColor,
          width: 20,
        ),
      ],
    );
  }
}
