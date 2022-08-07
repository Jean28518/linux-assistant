import 'package:linux_helper/enums/browsers.dart';
import 'package:linux_helper/enums/desktops.dart';
import 'package:linux_helper/enums/distros.dart';

class Environment {
  var distribution = DISTROS.DEBIAN;
  var version = -1.0;
  var desktop = DESKTOPS.CINNAMON;
  var browser = BROWSERS.BRAVE;
  var language = "";

  Map<String, dynamic> toJson() {
    return {
      'distribution': distribution.toString(),
      'version': version,
      'desktop': desktop.toString(),
      'browser': browser.toString(),
      'language': language,
    };
  }

  Environment.fromJson(Map<String, dynamic> input) {
    distribution = getDistrosEnumOfString(input['distribution']);
    version = input['version'];
    desktop = getDektopEnumOfString(input['desktop']);
    browser = getBrowserEnumOfString(input['browser']);
    language = input['language'];
  }

  Environment();
}
