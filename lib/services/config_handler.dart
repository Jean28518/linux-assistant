import 'dart:convert';
import 'dart:io';

import 'package:linux_assistant/services/linux.dart';

class ConfigHandler {
  /// handle IconLoader as a singleton
  static final ConfigHandler _instance = ConfigHandler._privateConstructor();
  factory ConfigHandler() {
    return _instance;
  }
  ConfigHandler._privateConstructor();

  Map<String, dynamic> configMap = {
    "config_initialized": false,
  };

  Future<dynamic> getValue(key, defaultValue) async {
    await ensureConfigIsLoaded();
    return getValueUnsafe(key, defaultValue);
  }

  /// ensure that the config is loaded into memory before!! (call ensureConfigIsLoaded() before)
  /// that has only to be done once per programm start
  dynamic getValueUnsafe(key, defaultValue) {
    if (configMap.containsKey(key)) {
      return configMap[key];
    } else {
      return defaultValue;
    }
  }

  Future<void> setValue(key, value) async {
    await ensureConfigIsLoaded();
    setValueUnsafe(key, value);
    await saveConfigToFile();
  }

  /// ensure that the config is loaded into memory before!! (call ensureConfigIsLoaded() before)
  /// that has only to be done once per programm start
  /// also ensure that saveConfigToFile() is called once before programm exit
  void setValueUnsafe(key, value) {
    configMap[key] = value;
  }

  Future<void> ensureConfigIsLoaded() async {
    if (!configMap["config_initialized"]) {
      await loadConfigFromFile();
    }
  }

  Future<void> loadConfigFromFile() async {
    String homeDir = Linux.getHomeDirectory();

    File configFile = File(homeDir + ".config/linux-assistant/config.json");
    if (!await configFile.exists()) {
      await Linux.runCommandAndGetStdout(
          "mkdir " + homeDir + ".config/linux-assistant/");
      configMap["config_initialized"] = true;
    } else {
      String configString = await configFile.readAsString();
      configMap = jsonDecode(configString);
      configMap["config_initialized"] = true;
    }
  }

  Future<void> saveConfigToFile() async {
    await ensureConfigIsLoaded();
    String configString = jsonEncode(configMap);
    String homeDir = Linux.getHomeDirectory();
    File configFile = File(homeDir + ".config/linux-assistant/config.json");
    await configFile.writeAsString(configString);
  }

  /// removes dates of open times, which are older than 28 days.
  Future<void> clearOldDatesOfOpenendEntries() async {
    DateTime oldestDate = DateTime.now().subtract(const Duration(days: 28));
    await ensureConfigIsLoaded();
    for (String key in configMap.keys) {
      if (key.startsWith("opened.")) {
        String newDateString = "";

        if (getValueUnsafe("self_learning_search", true)) {
          List<String> dateStrings = configMap[key].split(";");
          for (String dateString in dateStrings) {
            if (dateString.trim() == "") {
              continue;
            }
            DateTime date = DateTime.parse(dateString);

            /// oldestDate is after date:
            if (oldestDate.compareTo(date) > 0) {
              /// do nothing, don't add it again.
            } else {
              newDateString = "$newDateString$dateString;";
            }
          }
        }

        configMap[key] = newDateString;
      }
    }
    configMap.removeWhere((key, value) => value == "");
    await saveConfigToFile();
  }
}
