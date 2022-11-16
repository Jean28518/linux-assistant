import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/mintY.dart';

class FeedbackSent extends StatelessWidget {
  Future<bool> success;

  FeedbackSent({super.key, required this.success});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(64),
        child: FutureBuilder<bool>(
          future: success,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.feedback,
                    size: 128,
                    color: MintY.currentColor,
                  ),
                  const Text(
                    "Thank you very much for your feedback!",
                    style: MintY.heading2,
                  ),
                  const Text(
                    "Your feedback was sent to the developers successfully.",
                    style: MintY.heading3,
                  ),
                  const SizedBox(height: 32),
                  MintYButton(
                    text: const Text(
                      "Close",
                      style: MintY.heading3White,
                    ),
                    color: MintY.currentColor,
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error,
                    size: 128,
                    color: MintY.currentColor,
                  ),
                  const Text(
                    "Sending feedback failed.",
                    style: MintY.heading2,
                  ),
                  const SizedBox(height: 32),
                  MintYButton(
                    text: const Text(
                      "Close",
                      style: MintY.heading3White,
                    ),
                    color: MintY.currentColor,
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  MintYProgressIndicatorCircle(),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Sending feedback...",
                    style: MintY.heading2,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
