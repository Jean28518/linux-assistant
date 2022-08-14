import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_helper/layouts/mintY.dart';
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
                icon: Image.asset(
                  "assets/images/firefox_logo.png",
                  width: 150,
                ),
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
                icon: Image.asset(
                  "assets/images/chromium_logo.png",
                  width: 150,
                ),
                title: "Chromium",
                text: "Open Source browser. Free base of Google Chrom.e",
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
                icon: Image.asset(
                  "assets/images/chrome_logo.png",
                  width: 150,
                ),
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
        bottom: MintYButtonNext(route: MainSearchLoader()),
      ),
    );
  }
}
