import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fullstackdiv_material/app/screens/home/home_view.dart';
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/model/app/app_launch_data.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_variables.dart';
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart';
import 'package:fullstackdiv_material/system/notification/local_notification_setting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(Andre): Test actual firebase config env variables
  await initializeInjection();

  _setupApp();
  _startApp();
}

void _setupApp() {
  /// Disable / enable fcm as soon as the app start
  /// this is to ensure that the payload will be the executed when the app is
  /// launched from fcm push notification
  _enableFcm();
}

Future<void> _enableFcm() async {
  /// Disable / enable fcm according to user session in the app
  /// ( logged in / logged off )
  final FCMNotificationSetting _fcmSetting = getIt<FCMNotificationSetting>();
  _fcmSetting.enableFCMNotification(true,
      autoRequestPermissionIos: false, autoRegisterToken: false);

  /// Check App launch detail will check whether the app is launched from other
  /// source rather than app icon click
  /// For now this will handle app launch from :
  /// 1. Local notification click - direct
  /// 2. FCM Push notification click - FCM handler
  _checkAppLaunchDetail();
}

Future<void> _checkAppLaunchDetail() async {
  /// Check if the app is launched from local notification
  final LocalNotificationSetting localNotificationSetting =
      getIt<LocalNotificationSetting>();
  final NotificationAppLaunchDetails notificationAppLaunchDetails =
      await localNotificationSetting.flutterLocalNotificationsPlugin
          .getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails.didNotificationLaunchApp &&
      notificationAppLaunchDetails.payload != null) {
    /// App launched from local notification,
    /// set home view to execute this detail later
    final HomeViewModel _vmHome = getIt<HomeViewModel>();
    _vmHome.setPendingInitialAction(InitialBuildData(
        launchSource: GlobalStrings.appLaunchNotificationSourceID,
        launchPayload: notificationAppLaunchDetails.payload));
  }
}

Future<void> _startApp() async {
  ///
  /// Add [DevicePreview] to debug responsiveness of the app
  /// in different screen sizes
  /// without open a few simulators & emulators
  /// to TURN this ON : change DEVICE_PREVIEW_ENABLED in .env file to TRUE
  /// to TURN this OFF : change DEVICE_PREVIEW_ENABLED in .env file to FALSE
  ///
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fullstackdiv Material Design',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
    );
  }
}
