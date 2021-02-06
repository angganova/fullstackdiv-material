import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin ConfigService {
  String getValue(String key);
}

class ConfigServiceImpl implements ConfigService {
  ConfigServiceImpl._(this._remoteConfig);

  final RemoteConfig _remoteConfig;

  static Completer<ConfigService> _completer;

  static Future<ConfigService> getInstance() async {
    if (_completer == null) {
      _completer = Completer<ConfigService>();

      // TODO(Andre): Setup firebase notification
      // Firebase.initializeApp();

      // Load both config and env at the same time
      final List<dynamic> futures = await Future.wait<dynamic>(
          <Future<dynamic>>[_loadFirebaseConfig(), _loadEnv()]);
      final RemoteConfig config = futures[0] as RemoteConfig;
      _completer.complete(ConfigServiceImpl._(config));
    }

    return _completer.future;
  }

  static Future<void> _loadEnv() async {
    try {
      await DotEnv().load();
    } on FlutterError catch (_) {} finally {
      // No env files on app, so no need to do anything
    }
  }

  static Future<RemoteConfig> _loadFirebaseConfig() async {
    final RemoteConfig config = await RemoteConfig.instance;
    await config.fetch();
    await config.activateFetched();
    return config;
  }

  @override
  String getValue(String key) {
    if (DotEnv().env.containsKey(key)) {
      return DotEnv().env[key];
    }

    return _remoteConfig.getString(key);
  }
}
