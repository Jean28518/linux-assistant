import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// As default text "Loading..." will be taken.
class LoadingIndicator extends StatelessWidget {
  final String text;
  const LoadingIndicator({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              text == "" ? AppLocalizations.of(context)!.loading : text,
              style: MintY.heading2,
            )
          ],
        ),
      ),
    );
  }
}
