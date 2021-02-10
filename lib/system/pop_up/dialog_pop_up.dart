import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

// ignore: avoid_classes_with_only_static_members
class DialogPopUp {
  static Dialog gifProgressDialog;
  static bool gifProgressShowing = false;

  static bool dialogShowing = false;
  static BuildContext currentDialogContext;

  /// Progress Dialog
  /// Show Progress Dialog
  static Future<void> sProgressDialog(BuildContext context) async {
    if (gifProgressShowing) {
      return;
    }

    gifProgressDialog = Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Image.asset(
            'assets/gif/loading.gif',
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
        ));

    gifProgressShowing = true;

    await showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
                return;
              },
              child: gifProgressDialog);
        });
  }

  /// Hide Progress Dialog
  static void hProgressDialog(BuildContext context) {
    if (gifProgressDialog != null && gifProgressShowing) {
      Navigator.pop(context, false);
      gifProgressShowing = false;
    }
  }

  /// Dialog start
  static Future<void> showNormalNotificationDialog(
      {@required BuildContext parentContext,
      @required String title,
      String detail,
      VoidCallback confirmCallback,
      bool disableBackButton = true,
      bool barrierDismissible = false,
      bool shouldOverride = false}) async {
    sBaseNotificationDialog(
        parentContext: parentContext,
        disableBackButton: disableBackButton,
        barrierDismissible: barrierDismissible,
        title: title,
        detail: detail,
        widgetTheme: WidgetTheme.primaryWhite,
        confirmCallback: confirmCallback,
        shouldOverride: shouldOverride);
  }

  static Future<void> showWarningNotificationDialog(
      {@required BuildContext parentContext,
      @required String title,
      String detail,
      bool disableBackButton = true,
      bool barrierDismissible = false,
      VoidCallback confirmCallback,
      bool shouldOverride = false}) async {
    sBaseNotificationDialog(
        parentContext: parentContext,
        disableBackButton: disableBackButton,
        barrierDismissible: barrierDismissible,
        title: title,
        detail: detail,
        widgetTheme: WidgetTheme.redWhite,
        confirmCallback: confirmCallback,
        shouldOverride: shouldOverride);
  }

  static Future<void> showRestErrorDialog(
      {@required BuildContext parentContext,
      bool internetConnected = true,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    await baseShowConfirmationDialog(
      parentContext: parentContext,
      title: 'Whoops...',
      detail: internetConnected
          ? 'Unfortunately something is wrong - please try again'
          : 'Oops... your internet connection is not working - please try again',
      confirmText: 'Retry',
      firstButtonWidgetTheme: WidgetTheme.primaryWhite,
      confirmCallback: () {
        dismissCurrentPopUp();
        if (retryCallback != null) {
          retryCallback();
        }
      },
      cancelText: 'Cancel',
      secondButtonWidgetTheme: WidgetTheme.whitePrimary,
      cancelCallback: () {
        dismissCurrentPopUp();
        if (cancelCallback != null) {
          cancelCallback();
        }
      },
    );
  }

  static Future<void> showInternetNotConnectedDialog(
      {@required BuildContext parentContext,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    await baseShowConfirmationDialog(
      parentContext: parentContext,
      title: 'Whoops...',
      detail: 'Oops... your internet connection is not connected',
      confirmText: 'Retry',
      firstButtonWidgetTheme: WidgetTheme.primaryWhite,
      confirmCallback: () {
        dismissCurrentPopUp();
        if (retryCallback != null) {
          retryCallback();
        }
      },
      cancelText: 'component.cta.cancel',
      secondButtonWidgetTheme: WidgetTheme.whitePrimary,
      cancelCallback: () {
        dismissCurrentPopUp();
        if (cancelCallback != null) {
          cancelCallback();
        }
      },
    );
  }

  static Future<void> sBaseNotificationDialog(
      {@required BuildContext parentContext,
      @required String title,
      bool disableBackButton = true,
      bool barrierDismissible = false,
      String detail,
      String buttonText = 'Ok',
      WidgetTheme widgetTheme,
      VoidCallback confirmCallback,
      bool shouldOverride = false}) async {
    if (shouldOverride) {
      await dismissCurrentPopUp();
    } else if (dialogShowing) {
      return;
    }

    dialogShowing = true;

    await showDialog<void>(
        useSafeArea: false,
        context: parentContext,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          currentDialogContext = context;

          return WillPopScope(
            onWillPop: () async => disableBackButton
                ? Future<bool>.value(false)
                : Future<bool>.value(true),
            child: AppDialog(
              title: title,
              subtitle: detail,
              firstButtonTitle: buttonText,
              firstButtonWidgetTheme: WidgetTheme.primaryWhite,
              firstButtonOnPressed: () {
                dismissCurrentPopUp();
                if (confirmCallback != null) {
                  confirmCallback();
                }
              },
            ),
          );
        });
  }

  static Future<void> baseShowConfirmationDialog({
    @required BuildContext parentContext,
    @required String title,
    bool enableTM = false,
    bool disableBackButton = true,
    bool barrierDismissible = false,
    String detail,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    WidgetTheme firstButtonWidgetTheme = WidgetTheme.primaryWhite,
    WidgetTheme secondButtonWidgetTheme = WidgetTheme.whitePrimary,
    VoidCallback confirmCallback,
    VoidCallback cancelCallback,
    bool autoDismissWhenConfirm = true,
    bool autoDismissWhenCancel = true,
  }) async {
    if (dialogShowing) {
      return;
    }

    dialogShowing = true;
    await showDialog<void>(
        useSafeArea: false,
        context: parentContext,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          currentDialogContext = context;
          return WillPopScope(
            onWillPop: () async => disableBackButton
                ? Future<bool>.value(false)
                : Future<bool>.value(true),
            child: AppDialog(
              title: title,
              subtitle: detail,
              firstButtonTitle: confirmCallback == null ? null : confirmText,
              firstButtonWidgetTheme: firstButtonWidgetTheme,
              firstButtonOnPressed: () {
                if (autoDismissWhenConfirm) {
                  dismissCurrentPopUp();
                }
                confirmCallback();
              },
              secondButtonTitle: cancelText,
              secondButtonWidgetTheme: secondButtonWidgetTheme,
              secondButtonOnPressed: () {
                if (autoDismissWhenCancel) {
                  dismissCurrentPopUp();
                }
                cancelCallback();
              },
            ),
          );
        });
  }

  /// Dialog end

  static Future<void> dismissCurrentPopUp() async {
    if (currentDialogContext != null && dialogShowing) {
      Navigator.of(currentDialogContext).pop();
    }
    resetPopUp();
  }

  static void resetPopUp() {
    dialogShowing = false;
    currentDialogContext = null;
  }
}

