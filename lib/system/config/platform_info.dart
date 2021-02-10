import 'dart:async';
import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:injectable/injectable.dart';

/// Use this class related to device information
/// i.e. device ID, device name, current OS, etc.
@singleton
class PlatformInfo {
  PlatformInfo() {
    _init();
  }

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

  String _deviceId;
  String _deviceName;

  String get deviceId => _deviceId;

  String get deviceName => _deviceName;
}
