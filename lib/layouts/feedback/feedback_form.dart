import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/feedback/feedback_send.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/models/action_entry.dart';
import 'package:linux_assistant/models/environment.dart';
import 'package:linux_assistant/services/feedback_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              children: [
                Text(
                  AppLocalizations.of(context)!.sendFeedback,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 10,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.feedbackPlaceholder),
              style: Theme.of(context).textTheme.bodyText1,
              controller: messageController,
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: MintY.currentColor,
                    value: widget.includeSearchTermAndResults,
                    onChanged: ((value) => setState(() {
                          widget.includeSearchTermAndResults = value!;
                        }))),
                Text(
                  AppLocalizations.of(context)!.includeSearchTermAndResults,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: MintY.currentColor,
                    value: widget.includeBasicSystemInformation,
                    onChanged: ((value) => setState(() {
                          widget.includeBasicSystemInformation = value!;
                        }))),
                Text(
                  AppLocalizations.of(context)!.includeBasicSystemInformation,
                  style: Theme.of(context).textTheme.bodyText1,
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
                  text: Text(
                    AppLocalizations.of(context)!.cancel,
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
                  color: MintY.currentColor,
                  text: Text(
                    AppLocalizations.of(context)!.submit,
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
