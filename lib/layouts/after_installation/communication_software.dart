import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/after_installation/automatic_configuration_entry.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class AfterInstallationCommunicationSoftwareSelection extends StatefulWidget {
  const AfterInstallationCommunicationSoftwareSelection({Key? key})
      : super(key: key);

  @override
  State<AfterInstallationCommunicationSoftwareSelection> createState() =>
      _AfterInstallationCommunicationSoftwareSelectionState();
}

class _AfterInstallationCommunicationSoftwareSelectionState
    extends State<AfterInstallationCommunicationSoftwareSelection> {
  @override
  Widget build(BuildContext context) {
    const double padding = 20;
    List<Widget> content = [
      MintYSelectableCardWithIcon(
        icon: const SystemIcon(iconString: "thunderbird", iconSize: 150),
        title: "Thunderbird",
        text: "Open Source E-Mail Client from Mozilla.",
        selected: true,
      ),
      MintYSelectableCardWithIcon(
        icon: const SystemIcon(iconString: "jitsi", iconSize: 150),
        title: "Jitsi Meet",
        text: "Open Source video conference tool.",
        selected: false,
      ),
      MintYSelectableCardWithIcon(
        icon: const SystemIcon(iconString: "element", iconSize: 150),
        title: "Element",
        text: "Open Source messaging tool based on matrix protocol.",
        selected: false,
      ),
      MintYSelectableCardWithIcon(
        icon: const SystemIcon(iconString: "discord", iconSize: 150),
        title: "Discord",
        text: "Proprietary community chat software",
        selected: false,
      ),
      MintYSelectableCardWithIcon(
        icon: const SystemIcon(iconString: "us.zoom.Zoom", iconSize: 150),
        title: "Zoom",
        text: "Proprietary conference software.",
        selected: false,
      ),
      MintYSelectableCardWithIcon(
        icon: const SystemIcon(iconString: "microsoft-teams", iconSize: 150),
        title: "Microsoft Teams",
        text: "Proprietary team communication software.",
        selected: false,
      ),
    ];

    int columsCount =
        ((MediaQuery.of(context).size.width - (2 * padding)) / (440)).round();

    // Insert space Elements for last row, that the elements are something like centered
    if ((content.length % columsCount) != 0) {
      int spacingCounts =
          ((columsCount - (content.length % columsCount)) / 2).floor();
      for (int i = 0; i < spacingCounts; i++) {
        content.insert(
            content.length - content.length % columsCount, Container());
      }
    }
    return Scaffold(
      body: MintYPage(
        title: "Communication Software",
        customContentElement: Expanded(
          child: GridView.count(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(padding),
            crossAxisCount: columsCount,
            childAspectRatio: 350 / 400,
            children: content,
          ),
        ),
        bottom: MintYButtonNext(
            route: const AfterInstallationAutomaticConfigurationEntry()),
      ),
    );
  }
}
