import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/model/app/app_launch_data.dart';
import 'package:fullstackdiv_material/system/copy/copy.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_variables.dart';
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart';
import 'package:fullstackdiv_material/system/notification/notification_handler.dart';
import 'package:fullstackdiv_material/system/observer/app_lifecycle_handler.dart';
import 'package:fullstackdiv_material/system/state/widget_state.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'home_vm.g.dart';

@lazySingleton
class HomeViewModel = _HomeViewModel with _$HomeViewModel;

abstract class _HomeViewModel with Store {
  _HomeViewModel(this.copy, this._fcmSetting);
  final Copy copy;
  final LoggerBuilder _loggerBuilder = LoggerBuilder('HomeView');
  final FCMNotificationSetting _fcmSetting;

  InitialBuildData initialBuildData;

  /// Widget variable start

  /// This navigator state will be used to navigate widget to different page
  /// from view model
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppWidgetState widgetState = AppWidgetState.stateEmpty;
  BuildContext widgetBuildContext;
  WidgetsBindingObserver widgetLifeCycleObserver;

  /// Computed data start
  @computed
  bool get widgetInitiated =>
      widgetState != AppWidgetState.stateEmpty &&
      widgetState != AppWidgetState.stateDisposed;

  void appPaused() {}

  void appResumed() {}

  void widgetInitState() {
    widgetState = AppWidgetState.stateInitiated;
    _widgetSetup();
  }

  void widgetPostFrame(BuildContext context) {
    widgetState = AppWidgetState.statePostFrame;
    widgetBuildContext = context;
    executePendingInitialAction();
  }

  void widgetDispose() {
    widgetState = AppWidgetState.stateDisposed;

    _removeLifCycleObserver();
  }

  void widgetPaused() {}

  void widgetResumed() {}

  Future<void> _widgetSetup() async {
    _initLifeCycleObserver();
    _enableFcm(enable: true);
  }

  void _initLifeCycleObserver() {
    widgetLifeCycleObserver ??= AppLifecycleHandler(
        pausedCallBack: () async => appPaused(),
        resumeCallBack: () async => appResumed());
  }

  void _removeLifCycleObserver() {
    if (widgetLifeCycleObserver != null) {
      WidgetsBinding.instance.removeObserver(widgetLifeCycleObserver);
    }
  }

  void _enableFcm({bool enable = true}) =>
      _fcmSetting.enableFCMNotification(enable);

  /// Pending initial action need to be executed when home view is
  /// shown at start, need to be executed onPostFrame()
  /// Pending action start
  void setPendingInitialAction(InitialBuildData launchData) =>
      initialBuildData = launchData;

  void deletePendingInitialAction() => initialBuildData = null;

  Future<void> executePendingInitialAction() async {
    if (initialBuildData == null) {
      return;
    } else if (initialBuildData.launchSource
        .ignoreCase(GlobalStrings.appLaunchNotificationSourceID)) {
      printDebug('executePendingInitialAction '
          '${GlobalStrings.appLaunchNotificationSourceID} '
          '$initialBuildData');

      /// Pending action from push notification
      final NotificationHandler notificationHandler =
          getIt<NotificationHandler>();
      await notificationHandler
          .handleNotificationDirection(
              jsonDecode(initialBuildData.launchPayload)
                  as Map<String, dynamic>)
          .then((_) => deletePendingInitialAction());
    }
  }

  /// Pending launch action end

  /// Direct launch any route start

  Future<void> sessionLogout() async {
    _enableFcm(enable: false);
    widgetDispose();
  }

  /// Direct launch any route end

  void printDebug(String print) => _loggerBuilder.printDebug(print);
}
