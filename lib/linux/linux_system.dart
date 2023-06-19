import 'package:linux_assistant/helpers/command_helper.dart';

class Uptime {
  final String unit;
  final int value;

  const Uptime(this.unit, this.value);
}

abstract class LinuxSystem {
  static Future<bool> hasSwap() async {
    var cmdResult = await CommandHelper.run("/usr/bin/free");
    if (!cmdResult.success) {
      throw Exception(cmdResult.error);
    }

    return cmdResult.output.contains("Swap");
  }

  static Future<Uptime> uptime() async {
    var cmdResult =
        await CommandHelper.run("/usr/bin/uptime", env: {"LC_ALL": "C"});

    if (!cmdResult.success) {
      throw Exception(cmdResult.output);
    }

    var values = cmdResult.output.replaceAll(RegExp(r" +"), " ").split(" ");
    if (values[2].contains(":")) {
      var arr = values[2].split(":");
      int hourValue = int.parse(arr[0]);
      int minuteValue = int.parse(arr[1].replaceAll(",", ""));
      return hourValue == 0 ? Uptime("m", minuteValue) : Uptime("h", hourValue);
    } else {
      return Uptime("d", int.parse(values[2]));
    }
  }
}
