import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_helper/services/icon_loader.dart';

class SystemIcon extends StatelessWidget {
  const SystemIcon({required this.iconString, this.iconSize = 100});
  final String iconString;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    IconLoader iconLoader = IconLoader();
    if (iconLoader.isIconLoaded(iconString, iconSize: iconSize)) {
      return iconLoader.getIconFromCache(iconString, iconSize: iconSize);
    } else {
      return FutureBuilder<Widget>(
        future: iconLoader.getIconForApp(iconString, iconSize: iconSize),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          }
          return const CircularProgressIndicator();
        },
      );
    }
  }
}
