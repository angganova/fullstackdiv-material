// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:injectable/injectable.dart';
// import 'package:zest/config/environments.dart';
// import 'package:zest/data/domain/taxi/booking_status_message.dart';
// import 'package:zest/data/model/notification/push_notification_model.dart';
// import 'package:zest/system/utils/debugger/logger_builder.dart';
// import 'package:zest/system/utils/extensions/extensions.dart';
// import 'package:zest/system/utils/global_styles.dart';
// import 'package:zest/system/utils/notification/local_notification_setting.dart';
// import 'package:zest/system/utils/notification/notification_constant.dart';
//
// @lazySingleton
// class LocalNotificationShow {
//   LocalNotificationShow(this.localNotificationSetting, this.env) {
//     init();
//   }
//
//   final LocalNotificationSetting localNotificationSetting;
//   final Environments env;
//   final LoggerBuilder _loggerBuilder = LoggerBuilder('LocalNotificationShow');
//
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   bool isEnabled = false;
//   int simpleNotificationIDIncrement = 0;
//   int simpleWithPayloadNotificationIDIncrement = 0;
//
//   void init() {
//     if (!isEnabled) {
//       flutterLocalNotificationsPlugin =
//           localNotificationSetting.flutterLocalNotificationsPlugin;
//       isEnabled = true;
//     }
//   }
//
//   /// Cancel notification
//   Future<void> cancelNotification(
//           {int notificationID =
//               NotificationConstant.defaultNotificationID}) async =>
//       await flutterLocalNotificationsPlugin.cancel(notificationID);
//
//   /// Show notification start
//   Future<void> showSimpleNotification(
//       {@required String title,
//       String body,
//       int notificationID = NotificationConstant.defaultNotificationID,
//       bool cancelSameNotification = false}) async {
//     if (cancelSameNotification) {
//       await cancelNotification(
//           notificationID: notificationID + simpleNotificationIDIncrement);
//     }
//     await flutterLocalNotificationsPlugin.show(
//         notificationID + simpleNotificationIDIncrement,
//         title,
//         body,
//         platformNotificationDetails());
//     simpleNotificationIDIncrement++;
//   }
//
//   /// Show notification start
//   Future<void> showSimpleNotificationWithPayload(
//       {@required String title,
//       String body,
//       String payload,
//       int notificationID = NotificationConstant.defaultNotificationID,
//       bool cancelSameNotification = false}) async {
//     if (cancelSameNotification) {
//       await cancelNotification(
//           notificationID:
//               notificationID + simpleWithPayloadNotificationIDIncrement);
//     }
//     await flutterLocalNotificationsPlugin.show(
//         notificationID + simpleWithPayloadNotificationIDIncrement,
//         title,
//         body,
//         platformNotificationDetails(),
//         payload: payload);
//     simpleWithPayloadNotificationIDIncrement++;
//   }
//
//   Future<void> showNotificationTaxiBookingUpdate(
//       {String title,
//       String body,
//       String payload,
//       bool cancelSameNotification = true}) async {
//     try {
//       final PushNotificationData notificationData =
//           PushNotificationData.fromJson(
//               json.decode(payload) as Map<String, dynamic>);
//       final SocketBookingStatusMessage socketBookingStatusMessage =
//           SocketBookingStatusMessage.fromJson(
//               jsonDecode(notificationData.actionParameter)
//                   as Map<String, dynamic>);
//
//       final int _notificationID =
//           NotificationConstant.defaultTaxiBookingUpdateNotificationID +
//               socketBookingStatusMessage.type;
//
//       if (cancelSameNotification) {
//         await cancelNotification(notificationID: _notificationID);
//       }
//
//       await flutterLocalNotificationsPlugin.show(
//           _notificationID,
//           title,
//           body ?? socketBookingStatusMessage.alert,
//           platformNotificationDetails(
//               channelID: NotificationConstant.taxiChannelID),
//           payload: payload);
//     } catch (e) {
//       printDebug('showNotificationTaxiBookingUpdate payload error $e');
//     }
//   }
//
//   NotificationDetails platformNotificationDetails(
//       {String channelID,
//       bool useAndroidSound = true,
//       bool useBigIcon = false,
//       bool useBigText = true}) {
//     final AndroidNotificationDetails androidDetail =
//         aosNotificationDetails(channelID: channelID, useBigIcon: useBigIcon);
//     final IOSNotificationDetails iOSDetail = iosNotificationDetails();
//     return NotificationDetails(android: androidDetail, iOS: iOSDetail);
//   }
//
//   AndroidNotificationDetails aosNotificationDetails(
//       {String channelID,
//       bool useAndroidSound = true,
//       bool useBigIcon = false,
//       bool useBigText = true}) {
//     AndroidNotificationChannel androidNotificationChannel =
//         NotificationConstant.defaultNotificationChannel;
//
//     if (channelID != null) {
//       try {
//         androidNotificationChannel = NotificationConstant
//             .notificationChannelList
//             .firstWhere((AndroidNotificationChannel element) =>
//                 element.id.ignoreCase(channelID));
//       } catch (e) {
//         printDebug('AndroidNotificationDetails not found $e');
//       }
//     }
//
//     return AndroidNotificationDetails(
//       androidNotificationChannel.id,
//       androidNotificationChannel.name,
//       androidNotificationChannel.description,
//       icon: NotificationConstant.notificationSmallIcon,
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       onlyAlertOnce: true,
//       largeIcon: useBigIcon
//           ? const DrawableResourceAndroidBitmap(
//               NotificationConstant.notificationBigIcon)
//           : null,
//       sound: useAndroidSound
//           ? const RawResourceAndroidNotificationSound(
//               NotificationConstant.androidDefaultNotificationSound)
//           : null,
//       styleInformation: useBigText ? const BigTextStyleInformation('') : null,
//       color: kZigPrimaryElectricBlue,
//     );
//   }
//
//   IOSNotificationDetails iosNotificationDetails({bool useIOSSound = true}) {
//     return IOSNotificationDetails(
//         sound: useIOSSound
//             ? NotificationConstant.iosDefaultNotificationSound
//             : null,
//         presentSound: true);
//   }
//
//   void printDebug(String print) => _loggerBuilder.printDebug(print);
// }
