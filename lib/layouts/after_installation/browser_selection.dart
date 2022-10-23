import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/office_selection.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class AfterInstallationBrowserSelection extends StatefulWidget {
  AfterInstallationBrowserSelection({Key? key}) : super(key: key);

  Future<bool> firefoxInstalled = Linux.isApplicationInstalled("firefox");
  Future<bool> chromiumInstalled = Linux.isApplicationInstalled("chromium");
  Future<bool> chromeInstalled = Linux.isApplicationInstalled("chrome");

  @override
  State<AfterInstallationBrowserSelection> createState() =>
      _AfterInstallationBrowserSelectionState();
}

class _AfterInstallationBrowserSelectionState
    extends State<AfterInstallationBrowserSelection> {
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
                selected: true,
              ),
              SizedBox(
                width: 10,
              ),
              MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "chromium", iconSize: 150),
                title: "Chromium",
                text: "Open Source browser. Free base of Google Chrome.",
                selected: false,
              ),
              SizedBox(
                width: 10,
              ),
              MintYSelectableCardWithIcon(
                icon: const SystemIcon(
                    iconString: "google-chrome", iconSize: 150),
                title: "Google Chrome",
                text: "Proprietary browser from Google.",
                selected: false,
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
