import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationConstant {
  static const String fcmDefaultTopic = 'all_topic';
  static const String notificationSmallIcon = 'ic_notification';
  static const String notificationBigIcon = 'ic_notification_big';
  static const String androidDefaultNotificationSound =
      'default_notification_sound';
  static const String iosDefaultNotificationSound =
      'default_notification_sound.aiff';

  /// Notification Id
  static const int defaultNotificationID = 100;

  /// Android notification channel start
  static const String defaultChannelID = 'fsd_default_notification';
  static const AndroidNotificationChannel defaultNotificationChannel =
      AndroidNotificationChannel(
    defaultChannelID,
    'FSD Notification',
    'FSD default notification channel',
    importance: Importance.high,
    sound: RawResourceAndroidNotificationSound(androidDefaultNotificationSound),
  );

  static const List<AndroidNotificationChannel> notificationChannelList =
      <AndroidNotificationChannel>[
    defaultNotificationChannel,
  ];

  /// Android notification channel end

  Int64List get getVibrationPattern {
    final Int64List _vibrationPattern = Int64List(4);
    _vibrationPattern[0] = 0;
    _vibrationPattern[1] = 1000;
    _vibrationPattern[2] = 5000;
    _vibrationPattern[3] = 2000;

    return _vibrationPattern;
  }
}
