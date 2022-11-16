import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/feedback/feedback_send.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/enviroment.dart';
import 'package:linux_assistant/services/feedback_service.dart';

class FeedbackDialog extends StatefulWidget {
  String searchText;
  List<ActionEntry> foundEntries;

  bool includeSearchTermAndResults = true;
  bool includeBasicSystemInformation = true;

  String message = "";

  FeedbackDialog(
      {super.key, this.searchText = "", this.foundEntries = const []});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final messageController = TextEditingController();

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
              children: const [
                Text(
                  "Your Feedback",
                  style: MintY.heading2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 10,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      "Are you missing a search result?\nFor what are you searching?\nDo you have suggestions for improvement?\n..."),
              style: MintY.paragraph,
              controller: messageController,
            ),
            Row(
              children: [
                Checkbox(
                    value: widget.includeSearchTermAndResults,
                    onChanged: ((value) => setState(() {
                          widget.includeSearchTermAndResults = value!;
                        }))),
                const Text(
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
                const Text(
                  "Include basic system information",
                  style: MintY.paragraph,
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButton(
                  text: const Text(
                    "Cancel",
                    style: MintY.heading3,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                MintYButton(
                  color: Colors.blue,
                  text: const Text(
                    "Submit",
                    style: MintY.heading3White,
                  ),
                  onPressed: () {
                    Future<bool> success = FeedbackService.send_feedback(
                        messageController.text,
                        widget.foundEntries,
                        widget.searchText,
                        widget.includeBasicSystemInformation,
                        widget.includeSearchTermAndResults);
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => FeedbackSent(
                        success: success,
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateMessage(message) {
    widget.message = message;
  }
}
