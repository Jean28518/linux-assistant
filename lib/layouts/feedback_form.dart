import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/enviroment.dart';

class FeedbackDialog extends StatelessWidget {
  String searchText;
  List<ActionEntry> foundEntries;
  Environment environment;

  FeedbackDialog({super.key, this.searchText = "", this.foundEntries = const [], this.environment = });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text("Test"),
    );
  }
}
