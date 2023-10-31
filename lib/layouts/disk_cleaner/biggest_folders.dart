import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/widgets/system_icon.dart';

class BiggestFoldersWidget extends StatelessWidget {
  final String path;
  const BiggestFoldersWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    Future<List<List<String>>> biggestFolders =
        Linux.getBiggestFoldersOfPath(path);
    return FutureBuilder(
      future: biggestFolders,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<List<String>> fiveBiggestFolders =
              snapshot.data! as List<List<String>>;
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var folder in fiveBiggestFolders)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () =>
                            Linux.runCommand("xdg-open $path/${folder[1]}"),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                folder[1],
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                folder[0],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MintYButton(
                    onPressed: () => Linux.openDiskSpaceAnalyzer(context, path),
                    text: Text("Speicherplatz genau analysieren",
                        style: MintY.heading4White),
                    color: MintY.currentColor,
                  )
                ],
              ),
            ],
          );
        }

        return const MintYProgressIndicatorCircle();
      },
    );
  }
}
