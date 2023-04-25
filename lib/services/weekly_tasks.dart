import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:linux_assistant/enums/softwareManagers.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/linux.dart';
import 'package:linux_assistant/services/updater.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class WeeklyTasks {
  /// Seconds
  static const int _defaultTimeout = 5;

  static Future<void> doWeekleyTasks() async {
    DateTime.parse(
        ConfigHandler().getValueUnsafe("last-weekly-task", "1970-01-01"));
    DateTime lastSearch = DateTime.parse(
        ConfigHandler().getValueUnsafe("last-weekly-task", "1970-01-01"));
    if (DateTime.now().difference(lastSearch).inDays < 7) {
      return;
    }

    Future newestVersionRunner = _getNewestVersion();

    Future flathubIndexRunner;
    if (Linux.currentenvironment.installedSoftwareManagers
        .contains(SOFTWARE_MANAGERS.FLATPAK)) {
      flathubIndexRunner = _getFlathubIndex();
    } else {
      flathubIndexRunner = Future.delayed(const Duration(seconds: 0));
    }
    await newestVersionRunner;
    await flathubIndexRunner;

    String newDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await ConfigHandler().setValue("last-weekly-task", newDate);
  }

  static Future<void> _getNewestVersion() async {
    http.Response response = await http
        .get(Uri.parse(
            "https://api.github.com/repos/Jean28518/linux-assistant/releases/latest"))
        .timeout(const Duration(seconds: _defaultTimeout));

    Map responseMap = json.decode(response.body);
    LinuxAssistantUpdater.newestVersionInformation = responseMap;
    String newestVersion = responseMap["name"].replaceAll("v", "");
    await ConfigHandler()
        .setValue("newest-linux-assistant-version", newestVersion);
  }

  static Future<void> _getFlathubIndex() async {
    http.Response response = await http
        .get(Uri.parse("https://flathub.org/api/v1/apps"))
        .timeout(const Duration(seconds: _defaultTimeout));

    // Write flathubIndexJson into file
    String homeDir = Linux.getHomeDirectory();
    File flathubIndexFile =
        File("$homeDir.config/linux-assistant/flathub_index.json");
    await flathubIndexFile.writeAsString(response.body);
  }
}
