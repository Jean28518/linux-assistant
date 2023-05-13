import 'dart:async';
import 'package:flutter/material.dart';
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
          return Card(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text.rich(
                      strutStyle: const StrutStyle(leading: 0.6),
                      TextSpan(children: [
                        TextSpan(
                            text: "${values[0]}\n",
                            style:
                                const TextStyle(fontWeight: FontWeight.normal)),
                        const WidgetSpan(
                            child: Icon(Icons.info_outline, size: 18)),
                        TextSpan(
                            text: " ${values[1]}\n", style: const TextStyle()),
                        const WidgetSpan(child: Icon(Icons.build, size: 18)),
                        TextSpan(
                            text: " ${values[2]}\n", style: const TextStyle()),
                        const WidgetSpan(child: Icon(Icons.memory, size: 18)),
                        TextSpan(
                            text: " ${values[3]}\n", style: const TextStyle()),
                        const WidgetSpan(child: Icon(Icons.monitor, size: 18)),
                        TextSpan(
                            text: " ${values[4]}", style: const TextStyle()),
                      ]))));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
