import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/services/linux.dart';

class HardwareInfo extends StatefulWidget {
  const HardwareInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HardwareInfoState();
}

class _HardwareInfoState extends State<HardwareInfo> {
  @override
  Widget build(BuildContext context) {
    var futures = [
      Linux.getUserAndHostname(),
      Linux.getOsPrettyName(),
      Linux.getKernelVersion(),
      Linux.getCpuModel(),
      Linux.getGpuModel()
    ];

    return FutureBuilder(
      future: Future.wait(futures),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          var values = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoLineWithIcon(
                text: values[0],
                iconData: Icons.person,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 10),
              InfoLineWithIcon(text: values[1], iconData: Icons.info),
              InfoLineWithIcon(
                  text: "Linux ${values[2]}", iconData: Icons.settings),
              InfoLineWithIcon(text: values[3], iconData: Icons.memory),
              InfoLineWithIcon(text: values[4], iconData: Icons.monitor),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class InfoLineWithIcon extends StatelessWidget {
  const InfoLineWithIcon({
    super.key,
    required this.iconData,
    required this.text,
    this.textStyle,
  });

  final IconData iconData;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          size: 15,
          color: MintY.currentColor,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.bodyMedium!,
        )
      ],
    );
  }
}
