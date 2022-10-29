import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/system_icon.dart';
import 'package:linux_assistant/services/icon_loader.dart';
import 'package:linux_assistant/services/main_search_loader.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/services/action_handler.dart';

class ActionEntryCard extends StatelessWidget {
  const ActionEntryCard(
      {required this.actionEntry,
      required this.callback,
      this.selected = false});

  final ActionEntry actionEntry;
  final VoidCallback callback;
  final selected;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    Widget icon = getIcon();
    return Card(
      child: InkWell(
        child: ListTile(
          key: UniqueKey(),
          tileColor: selected
              ? Theme.of(context).focusColor
              : Theme.of(context).cardColor,
          hoverColor: Colors.grey,
          title: Text(actionEntry.name),
          subtitle: Text(actionEntry.description),
          // For debugging search index:
          // subtitle: Text(
          //     "${actionEntry.description} | ${actionEntry.priority} | ${actionEntry.tmpPriority}"),
          leading: icon,
        ),
        onTap: () {
          ActionHandler.handleActionEntry(actionEntry, callback, context);
        },
      ),
    );
  }

  Widget getIcon() {
    if (actionEntry.iconWidget != null) {
      return actionEntry.iconWidget!;
    }
    if (actionEntry.action.startsWith("openfolder:")) {
      return Icon(
        Icons.folder,
        size: 48,
      );
    }
    if (actionEntry.action.startsWith("openapp:")) {
      IconLoader iconLoader = IconLoader();
      return SystemIcon(
        iconString: actionEntry.iconURI,
        iconSize: 48,
      );
    }
    if (actionEntry.action.startsWith("websearch:")) {
      return Icon(
        Icons.search,
        size: 48,
      );
    }
    if (actionEntry.action.startsWith("openwebsite:")) {
      return Icon(
        Icons.web,
        size: 48,
      );
    }
    if (actionEntry.action.startsWith("openfile:")) {
      return Icon(
        Icons.description,
        size: 48,
      );
    }
    return (Icon(
      Icons.star,
      size: 48,
    ));
  }
}
