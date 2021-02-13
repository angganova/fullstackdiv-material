import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';

class PlatformInfo {
  PlatformInfo._() {
    _init();
  }

  String _deviceId;
  String _deviceName;

  static PlatformInfo instance = PlatformInfo._();

  Future<void> _init() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceId = androidInfo.androidId;
      _deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _deviceId = iosInfo.identifierForVendor;
      _deviceName = iosInfo.utsname.machine;
    }
  }

  String get deviceId => _deviceId;

  String get deviceName => _deviceName;
}
