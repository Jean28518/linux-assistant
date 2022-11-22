import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:linux_assistant/layouts/greeter/start_screen.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();
  WindowManager.instance.setTitle("Linux Assistant");

  // For hot reload, `unregisterAll()` needs to be called.
  await HotKeyManager.instance.unregisterAll();

  Linux.executableFolder = Linux.getExecutableFolder();
  await Linux.updateEnvironmentAtNormalStartUp();
  bool darkTheme = await Linux.isDarkThemeEnabled();

  runApp(MyApp(
    darkTheme: darkTheme,
  ));
}

class MyApp extends StatelessWidget {
  late bool darkTheme;
  MyApp({Key? key, this.darkTheme = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MintY.currentColor = Colors.blue;

    initHotkeyToShowUp();
    return MaterialApp(
      title: 'Linux Assistant',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('de', ''),
      ],
      theme: darkTheme ? MintY.themeDark() : MintY.theme(),
      home: StartScreen(),
    );
  }

  static initHotkeyToShowUp() {
    HotKey _hotKey = HotKey(
      KeyCode.keyQ,
      modifiers: [KeyModifier.alt],
      scope: HotKeyScope.system,
    );
    hotKeyManager.register(
      _hotKey,
      keyDownHandler: (hotKey) {
        Linux.runCommandWithCustomArguments(
            "wmctrl", ["-a", "Linux Assistant"]);
      },
    );

    // Debug Call
    HotKey _hotKeyDebug = HotKey(
      KeyCode.keyD,
      modifiers: [KeyModifier.control],
      scope: HotKeyScope.inapp,
    );
    hotKeyManager.register(
      _hotKeyDebug,
      keyDownHandler: (hotKey) async {
        // insert here function calls to debug
      },
    );
  }
}
