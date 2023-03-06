import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  Text(
                    AppLocalizations.of(context)!.thankYouForTheFeedback,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.feedbackSentSuccessfully,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  MintYButton(
                    text: Text(
                      AppLocalizations.of(context)!.close,
                      style: MintY.heading4White,
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
                  Text(
                    AppLocalizations.of(context)!.sendingFeedbackFailed,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 32),
                  MintYButton(
                    text: Text(
                      AppLocalizations.of(context)!.close,
                      style: MintY.heading4White,
                    ),
                    color: MintY.currentColor,
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MintYProgressIndicatorCircle(),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    AppLocalizations.of(context)!.sendingFeedback,
                    style: Theme.of(context).textTheme.headlineLarge,
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
