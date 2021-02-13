import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/notification/notification_constant.dart';
import 'package:fullstackdiv_material/system/notification/notification_handler.dart';

/// Refer to
/// https://github.com/MaikuB/flutter_local_notifications/blob/master/flutter_local_notifications/example/lib/main.dart
class LocalNotificationSetting {
  LocalNotificationSetting._() {
    initLocalNotification();
  }

  static LocalNotificationSetting instance = LocalNotificationSetting._();

  final Environments env = Environments.instance;
  final NotificationHandler notificationHandler = NotificationHandler.instance;

  final LoggerBuilder _loggerBuilder =
      LoggerBuilder('LocalNotificationSetting');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const List<AndroidNotificationChannel> notificationChannelList =
      NotificationConstant.notificationChannelList;
  static const String _androidSmallIcon =
      NotificationConstant.notificationSmallIcon;

  bool isEnabled = false;
  bool isChannelCreated = false;
  InitializationSettings initializationSettings;

  Future<void> initLocalNotification() async {
    if (!isEnabled) {
      await _createNotificationChannel();
      await _enableLocalNotification();
    }
  }

  Future<void> _enableLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(_androidSmallIcon);
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true);

    initializationSettings = const InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
            onSelectNotification: _defaultSelectNotificationCallback)
        .then((_) => isEnabled = true);
  }

  Future<void> _createNotificationChannel() async {
    if (isChannelCreated) {
      return;
    } else {
      for (final AndroidNotificationChannel channel
          in notificationChannelList) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        isChannelCreated = true;
      }
    }
  }

  Future<void> _defaultSelectNotificationCallback(String payload) async {
    if (payload == null) {
      return;
    } else if (isEnabled) {
      try {
        notificationHandler.handleNotificationDirection(
            jsonDecode(payload) as Map<String, dynamic>);
      } catch (e) {
        notificationDebugPrint('_defaultSelectNotificationCallback error $e');
      }
    }
  }

  void notificationDebugPrint(String print) => _loggerBuilder.printDebug(print);
}
