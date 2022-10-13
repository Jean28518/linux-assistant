import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_helper/layouts/mintY.dart';
import 'package:linux_helper/layouts/system_icon.dart';
import 'package:linux_helper/services/icon_loader.dart';
import 'package:linux_helper/services/main_search_loader.dart';

class AfterInstallationOfficeSelection extends StatefulWidget {
  const AfterInstallationOfficeSelection({Key? key}) : super(key: key);

  @override
  State<AfterInstallationOfficeSelection> createState() =>
      _AfterInstallationOfficeSelectionState();
}

class _AfterInstallationOfficeSelectionState
    extends State<AfterInstallationOfficeSelection> {
  bool libreOfficeSelected = true;
  bool onlyOfficeSelected = false;
  bool softmakerOfficeSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MintYPage(
        title: "Office Selection",
        contentElements: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MintYSelectableCardWithIcon(
                icon:
                    const SystemIcon(iconString: "libreoffice", iconSize: 150),
                title: "Libre Office",
                text:
                    "Open Source Office Suite from The Document Foundation.\nGreat for the Open Document Format (.odt, .ods, .odp).",
                selected: libreOfficeSelected,
                onPressed: () {
                  libreOfficeSelected = !libreOfficeSelected;
                  setState(() {});
                },
              ),
              SizedBox(
                width: 10,
              ),
              MintYSelectableCardWithIcon(
                icon: const SystemIcon(iconString: "onlyoffice", iconSize: 150),
                title: "Only Office",
                text:
                    "Open Source Office Suite. Good for the Microsoft Document Format (docx, .xls, .ppt).",
                selected: onlyOfficeSelected,
                onPressed: () {
                  onlyOfficeSelected = !onlyOfficeSelected;
                  setState(() {});
                },
              ),
              SizedBox(
                width: 10,
              ),
              MintYSelectableCardWithIcon(
                icon: const SystemIcon(
                    iconString: "softmaker-freeoffice", iconSize: 150),
                title: "Softmaker FreeOffice",
                text:
                    "Proprietary Office Suite.\nGood for the Microsoft Document Format (.docx, .xls, .ppt)",
                selected: softmakerOfficeSelected,
                onPressed: () {
                  softmakerOfficeSelected = !softmakerOfficeSelected;
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
