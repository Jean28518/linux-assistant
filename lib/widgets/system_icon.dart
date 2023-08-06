import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/linux.dart';

class SystemIcon extends StatelessWidget {
  const SystemIcon({
    required this.iconString,
    this.iconSize = 100,
    this.spinner = true,
  });
  final String iconString;
  final double iconSize;
  final bool spinner;

  @override
  Widget build(BuildContext context) {
    // Because of bug: https://github.com/flutter/flutter/issues/94869
    if (Linux.currentenvironment.nvidiaCardAndNouveauRunning) {
      return Icon(
        Icons.settings,
        size: iconSize,
        color: MintY.currentColor,
      );
    }

    IconLoader iconLoader = IconLoader();
    if (iconLoader.isIconLoaded(iconString, iconSize: iconSize)) {
      return iconLoader.getIconFromCache(iconString, iconSize: iconSize);
    } else {
      return FutureBuilder<Widget>(
        future: iconLoader.getIconForAppOrFile(iconString, iconSize: iconSize),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          }
          return spinner
              ? MintYProgressIndicatorCircle()
              : Icon(
                  Icons.settings,
                  size: iconSize,
                  color: MintY.currentColor,
                );
        },
      );
    }
  }
}
