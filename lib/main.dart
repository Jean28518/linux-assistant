import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:linux_assistant/enums/distros.dart';
import 'package:linux_assistant/layouts/greeter/start_screen.dart';
import 'package:linux_assistant/layouts/mintY.dart';
import 'package:linux_assistant/services/config_handler.dart';
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
  await Linux.loadCurrentEnvironment();
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
    setMainColor();
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

  static void initHotkeyToShowUp() {
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

  static void setMainColor() {
    switch (Linux.currentenvironment.distribution) {
      case DISTROS.DEBIAN:
        MintY.currentColor = const Color.fromARGB(255, 208, 7, 78);
        break;
      case DISTROS.LINUX_MINT:
        MintY.currentColor = const Color.fromARGB(255, 139, 177, 88);
        break;
      case DISTROS.MXLINUX:
        MintY.currentColor = const Color.fromARGB(255, 34, 34, 34);
        break;
      case DISTROS.POPOS:
        MintY.currentColor = const Color.fromARGB(255, 72, 185, 199);
        break;
      case DISTROS.UBUNTU:
        MintY.currentColor = const Color.fromARGB(255, 233, 84, 32);
        break;
      default:
        MintY.currentColor = Colors.blue;
    }
    ConfigHandler configHandler = ConfigHandler();
    String colorString = configHandler.getValueUnsafe("color", "");
    if (colorString.isNotEmpty) {
      MintY.currentColor = HexColor(colorString);
    }
  }
}
