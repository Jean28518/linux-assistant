import 'dart:ffi';

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

    return cmdResult.output.toLowerCase().contains("swap");
  }

  /// Might be inaccurate
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
      // The new uptime output could be: 1 day,  1:23
      if (cmdResult.output.contains("min")) {
        return Uptime("m", int.parse(values[2]));
      }
      if (cmdResult.output.contains("day")) {
        return Uptime("d", int.parse(values[2]));
      }
      if (cmdResult.output.contains("hour")) {
        return Uptime("h", int.parse(values[2]));
      }
      return Uptime("m", int.parse(values[2]));
    }
  }

  static Future<int> getCpuThreadCount() async {
    var cmdResult = await CommandHelper.run("/usr/bin/nproc");
    if (!cmdResult.success) {
      print("Error: ${cmdResult.error}");
    }
    return int.parse(cmdResult.output);
  }

  /// Returns the average load of the CPU of the last minute
  /// Values are between 0 and 1
  static Future<double> getCpuAverageLoad() async {
    // Run cat /proc/loadavg
    var cmdResult =
        await CommandHelper.runWithArguments("/usr/bin/cat", ["/proc/loadavg"]);
    if (!cmdResult.success) {
      print("Error: ${cmdResult.error}");
    }
    double load = double.parse(cmdResult.output.split(" ")[0]);
    int cpuCount = await getCpuThreadCount();
    return load / cpuCount;
  }
}
