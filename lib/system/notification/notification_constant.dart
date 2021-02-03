// import 'dart:typed_data';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationConstant {
//   static const String fcmDefaultTopic = 'all_topic';
//   static const String notificationActionTypeTaxiBookingUpdate =
//       'taxi_booking_update';
//   static const String notificationActionTypeMarketplace = 'marketplace';
//
//   static const String notificationSmallIcon = 'notification_small_icon';
//   static const String notificationBigIcon = 'notification_big_icon';
//
//   static const String androidDefaultNotificationSound =
//       'default_notification_sound';
//   static const String iosDefaultNotificationSound =
//       'default_notification_sound.aiff';
//
//   /// Notification Id
//   static const int defaultNotificationID = 100;
//   static const int defaultTaxiBookingUpdateNotificationID = 2000;
//
//   /// Android notification channel start
//   static const String defaultChannelID = 'zig_default_notification';
//   static const String taxiChannelID = 'zig_taxi_notification';
//   static const String marketplaceChannelID = 'zig_marketplace_notification';
//   static const AndroidNotificationChannel defaultNotificationChannel =
//       AndroidNotificationChannel(
//     defaultChannelID,
//     'Zig Notification',
//     'Zig default notification channel',
//     importance: Importance.high,
//     sound: RawResourceAndroidNotificationSound(androidDefaultNotificationSound),
//   );
//
//   static const AndroidNotificationChannel taxiNotificationChannel =
//       AndroidNotificationChannel(
//     taxiChannelID,
//     'Zig Taxi Notification',
//     'Zig taxi notification channel',
//     importance: Importance.high,
//     sound: RawResourceAndroidNotificationSound(androidDefaultNotificationSound),
//   );
//
//   static const AndroidNotificationChannel marketplaceNotificationChannel =
//       AndroidNotificationChannel(
//     taxiChannelID,
//     'Zig Marketplace Notification',
//     'Zig marketplace notification channel',
//     importance: Importance.high,
//     sound: RawResourceAndroidNotificationSound(androidDefaultNotificationSound),
//   );
//
//   static const List<AndroidNotificationChannel> notificationChannelList =
//       <AndroidNotificationChannel>[
//     defaultNotificationChannel,
//     taxiNotificationChannel,
//     marketplaceNotificationChannel
//   ];
//
//   /// Android notification channel end
//
//   Int64List get getVibrationPattern {
//     final Int64List _vibrationPattern = Int64List(4);
//     _vibrationPattern[0] = 0;
//     _vibrationPattern[1] = 1000;
//     _vibrationPattern[2] = 5000;
//     _vibrationPattern[3] = 2000;
//
//     return _vibrationPattern;
//   }
// }
