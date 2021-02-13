import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigService {
  ConfigService._() {
    _init();
  }

  static ConfigService instance = ConfigService._();

  RemoteConfig _remoteConfig;

  Future<void> _init() async {
    _loadEnv();
    _remoteConfig = await _loadFirebaseConfig();
  }

  static Future<void> _loadEnv() async {
    try {
      await DotEnv().load();
    } catch (_) {
      // No env files on app, so no need to do anything
    }
  }

  static Future<RemoteConfig> _loadFirebaseConfig() async {
    try {
      final RemoteConfig config = await RemoteConfig.instance;
      await config.fetch();
      await config.activateFetched();
      return config;
    } catch (_) {
      return null;
    }
  }

  String getValue(String key) {
    if (DotEnv().env.containsKey(key)) {
      return DotEnv().env[key];
    } else if (_remoteConfig != null) {
      return _remoteConfig.getString(key);
    } else {
      return null;
    }
  }
}
