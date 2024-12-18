import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:linux_assistant/services/config_handler.dart';
import 'package:linux_assistant/services/updater.dart';
import 'package:http/http.dart' as http;

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
    await newestVersionRunner;

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
}
