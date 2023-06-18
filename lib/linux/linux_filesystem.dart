import 'package:linux_assistant/helpers/command_helper.dart';

class DeviceInfo {
  final String filesystem;
  final String mountPoint;
  final String size;
  final String sizeFree;
  final String sizeUsed;
  final int usedPercent;

  const DeviceInfo(this.filesystem, this.size, this.sizeUsed, this.sizeFree,
      this.usedPercent, this.mountPoint);
}

abstract class LinuxFilesystem {
  static Future<List<DeviceInfo>> devices() async {
    var cmdResult = await CommandHelper.runWithArguments("df", ["-h"]);
    if (!cmdResult.item1) {
      throw Exception(cmdResult.item2);
    }

    var ignore = [
      "df:",
      "udev",
      "tmpfs",
      "/dev/loop",
      "revokefs-fuse",
      "cgroup"
    ];

    var lines = cmdResult.item2
        .split("\n")
        .skip(1)
        .where((x) => !ignore.any((y) => x.startsWith(y)));

    var devices = List<DeviceInfo>.empty(growable: true);
    var devicesRead = List<String>.empty(growable: true);
    for (var line in lines) {
      var values = line.split(" ");
      values.removeWhere((x) => x == "");
      if (devicesRead.contains(values[0]) || values[1].endsWith("M")) {
        continue;
      }

      devices.add(DeviceInfo(values[0], values[1], values[2], values[3],
          int.parse(values[4].substring(0, values[4].length - 1)), values[5]));

      devicesRead.add(values[0]);
    }

    return devices;
  }
}
