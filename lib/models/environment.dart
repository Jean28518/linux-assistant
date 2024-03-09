import 'package:linux_assistant/enums/browsers.dart';
import 'package:linux_assistant/enums/desktops.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';

class Environment {
  var distribution = DISTROS.DEBIAN;
  var version = -1.0;
  var versionString = "";
  var desktop = DESKTOPS.CINNAMON;
  var browser = BROWSERS.FIREFOX;
  var language = "";
  List<SOFTWARE_MANAGERS> installedSoftwareManagers = [];
  var preferredSoftwareManager = SOFTWARE_MANAGERS.APT;
  bool wayland = false;
  bool runningInFlatpak = false;

  /// All these variables are generated at runtime
  String username = "";
  String hostname = "";
  String osPrettyName = "";
  String kernelVersion = "";
  String cpuModel = "";
  String gpuModel = "";
  List<String> groups = [];

  /// POSIX User ID.
  var currentUserId = 1000;

  // Loaded at runtime:
  bool nvidiaCardAndNouveauRunning = false;

  Map<String, dynamic> toJson() {
    return {
      'distribution': distribution.toString(),
      'version': version,
      'versionString': versionString,
      'desktop': desktop.toString(),
      'browser': browser.toString(),
      'language': language,
      'installedSoftwareManagers': installedSoftwareManagers.join(";"),
      'preferredSoftwareManager': preferredSoftwareManager.toString(),
      'currentUserId': currentUserId,
      'wayland': wayland
    };
  }

  Environment.fromJson(Map<String, dynamic> input) {
    distribution = getEnumFromString(input['distribution']);
    version = input['version'];
    desktop = getDektopEnumOfString(input['desktop']);
    browser = getBrowserEnumOfString(input['browser']);
    language = input['language'];
    List<String> installedSoftwareManagersStrings =
        input["installedSoftwareManagers"].toString().split(";");
    for (String string in installedSoftwareManagersStrings) {
      installedSoftwareManagers.add(getSoftwareManagerEnumOfString(string));
    }
    preferredSoftwareManager =
        getSoftwareManagerEnumOfString(input["preferredSoftwareManager"]);
    currentUserId = input['currentUserId'];
  }

  Environment();
}
