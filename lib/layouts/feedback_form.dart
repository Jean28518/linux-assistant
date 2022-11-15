import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/enviroment.dart';

class FeedbackDialog extends StatefulWidget {
  String searchText;
  List<ActionEntry> foundEntries;
  Environment environment;

  bool includeSearchTermAndResults = true;
  bool includeBasicSystemInformation = true;

  FeedbackDialog(
      {super.key,
      this.searchText = "",
      this.foundEntries = const [],
      required this.environment});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Feedback",
                style: MintY.heading2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            maxLines: 10,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText:
                    "Are you missing a search result?\nFor what are you searching?\nDo you have suggestions for improvement?\n..."),
            style: MintY.paragraph,
          ),
          Row(
            children: [
              Checkbox(
                  value: widget.includeSearchTermAndResults,
                  onChanged: ((value) => setState(() {
                        widget.includeSearchTermAndResults = value!;
                      }))),
              Text(
                "Include search term and search results",
                style: MintY.paragraph,
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: widget.includeBasicSystemInformation,
                  onChanged: ((value) => setState(() {
                        widget.includeBasicSystemInformation = value!;
                      }))),
              Text(
                "Include basic system information",
                style: MintY.paragraph,
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MintYButton(
                text: Text(
                  "Cancel",
                  style: MintY.heading3,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 10,
              ),
              MintYButton(
                color: Colors.blue,
                text: Text(
                  "Submit",
                  style: MintY.heading3White,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
