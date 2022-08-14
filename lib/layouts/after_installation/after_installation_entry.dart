import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_helper/layouts/after_installation/browser_selection.dart';
import 'package:linux_helper/layouts/mintY.dart';

class AfterInstallationEntry extends StatelessWidget {
  const AfterInstallationEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MintYPage(
        title: "After installation",
        contentElements: [
          Text(
            "Welcome to your new linux machine!",
            style: MintY.heading1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "In the next minutes you will configure your linux machine to your needs.",
            style: MintY.paragraph,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MintYButtonNavigate(
                text: Text("Let's start!", style: MintY.heading2White),
                route: AfterInstallationBrowserSelection(),
                color: MintY.currentColor,
                // width: 400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
