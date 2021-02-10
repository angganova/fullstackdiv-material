import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_view/no_overscroll_list_view.dart';
import 'package:fullstackdiv_material/app/screens/notification/notification_vm.dart';
import 'package:fullstackdiv_material/data/model/notification/push_notification_model.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationVM _viewModel = getIt<NotificationVM>();

  BuildContext _widgetBuildContext;
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
        _widgetBuildContext ??= _context;
        return SafeArea(
          child: NoOverScrollView(
            child: SingleChildScrollView(
              child: Observer(
                builder: (_) => Column(
                  children: <Widget>[
                    titleView,
                    listTileView('Device FCM Token',
                        subtitle: _viewModel.deviceFCMToken ?? '',
                        trailing: statusValidIcon(
                            _viewModel.deviceFCMToken?.isNotNullOrEmpty ??
                                false),
                        onTap: () => _viewModel.copyToClipboard(
                            _viewModel.deviceFCMToken, 'Device FCM Token')),
                    emptyView(height: _appSpacer.standard),
                    buttonView(
                        'Send FCM Notification', () => _viewModel.sendPN()),
                    emptyView(height: _appSpacer.sm),
                    _notificationView
                  ],
                ),
              ),
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
        style: AppTextStyle(
                context: _widgetBuildContext, color: color ??= kAppBlack)
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
        style: AppTextStyle(
                context: _widgetBuildContext, color: color ??= kAppBlack)
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
        onPressed:
            _viewModel.restSendFcmTokenRequesting ? null : () => onPressed(),
      );
    }
  }

  Widget get _notificationView {
    final PushNotificationData notificationData = _viewModel.notificationData;
    if (notificationData == null) {
      return Container();
    } else {
      return Container(
        width: _appQuery.width,
        padding: _appSpacer.edgeInsets.all.standard,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            labelView('Title'),
            emptyView(height: _appSpacer.xs),
            textContentView(notificationData.title),
            emptyView(height: _appSpacer.sm),
            labelView('Body'),
            emptyView(height: _appSpacer.xs),
            textContentView(notificationData.body),
            emptyView(height: _appSpacer.sm),
            labelView('Action Type'),
            emptyView(height: _appSpacer.xs),
            textContentView(notificationData.actionType ?? 'Empty . . .'),
            emptyView(height: _appSpacer.sm),
            labelView('Action Parameter'),
            emptyView(height: _appSpacer.xs),
            textContentView(notificationData.actionParameter ?? 'Empty . . .'),
            emptyView(height: _appSpacer.sm),
          ],
        ),
      );
    }
  }

  Future<void> _initPlatformState() async {
    _viewModel.widgetInitState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.widgetPostFrame(_widgetBuildContext);
    });
  }
}
