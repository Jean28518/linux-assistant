import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_helper/layouts/search.dart';
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
        ),
        onTap: () {
          ActionHandler.handleActionEntry(actionEntry, callback);
        },
      ),
    );
  }
}
