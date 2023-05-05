import 'package:flutter/material.dart';
import 'package:linux_assistant/content/basic_entries.dart';
import 'package:linux_assistant/content/recommendations.dart';
import 'package:linux_assistant/content/searchable_entry_examples.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/action_handler.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/widgets/system_icon.dart';

class FeatureOverview extends StatelessWidget {
  const FeatureOverview({super.key});

  @override
  Widget build(BuildContext context) {
    List<ActionEntry> actionEntries = [];
    actionEntries.addAll(getBasicEntries(context));
    actionEntries.addAll(getRecommendations(context));
    actionEntries.addAll(getSearchableEntryExamples(context));

    List<Widget> tableContent = [];
    for (ActionEntry entry in actionEntries) {
      tableContent.add(Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MintYFeature(
              heading: entry.name,
              description: entry.description,
              icon: entry.iconWidget == null
                  ? SystemIcon(
                      iconString: entry.iconURI,
                    )
                  : entry.iconWidget!,
            ),
          ),
          onTap: () {
            ActionHandler.handleActionEntry(entry, () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MainSearchLoader(),
              ));
            }, context);
          },
        ),
      ));
    }
    return MintYPage(
      title: AppLocalizations.of(context)!.featureOverview,
      customContentElement: MintYGrid(
        ratio: 2,
        widgetSize: 400,
        children: tableContent,
      ),
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MintYButtonNavigate(
            route: const MainSearchLoader(),
            color: MintY.currentColor,
            text: Text(
              AppLocalizations.of(context)!.backToSearch,
              style: MintY.heading4White,
            ),
          ),
        ],
      ),
    );
  }
}
