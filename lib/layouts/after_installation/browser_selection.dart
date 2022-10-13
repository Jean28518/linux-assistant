import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_helper/layouts/after_installation/office_selection.dart';
import 'package:linux_helper/layouts/mintY.dart';
import 'package:linux_helper/layouts/system_icon.dart';
import 'package:linux_helper/services/icon_loader.dart';
import 'package:linux_helper/services/main_search_loader.dart';

class AfterInstallationBrowserSelection extends StatefulWidget {
  const AfterInstallationBrowserSelection({Key? key}) : super(key: key);

  @override
  State<AfterInstallationBrowserSelection> createState() =>
      _AfterInstallationBrowserSelectionState();
}

class _AfterInstallationBrowserSelectionState
    extends State<AfterInstallationBrowserSelection> {
  bool firefoxSelected = true;
  bool chromiumSelected = false;
  bool chromeSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MintYPage(
        title: "Browser Selection",
        contentElements: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "firefox", iconSize: 150),
                title: "Firefox",
                text: "Open Source browser with focus on privacy by Mozilla.",
                selected: firefoxSelected,
                onPressed: () {
                  firefoxSelected = !firefoxSelected;
                  setState(() {});
                },
              ),
              SizedBox(
                width: 10,
              ),
              MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "chromium", iconSize: 150),
                title: "Chromium",
                text: "Open Source browser. Free base of Google Chrome.",
                selected: chromiumSelected,
                onPressed: () {
                  chromiumSelected = !chromiumSelected;
                  setState(() {});
                },
              ),
              SizedBox(
                width: 10,
              ),
              MintYSelectableCardWithIcon(
                icon: const SystemIcon(
                    iconString: "google-chrome", iconSize: 150),
                title: "Google Chrome",
                text: "Proprietary browser from Google.",
                selected: chromeSelected,
                onPressed: () {
                  chromeSelected = !chromeSelected;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
        bottom:
            MintYButtonNext(route: const AfterInstallationOfficeSelection()),
      ),
    );
  }
}
