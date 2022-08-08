import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:linux_helper/services/linux.dart';

class IconLoader {
  // handle IconLoader as a singleton
  static final IconLoader _instance = IconLoader._privateConstructor();
  factory IconLoader() {
    return _instance;
  }
  IconLoader._privateConstructor();

  Map cache = {};

  Future<Image> getIconForApp(appCode) async {
    if (cache.containsKey(appCode)) {
      return cache[appCode];
    }
    String iconPath = await Linux.runCommandWithCustomArgumentsAndGetStdOut(
        "python3", [
      "${Linux.executableFolder}python/get_icon_path_2.py",
      "--icon=${appCode}"
    ]);

    if (iconPath.contains("not found")) {
      if (cache.containsKey("!default!")) {
        cache[appCode] = cache['!default!'];
      } else {
        String defaultIconPath =
            await Linux.runCommandWithCustomArgumentsAndGetStdOut("python3", [
          "${Linux.executableFolder}python/get_icon_path_2.py",
          "--icon=applications-system"
        ]);
        Image image = Image.file(File(defaultIconPath.replaceAll("\n", "")));

        cache['!default!'] = image;
        cache[appCode] = image;
      }
      return cache[appCode];
    }

    File file = await File(iconPath.replaceAll("\n", ""));
    if (iconPath.contains(".svg")) {
      Image image = Image(
          width: 48, height: 48, image: Svg(iconPath.replaceAll("\n", "")));
      cache[appCode] = image;
      return image;
    } else {
      Image image = Image.file(file);
      cache[appCode] = image;
      return image;
    }
  }
}
