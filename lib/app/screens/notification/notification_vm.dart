import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/app/components/snackbar/basic_snack_bar.dart';
import 'package:fullstackdiv_material/data/model/notification/push_notification_model.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_state.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'notification_vm.g.dart';

@lazySingleton
class NotificationVM = _NotificationVM with _$NotificationVM;

abstract class _NotificationVM with Store {
  _NotificationVM(this.fcmNotificationSetting);

  final FCMNotificationSetting fcmNotificationSetting;

  @observable
  PushNotificationData notificationData;

  @observable
  bool restSendFcmTokenRequesting = false;

  @observable
  String deviceFCMToken;
  Dio _dio;

  BuildContext widgetBuildContext;
  AppWidgetState widgetState = AppWidgetState.stateEmpty;

  Future<void> widgetInitState() async {
    widgetState = AppWidgetState.stateInitiated;
    deviceFCMToken = await fcmNotificationSetting.getFCMToken;
    _setupDio();
  }

  void widgetPostFrame(BuildContext context) {
    widgetState = AppWidgetState.statePostFrame;
    widgetBuildContext = context;
  }

  void widgetDisposed() {
    widgetState = AppWidgetState.stateDisposed;
  }

  void displayPushNotification(PushNotificationData data) =>
      notificationData = data;

  bool get isWidgetActive =>
      widgetState.index.isMoreOrEqualTo(AppWidgetState.stateInitiated.index) &&
      widgetState.index.isLessThan(AppWidgetState.stateDisposed.index);

  Future<void> sendPN() async {
    if (deviceFCMToken.isNullOrEmpty) {
      return;
    }

    restSendFcmTokenRequesting = true;

    const String _serverToken =
        'AAAAxO1ovIQ:APA91bGaqdOVWYjV7xEU8k-2X0_iUC6sXIPrHFTnbzTiiK5K85cWJiTBbCP'
        'ULYJi7ui7kUy0DoWgEkA0PtxFUNb8nDXkS7opaPYgmcd9FP5r3RvoBvY-Ld__HAx9uG3-Df'
        'H5Jc6mla1T';

    final Map<String, String> _requestHeader = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$_serverToken',
    };
    final Options opt = Options(headers: _requestHeader);

    final Map<String, dynamic> _requestBody = <String, dynamic>{
      'notification': <String, dynamic>{
        'title': 'Test push notification',
        'body': 'Push notification message sent ',
      },
      'data': <String, dynamic>{
        'title': 'Test push notification',
        'body': 'Push notification message sent ',
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'id': '1',
      },
      'priority': 'high',
      'to': deviceFCMToken,
    };

    try {
      await _dio
          .post<String>(
        'fcm/send',
        options: opt,
        data: _requestBody,
      )
          .then((Response<String> value) {
        final Map<String, dynamic> data =
            jsonDecode(value.data) as Map<String, dynamic>;
        final bool success = (data['success'] ?? 0) == 1;
        showPNSentSuccessSnackBar(success);
        restSendFcmTokenRequesting = false;
      });
    } catch (e) {
      debugPrint('XXX $e');
      showPNSentSuccessSnackBar(false);
    }
  }

  void showPNSentSuccessSnackBar(bool success) => showBasicSnackBar(
      context: widgetBuildContext,
      icon: success ? Icons.thumb_up : Icons.warning,
      text: success
          ? 'Push Notification Sent'
          : 'Push notification not sent, unknown error happened',
      widgetTheme: success ? WidgetTheme.yellowBlack : WidgetTheme.redWhite);

  void _setupDio() {
    const String fcmURL = 'https://fcm.googleapis.com/';

    final BaseOptions options = BaseOptions(
      baseUrl: fcmURL,
      followRedirects: false,
      validateStatus: (int status) => status < 500,
      contentType: 'application/json; charset=utf-8',
      connectTimeout: 15000,
      receiveTimeout: 15000,
      sendTimeout: 15000,
    );
    _dio = Dio(options);
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  void copyToClipboard(String text, String tokenTag) {
    Clipboard.setData(ClipboardData(text: text));
    showBasicSnackBar(
        context: widgetBuildContext,
        icon: Icons.thumb_up,
        text: 'Copy $tokenTag success',
        widgetTheme: WidgetTheme.yellowBlack);
  }
}