class AppDialog extends StatelessWidget {
  const AppDialog(
      {Key key,
      this.title,
      this.subtitle,
      this.firstButtonTitle,
      this.firstButtonOnPressed,
      this.firstButtonWidgetTheme,
      this.secondButtonTitle,
      this.secondButtonOnPressed,
      this.secondButtonWidgetTheme,
      this.child})
      : super(key: key);

  final String title;
  final String subtitle;
  final Widget child;

  final String firstButtonTitle;
  final WidgetTheme firstButtonWidgetTheme;
  final VoidCallback firstButtonOnPressed;

  final String secondButtonTitle;
  final WidgetTheme secondButtonWidgetTheme;
  final VoidCallback secondButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
          left: _appSpacer.standard,
          right: _appSpacer.standard,
          bottom: AppQuery(context).kDefaultBottomMargin,
        ),
        decoration: BoxDecoration(
          color: kAppWhite,
          borderRadius: BorderRadius.circular(kBorderRadiusSmall),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _titleView(context),
            _subtitleView(context),
            _childView(context),
            _firstButtonView(context),
            _secondButtonView(context),
          ],
        ),
      ),
    );
  }

  Widget _titleView(BuildContext context) {
    return Text('title',
        style: AppTextStyle(context: context, color: Colors.black).primaryH3);
  }

  Widget _subtitleView(BuildContext context) {
    return Text('title',
        style:
            AppTextStyle(context: context, color: Colors.black).primaryLabel1);
  }

  Widget _childView(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);

    if (child == null) {
      return Container();
    }
    return Padding(
      padding: _appSpacer.edgeInsets.symmetric(x: 'standard'),
      child: child,
    );
  }

  Widget _firstButtonView(BuildContext context) {
    if (firstButtonTitle == null) {
      return Container();
    } else {
      final AppSpacer _appSpacer = AppSpacer(context: context);
      return Container(
        padding: EdgeInsets.only(top: _appSpacer.xs, bottom: _appSpacer.none),
        child: WideButton(
            onPressed: firstButtonOnPressed,
            title: firstButtonTitle,
            fullWidth: true,
            widgetTheme: firstButtonWidgetTheme,
            shadowStrokeType: ShadowStrokeType.stroke2px,
            padding: _appSpacer.edgeInsets.symmetric(x: 'sm', y: 'standard')),
      );
    }
  }

  Widget _secondButtonView(BuildContext context) {
    if (secondButtonTitle == null) {
      return Container();
    } else {
      final AppSpacer _appSpacer = AppSpacer(context: context);
      return Container(
        padding: EdgeInsets.only(top: _appSpacer.xs, bottom: _appSpacer.none),
        child: WideButton(
            onPressed: secondButtonOnPressed,
            title: secondButtonTitle,
            fullWidth: true,
            widgetTheme: secondButtonWidgetTheme,
            shadowStrokeType: ShadowStrokeType.stroke2px,
            padding: _appSpacer.edgeInsets.symmetric(x: 'sm', y: 'standard')),
      );
    }
  }
}
