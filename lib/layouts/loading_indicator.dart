import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mintY.dart';

class LoadingIndicator extends StatelessWidget {
  late String text;
  LoadingIndicator({Key? key, this.text = "Loading..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              child: const CircularProgressIndicator(),
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              text,
              style: MintY.heading2,
            )
          ],
        ),
      ),
    );
  }
}
