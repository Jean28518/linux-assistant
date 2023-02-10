import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/services/linux.dart';

class RunCommandQueue extends StatelessWidget {
  final String title;
  final String message;
  final Widget route;

  RunCommandQueue({
    super.key,
    this.message = "",
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    if (Linux.commandQueue.isEmpty) {
      return route;
    }

    Future<String> output = Linux.executeCommandQueue();
    return FutureBuilder<String>(
      future: output,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> lines = snapshot.data!.split("\n");
          return MintYPage(
            title: title,
            contentElements: [
              Text(
                message,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Complete.",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
            bottom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButton(
                  text: const Text(
                    "Log",
                    style: MintY.heading2,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.black,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 36,
                                      color: Colors.white,
                                    ),
                                    iconSize: 36,
                                  )
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SingleChildScrollView(
                                    child: SelectableText(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Courier"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                MintYButtonNext(route: route),
              ],
            ),
          );
        } else {
          // Loading Screen
          return MintYPage(
            title: title,
            contentElements: [
              Text(
                message,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              MintYProgressIndicatorCircle(),
            ],
          );
        }
      },
    );
  }
}
