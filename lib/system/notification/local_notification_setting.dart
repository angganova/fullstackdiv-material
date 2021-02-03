// import 'dart:convert';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:injectable/injectable.dart';
// import 'package:zest/config/environments.dart';
// import 'package:zest/system/utils/debugger/logger_builder.dart';
// import 'package:zest/system/utils/notification/notification_constant.dart';
// import 'package:zest/system/utils/notification/notification_handler.dart';
//
// /// Refer to
// /// https://github.com/MaikuB/flutter_local_notifications/blob/master/flutter_local_notifications/example/lib/main.dart
// @lazySingleton
// class LocalNotificationSetting {
//   LocalNotificationSetting(this.env, this.notificationHandler) {
//     initLocalNotification();
//   }
//
//   final Environments env;
//   final LoggerBuilder _loggerBuilder =
//       LoggerBuilder('LocalNotificationSetting');
//   final NotificationHandler notificationHandler;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static const List<AndroidNotificationChannel> notificationChannelList =
//       NotificationConstant.notificationChannelList;
//   static const String _androidSmallIcon =
//       NotificationConstant.notificationSmallIcon;
//
//   bool isEnabled = false;
//   bool isChannelCreated = false;
//   InitializationSettings initializationSettings;
//
//   Future<void> initLocalNotification() async {
//     if (!isEnabled) {
//       await _createNotificationChannel();
//       await _enableLocalNotification();
//     }
//   }
//
//   Future<void> _enableLocalNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(_androidSmallIcon);
//     const IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true);
//
//     initializationSettings = const InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     await flutterLocalNotificationsPlugin
//         .initialize(initializationSettings,
//             onSelectNotification: _defaultSelectNotificationCallback)
//         .then((_) => isEnabled = true);
//   }
//
//   Future<void> _createNotificationChannel() async {
//     if (isChannelCreated) {
//       return;
//     } else {
//       for (final AndroidNotificationChannel channel
//           in notificationChannelList) {
//         await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.createNotificationChannel(channel);
//         isChannelCreated = true;
//       }
//     }
//   }
//
//   Future<void> _defaultSelectNotificationCallback(String payload) async {
//     if (payload == null) {
//       return;
//     } else if (isEnabled) {
//       try {
//         notificationHandler.handleNotificationDirection(
//             jsonDecode(payload) as Map<String, dynamic>);
//       } catch (e) {
//         notificationDebugPrint('_defaultSelectNotificationCallback error $e');
//       }
//     }
//   }
//
//   void notificationDebugPrint(String print) => _loggerBuilder.printDebug(print);
// }
