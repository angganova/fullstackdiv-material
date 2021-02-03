import 'dart:async';
import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';

/// Use this class related to device information
/// i.e. device ID, device name, current OS, etc.
mixin PlatformInfo {
  String get deviceId;

  String get deviceName;
  String get fcmToken;
}

class PlatformInfoImpl implements PlatformInfo {
  PlatformInfoImpl._(this._deviceId, this._deviceName, this._fcmToken);

  static Completer<PlatformInfo> _completer;

  static Future<PlatformInfo> getInstance() async {
    if (_completer == null) {
      _completer = Completer<PlatformInfo>();

      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String deviceId = '';
      String deviceName = '';
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
        deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
        deviceName = iosInfo.utsname.machine;
      }

      //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
      String fcmToken = deviceId;

      try {
        fcmToken = 'test';
        print('generrating $fcmToken');
      } on Object catch (_) {
        fcmToken = deviceId;
      }

      _completer.complete(PlatformInfoImpl._(deviceId, deviceName, fcmToken));
    }

    return _completer.future;
  }

  final String _deviceId;
  final String _deviceName;
  final String _fcmToken;

  @override
  String get deviceId => _deviceId;

  @override
  String get deviceName => _deviceName;

  @override
  String get fcmToken => _fcmToken;
}
