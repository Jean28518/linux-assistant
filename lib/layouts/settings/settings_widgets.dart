import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef StringParseFunction = String Function(String);

class SettingWidgetOnOff extends StatefulWidget {
  /// Settings-Key
  late String settingKey;

  late String text;
  late bool defaultValue;
  late VoidCallback? onPressed;
  SettingWidgetOnOff(
      {super.key,
      required this.settingKey,
      required this.text,
      this.defaultValue = true,
      this.onPressed});

  @override
  State<SettingWidgetOnOff> createState() => SettingWidgetOnOffState();
}

class SettingWidgetOnOffState extends State<SettingWidgetOnOff> {
  late bool value;

  @override
  void initState() {
    value =
        ConfigHandler().getValueUnsafe(widget.settingKey, widget.defaultValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Description
          Column(
            children: [
              Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),

          /// Setting
          Column(
            children: [
              MintYButton(
                color: MintY.currentColor,
                text: value
                    ? Text(
                        AppLocalizations.of(context)!.on,
                        style: MintY.heading4White,
                      )
                    : Text(
                        AppLocalizations.of(context)!.off,
                        style: MintY.heading4White,
                      ),
                onPressed: () {
                  ConfigHandler().setValue(widget.settingKey, !value);
                  widget.onPressed?.call();
                  setState(() {
                    value = !value;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SettingWidgetText extends StatefulWidget {
  /// Settings-Key
  late String settingKey;

  late String text;
  late String defaultValue;
  late StringParseFunction? parseFunction;
  late final String hintText;
  late double textFieldWidth;
  SettingWidgetText(
      {super.key,
      required this.settingKey,
      required this.text,
      this.defaultValue = "",
      this.hintText = "",
      this.textFieldWidth = 100,
      this.parseFunction});

  @override
  State<SettingWidgetText> createState() => _SettingWidgetTextState();
}

class _SettingWidgetTextState extends State<SettingWidgetText> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text =
        ConfigHandler().getValueUnsafe(widget.settingKey, widget.defaultValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Description
          Column(
            children: [
              Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),

          /// Setting
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: widget.textFieldWidth,
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: widget.hintText,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge,
                      controller: textEditingController,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  MintYButton(
                    color: MintY.currentColor,
                    width: 30,
                    text: const Icon(
                      Icons.save,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      String parsedText = textEditingController.text;
                      if (widget.parseFunction != null) {
                        parsedText = widget.parseFunction!(parsedText);
                      }
                      ConfigHandler().setValue(widget.settingKey, parsedText);
                      textEditingController.text = parsedText;
                    },
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
