import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';

class GlobalInternetUtils {
  GlobalInternetUtils._();
  final LoggerBuilder _loggerBuilder = LoggerBuilder('InternetUtils');

  static final GlobalInternetUtils instance = GlobalInternetUtils._();

  /// Check all internet if connected and working
  Future<bool> get isInternetAvailable async =>
      await checkDeviceInternet && await checkInternetToGoogle;

  /// Check if internet is connected to mobile network or wifi network
  Future<bool> get checkDeviceInternet async {
    try {
      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile) {
        printDebug('Internet connected from mobile network');
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        printDebug('Internet connected from wifi network');
        return true;
      } else {
        printDebug('No Internet connected from wifi network or mobile network');
        return false;
      }
    } catch (e) {
      printDebug('checkDeviceInternet error occur $e');
      return true;
    }
  }

  /// Check if internet is working by reaching google
  Future<bool> get checkInternetToGoogle async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        printDebug('Google reachable, internet connected');
        return true;
      } else {
        printDebug('Google unreachable, internet not connected');
        return false;
      }
    } on SocketException catch (e) {
      debugPrint('Check internet to google error occur $e');
      return false;
    }
  }

  void printDebug(String print) => _loggerBuilder.printDebug(print);
}
