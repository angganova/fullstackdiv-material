import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_view/no_overscroll_list_view.dart';
import 'package:fullstackdiv_material/app/components/snackbar/basic_snack_bar.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart';

class NotificationTesterView extends StatefulWidget {
  @override
  _NotificationTesterViewState createState() => _NotificationTesterViewState();
}

class _NotificationTesterViewState extends State<NotificationTesterView> {
  final FCMNotificationSetting _fcmNotificationSetting =
      getIt<FCMNotificationSetting>();

  Dio _dio;

  bool _restSendFcmTokenRequesting = false;

  String _deviceFCMToken;
  bool _deviceFCMTokenValid = false;

  String _serverFCMToken;

  BuildContext _buildContext;
  AppQuery _appQuery;
  AppSpacer _appSpacer;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appQuery ??= AppQuery(context);
    _appSpacer ??= AppSpacer(context: context);

    return Scaffold(
      body: Builder(builder: (BuildContext _context) {
        _buildContext ??= _context;
        return NoOverScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                titleView,
                listTileView('Device FCM Token',
                    subtitle: _deviceFCMToken ?? '',
                    trailing: statusValidIcon(_deviceFCMTokenValid),
                    onTap: () =>
                        _copyToClipboard(_deviceFCMToken, 'Device FCM Token')),
                emptyView(height: _appSpacer.standard),
                buttonView('Send FCM Notification', () => sendPN()),
                emptyView(height: _appSpacer.sm),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget get titleView => BasicHeader(
        title: 'Push Notification Tester',
        onBackButtonTapped: () => Navigator.of(context).pop(),
      );

  Widget listTileView(
    String title, {
    String subtitle,
    Widget leading,
    Widget trailing,
    VoidCallback onTap,
  }) =>
      Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: onTap,
          contentPadding:
              _appSpacer.edgeInsets.symmetric(x: 'standard', y: 'sm'),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              labelView(title),
              emptyView(height: _appSpacer.xs),
              textContentView(subtitle)
            ],
          ),
          leading: leading,
          trailing: trailing,
        ),
      );

  Widget labelView(String text, {Color color = kAppBlack}) {
    if (text == null) {
      return emptyView();
    } else {
      return Text(
        text,
        style: AppTextStyle(context: _buildContext, color: color ??= kAppBlack)
            .primaryLabel1,
      );
    }
  }

  Widget textContentView(String text, {Color color = kAppBlack}) {
    if (text == null) {
      return emptyView();
    } else {
      return Text(
        text,
        style: AppTextStyle(context: _buildContext, color: color ??= kAppBlack)
            .primaryLabel6,
      );
    }
  }

  Widget statusValidIcon(bool valid) => Icon(
        valid ? Icons.check : Icons.close,
        color: valid ? Colors.green : Colors.red,
      );

  Widget emptyView({double width = 0, double height = 0}) => Container(
        width: width,
        height: height,
      );

  Widget buttonView(String title, VoidCallback onPressed,
      {WidgetTheme theme = WidgetTheme.blueWhite}) {
    if (title == null) {
      return emptyView();
    } else {
      return WideButton(
        fullWidth: true,
        title: title,
        widgetTheme: theme,
        onPressed: _restSendFcmTokenRequesting ? null : () => onPressed(),
      );
    }
  }

  Future<void> _initPlatformState() async {
    setupDio();

    _deviceFCMToken = await _fcmNotificationSetting.getFCMToken;
    _deviceFCMTokenValid =
        _deviceFCMToken != null && _deviceFCMToken.isNotEmpty;

    setState(() {});
  }

  Future<void> sendPN() async {
    setState(() => _restSendFcmTokenRequesting = true);

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
      'to': _deviceFCMToken,
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
        setState(() => _restSendFcmTokenRequesting = false);
      });
    } catch (e) {
      debugPrint('XXX $e');
      showPNSentSuccessSnackBar(false);
    }
  }

  void showPNSentSuccessSnackBar(bool success) => showBasicSnackBar(
      context: _buildContext,
      icon: success ? Icons.thumb_up : Icons.warning,
      text: success
          ? 'Push Notification Sent'
          : 'Push notification not sent, unknown error happened',
      widgetTheme: success ? WidgetTheme.yellowBlack : WidgetTheme.redWhite);

  void setupDio() {
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
  }

  void _copyToClipboard(String text, String tokenTag) {
    Clipboard.setData(ClipboardData(text: _serverFCMToken));
    showBasicSnackBar(
        context: _buildContext,
        icon: Icons.thumb_up,
        text: 'Copy $tokenTag success',
        widgetTheme: WidgetTheme.yellowBlack);
  }
}
