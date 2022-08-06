import 'dart:convert';
import 'dart:io';

import 'package:linux_helper/services/linux.dart';

class ConfigHandler {
  // handle IconLoader as a singleton
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

  // ensure that the config is loaded into memory before!! (call ensureConfigIsLoaded() before)
  // that has only to be done once per programm start
  dynamic getValueUnsafe(key, defaultValue) {
    if (configMap.containsKey(key)) {
      return configMap[key];
    } else {
      return defaultValue;
    }
  }

  void setValue(key, value) async {
    await ensureConfigIsLoaded();
    setValueUnsafe(key, value);
    await saveConfigToFile();
  }

  // ensure that the config is loaded into memory before!! (call ensureConfigIsLoaded() before)
  // that has only to be done once per programm start
  // also ensure that saveConfigToFile() is called once before programm exit
  void setValueUnsafe(key, value) {
    configMap[key] = value;
  }

  dynamic ensureConfigIsLoaded() async {
    if (!configMap["config_initialized"]) {
      await loadConfigFromFile();
    }
  }

  Future<void> loadConfigFromFile() async {
    String homeDir = Linux.getHomeDirectory();

    File configFile = File(homeDir + ".config/linux-helper/config.json");
    if (!await configFile.exists()) {
      await Linux.runCommandAndGetStdout(
          "mkdir " + homeDir + ".config/linux-helper/");
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
    File configFile = File(homeDir + ".config/linux-helper/config.json");
    await configFile.writeAsString(configString);
  }
}
