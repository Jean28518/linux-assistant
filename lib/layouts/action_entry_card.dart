import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_helper/services/main_search_loader.dart';
import 'package:linux_helper/models/action_entry.dart';
import 'package:linux_helper/services/action_handler.dart';

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
          leading: getIcon(),
        ),
        onTap: () {
          ActionHandler.handleActionEntry(actionEntry, callback);
        },
      ),
    );
  }

  Widget getIcon() {
    if (actionEntry.action.startsWith("openfolder:")) {
      return Icon(Icons.folder);
    }
    if (actionEntry.action.startsWith("openapp:")) {
      return Icon(Icons.apps);
    }
    if (actionEntry.action.startsWith("websearch:")) {
      return Icon(Icons.search);
    }
    if (actionEntry.action.startsWith("openwebsite:")) {
      return Icon(Icons.web);
    }
    return (Icon(Icons.star));
  }
}
