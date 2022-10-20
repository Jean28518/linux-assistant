import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class AfterInstallationAutomaticConfiguration extends StatelessWidget {
  const AfterInstallationAutomaticConfiguration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MintYPage(
      title: "Automatic Configuration",
      contentElements: [
        MintYSelectableEntryWithIconHorizontal(
          icon: SystemIcon(
            iconString: "multimedia",
            iconSize: 128,
          ),
          title: "Multimedia Codecs Installation",
          selected: true,
          text:
              "Additional proprietary multimedia codes for playing videos and music.",
        ),
        MintYSelectableEntryWithIconHorizontal(
          icon: SystemIcon(
            iconString: "disks",
            iconSize: 128,
          ),
          title: "Automatic Snapshots",
          selected: true,
          text:
              "Configure automatic snapshots with timeshift. Timeshift will be configured to 2 monthly automatic snapshots on your root partition.",
        ),
        MintYSelectableEntryWithIconHorizontal(
          icon: SystemIcon(
            iconString: "cs-drivers",
            iconSize: 128,
          ),
          title: "Automatic Driver Installation",
          selected: true,
          text: "All recommended drivers will be installed.",
        ),
        MintYSelectableEntryWithIconHorizontal(
          icon: SystemIcon(
            iconString: "update-manager",
            iconSize: 128,
          ),
          title: "Automatic Update Manager Configuration",
          selected: true,
          text:
              "Automatic updates and maintainance will be configured. Also the fastest mirror server will be choosen for faster downloads.",
        ),
      ],
      bottom: MintYButtonNext(route: const MainSearchLoader()),
    );
  }
}
