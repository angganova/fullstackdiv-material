import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fullstackdiv_material/data/model/app/app_launch_data.dart';
import 'package:fullstackdiv_material/data/model/notification/push_notification_model.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_variables.dart';
import 'package:fullstackdiv_material/system/notification/local_notification_show.dart';
import 'package:fullstackdiv_material/system/notification/notification_handler.dart';

Future<dynamic> _defaultOnBackground(Map<String, dynamic> message) async {
  final FCMNotificationSetting fcmSetting = getIt<FCMNotificationSetting>();
  fcmSetting._defaultNotificationHandler(message, 'onBackground');
}

class FCMNotificationSetting {
  FCMNotificationSetting._();

  static FCMNotificationSetting instance = FCMNotificationSetting._();

  final NotificationHandler _notificationHandler = NotificationHandler.instance;
  final LocalNotificationShow _localNotificationShow =
      LocalNotificationShow.instance;
  final LoggerBuilder _loggerBuilder = LoggerBuilder('FCMNotificationSetting');

  FirebaseMessaging _fireBaseMessaging;

  bool _isFcmEnabled = false;
  bool _isIosPermissionRequested = false;
  bool _isTokenRegistered = false;
  String fbToken;

  /// Disable / Enable PN
  void enableFCMNotification(bool enable,
      {String topic,
      MessageHandler onMessage,
      MessageHandler onBackgroundMessage,
      MessageHandler onResume,
      MessageHandler onLaunch,
      bool autoRegisterToken = true,
      bool autoRequestPermissionIos = true}) {
    if (enable) {
      _enableFCM(
          topic: topic,
          onMessage: onMessage,
          onBackgroundMessage: onBackgroundMessage,
          onResume: onResume,
          onLaunch: onLaunch,
          autoRegisterToken: autoRegisterToken,
          autoRequestPermissionIos: autoRequestPermissionIos);
    } else {
      _disableFCM();
    }
  }

  void _enableFCM(
      {String topic,
      MessageHandler onMessage,
      MessageHandler onBackgroundMessage,
      MessageHandler onResume,
      MessageHandler onLaunch,
      bool autoRegisterToken = true,
      bool autoRequestPermissionIos = true}) {
    /// Enable FCM and service
    ///

    if (_isFcmEnabled) {
      /// FCM already enable, check whether ios permission is requested
      _fcmPermissionIOS();

      /// FCM already enable, check whether token already registered
      registerTokenToServer();

      _printDebug('enabled, FCM services registered');
    } else {
      /// Enable FCM
      _setFcmListener(
          onMessage: onMessage,
          onBackgroundMessage: onBackgroundMessage,
          onResume: onResume,
          onLaunch: onLaunch);

      if (autoRequestPermissionIos) {
        _fcmPermissionIOS();
      }

      if (autoRegisterToken) {
        registerTokenToServer();
      }

      _isFcmEnabled = true;
      _printDebug('enabled');
    }
  }

  void _disableFCM() {
    /// Disable FCM and unregister fb token to server
    ///

    _fireBaseMessaging?.deleteInstanceID();
    _fireBaseMessaging = null;
    _isFcmEnabled = false;
    _isIosPermissionRequested = false;

    _unregisterTokenToServer();
    _printDebug('disabled');
  }

  /// FireBase Cloud Messaging Setting
  Future<void> _setFcmListener(
      {MessageHandler onMessage,
      MessageHandler onBackgroundMessage,
      MessageHandler onResume,
      MessageHandler onLaunch}) async {
    _fireBaseMessaging ??= FirebaseMessaging();
    _fireBaseMessaging.configure(
      onMessage: onMessage ?? _defaultOnMessage,
      onBackgroundMessage:
          Platform.isIOS ? null : onBackgroundMessage ?? _defaultOnBackground,
      onResume: onResume ?? _defaultOnResume,
      onLaunch: onLaunch ?? _defaultOnLaunch,
    );
  }

  /// IOS Specific Permission to display Notification
  void _fcmPermissionIOS() {
    if (_isIosPermissionRequested) {
      return;
    } else if (Platform.isIOS) {
      _fireBaseMessaging ??= FirebaseMessaging();
      _fireBaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
      _fireBaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        _printDebug('iOS setting registered: $settings');
        _isIosPermissionRequested = true;
      });
    } else {
      _isIosPermissionRequested = true;
    }
  }

  Future<void> registerTokenToServer() async {
    if (_isTokenRegistered) {
      /// Token already registered, do nothing
      return;
    } else {
      /// Token is not registered, register token to server
      _fireBaseMessaging ??= FirebaseMessaging();

      fbToken = await _fireBaseMessaging.getToken();
      _printDebug('FCM FB Token = $fbToken');

      _restRegisterToken(fbToken);
    }
  }

  void _unregisterTokenToServer() {
    /// This needed to clear user token in the server so user will not
    /// send any push notification again
    _restRegisterToken('lOdplaAHsAnP');
    _isTokenRegistered = false;
  }

  /// Rest call
  void _restRegisterToken(String token) {}

  Future<dynamic> _defaultOnMessage(Map<String, dynamic> message) async {
    /// Called when push notification received when app is on foreground
    try {
      _printDebug('Foreground push notification received : $message');

      PushNotificationData notificationData;
      try {
        if (message.containsKey('data')) {
          notificationData = PushNotificationData.fromMap(
              message['data'] as Map<dynamic, dynamic>);
        } else {
          notificationData ??= PushNotificationData.fromMap(message);
        }
      } on Object catch (_) {
        notificationData = PushNotificationData.fromMap(message);
      }

      if (notificationData != null) {
        _localNotificationShow.showSimpleNotification(
            title: notificationData.title, body: notificationData.body);
        _notificationHandler.handleOnMessageTrigger(notificationData);
      }
    } catch (e) {
      _printDebug('_defaultOnMessage error $e');
    }
  }

  Future<dynamic> _defaultOnResume(Map<String, dynamic> message) async {
    /// Called when push notification received when app is on background
    /// and notification clicked while app is still on background
    /// to push app to foreground with notification
    _defaultNotificationHandler(message, 'onResume');
  }

  Future<dynamic> _defaultOnLaunch(Map<String, dynamic> message) async {
    /// Called when push notification received when app is dead
    /// and notification clicked to launch the app
    _printDebug('OnLaunch push notification received : $message');

    try {
      final PushNotificationData notificationData =
          PushNotificationData.fromMap(
              message['data'] as Map<dynamic, dynamic>);
      if (notificationData != null) {
        _notificationHandler.handleNotificationLaunch(InitialBuildData(
            launchSource: GlobalString.appLaunchNotificationSourceID,
            launchPayload: notificationData.notificationDataJson));
      }
    } catch (e) {
      _printDebug('_defaultOnLaunch error $e');
    }
  }

  void _defaultNotificationHandler(
      Map<dynamic, dynamic> message, String fromState) {
    _printDebug('$fromState Push Notification received : $message');
    try {
      final PushNotificationData notificationData =
          PushNotificationData.fromMap(
              message['data'] as Map<dynamic, dynamic>);
      if (notificationData != null) {
        _notificationHandler
            .handleNotificationDirection(notificationData.toJson());
      }
    } catch (e) {
      _printDebug('error $e');
    }
  }

  Future<String> get getFCMToken async {
    if (fbToken != null) {
      return fbToken;
    } else {
      fbToken = await _fireBaseMessaging.getToken();
      return fbToken;
    }
  }

  void _printDebug(String print) => _loggerBuilder.printDebug(print);
}
