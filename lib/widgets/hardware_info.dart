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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InfoLineWithIcon(
          text:
              "${Linux.currentenvironment.username}@${Linux.currentenvironment.hostname}",
          iconData: Icons.person,
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        InfoLineWithIcon(
            text: Linux.currentenvironment.osPrettyName, iconData: Icons.info),
        InfoLineWithIcon(
            text: "Kernel ${Linux.currentenvironment.kernelVersion}",
            iconData: Icons.settings),
        InfoLineWithIcon(
            text: Linux.currentenvironment.cpuModel, iconData: Icons.memory),
        InfoLineWithIcon(
            text: Linux.currentenvironment.gpuModel, iconData: Icons.monitor),
      ],
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
