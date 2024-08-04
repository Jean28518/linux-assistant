import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/models/linux_command.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RunCommandQueue extends StatelessWidget {
  final String title;
  final String message;
  final Widget route;
  final bool offerShutdownAfterwards;
  static bool shutdownAfterwards = false;
  bool commandQueueCompleted = false;

  RunCommandQueue({
    super.key,
    this.message = "",
    required this.title,
    required this.route,
    this.offerShutdownAfterwards = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Linux.commandQueue.isEmpty) {
      return route;
    }

    initHotkeysForKeyboardUse(context);

    // Build data for table
    List<LinuxCommand> commands = Linux.commandQueue;
    List<List<String>> tableData = [
      [
        AppLocalizations.of(context)!.command,
        // AppLocalizations.of(context)!.description,
        AppLocalizations.of(context)!.root
      ]
    ];
    for (LinuxCommand command in commands) {
      tableData.add([
        command.command,
        // command.description,
        command.userId == 0
            ? AppLocalizations.of(context)!.yes
            : AppLocalizations.of(context)!.no
      ]);
    }

    Future<String> output = Linux.executeCommandQueue();
    return FutureBuilder<String>(
      future: output,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (offerShutdownAfterwards && shutdownAfterwards) {
            Linux.shutdown();
          }
          commandQueueCompleted = true;
          return MintYPage(
            title: title,
            contentElements: [
              Text(
                message,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Complete.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            bottom: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButton(
                  text: const Text(
                    "Log",
                    style: MintY.heading4,
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
                const SizedBox(
                  width: 10,
                ),
                MintYButtonNext(
                  route: route,
                ),
              ],
            ),
          );
        } else {
          // Loading Screen
          return MintYPage(
            title: title,
            contentElements: [
              Column(
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const MintYProgressIndicatorCircle(),
                  const SizedBox(
                    height: 64,
                  ),
                  CommandTable(
                    tableData: tableData,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  offerShutdownAfterwards
                      ? const ShutdownCheckbox()
                      : Container(),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  void initHotkeysForKeyboardUse(BuildContext context) {
    HotKey enter = HotKey(
      KeyCode.enter,
      scope: HotKeyScope.inapp,
    );
    hotKeyManager.register(enter, keyDownHandler: (hotKey) {
      if (commandQueueCompleted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      }
    });
  }
}

class ShutdownCheckbox extends StatefulWidget {
  const ShutdownCheckbox({super.key});

  @override
  State<ShutdownCheckbox> createState() => _ShutdownCheckboxState();
}

class _ShutdownCheckboxState extends State<ShutdownCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          fillColor:
              MaterialStateColor.resolveWith((states) => MintY.currentColor),
          value: RunCommandQueue.shutdownAfterwards,
          onChanged: (value) {
            RunCommandQueue.shutdownAfterwards = value!;
            setState(() {});
          },
        ),
        Text(
          AppLocalizations.of(context)!.shutdownAfterwards,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class CommandTable extends StatefulWidget {
  final List<List<String>> tableData;
  const CommandTable({super.key, required this.tableData});

  @override
  State<CommandTable> createState() => _CommandTableState();
}

class _CommandTableState extends State<CommandTable> {
  @override
  Widget build(BuildContext context) {
    bool showTable = ConfigHandler()
        .getValueUnsafe("show_commands_in_command_overview", false);
    return Column(
      children: [
        MintYButton(
          color: MintY.currentColor,
          text: Text(
              showTable
                  ? AppLocalizations.of(context)!.hideCommands
                  : AppLocalizations.of(context)!.showCommands,
              style: MintY.heading4White),
          onPressed: () {
            ConfigHandler()
                .setValue("show_commands_in_command_overview", !showTable);
            setState(() {});
          },
        ),
        showTable
            ? const SizedBox(
                height: 16,
              )
            : Container(),
        showTable
            ? Text(
                AppLocalizations.of(context)!
                    .theFollowingCommandsWillBeExecuted,
                style: Theme.of(context).textTheme.headlineSmall)
            : Container(),
        showTable
            ? const SizedBox(
                height: 16,
              )
            : Container(),
        showTable
            ? SizedBox(
                width: min(MediaQuery.of(context).size.width - 50, 800),
                child: MintYTable(data: widget.tableData),
              )
            : Container(),
        showTable
            ? MintYButton(
                text: Text(AppLocalizations.of(context)!.copyCommands,
                    style: MintY.heading4),
                onPressed: () {
                  // Get all commands as a string
                  String commands = "";
                  // Skip first row
                  for (int i = 1; i < widget.tableData.length; i++) {
                    commands += "${widget.tableData[i][0]}\n";
                  }
                  Linux.copyToClipboard(commands);
                },
              )
            : Container(),
      ],
    );
  }
}
