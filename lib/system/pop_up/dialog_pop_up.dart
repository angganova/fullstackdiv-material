import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/pop_up/dialog_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

// ignore: avoid_classes_with_only_static_members
class DialogPopUp {
  static Dialog loadingDialog;
  static bool loadingShowing = false;

  static bool dialogShowing = false;
  static BuildContext currentDialogContext;

  /// Progress Dialog
  /// Show Progress Dialog
  static Future<void> sLoading(BuildContext context) async {
    if (loadingShowing) {
      return;
    }

    const Dialog progressDialog = Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ));

    loadingShowing = true;

    await showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
                return;
              },
              child: progressDialog);
        });
  }

  /// Hide Progress Dialog
  static void hProgress(BuildContext context) {
    if (loadingDialog != null && loadingShowing) {
      Navigator.pop(context, false);
      loadingShowing = false;
    }
  }

  /// Dialog start
  static Future<void> showNormal(
      {@required BuildContext parentContext,
      @required String title,
      String detail,
      VoidCallback confirmCallback,
      bool disableBackButton = true,
      bool barrierDismissible = false,
      bool shouldOverride = false}) async {
    sBasic(
        parentContext: parentContext,
        disableBackButton: disableBackButton,
        barrierDismissible: barrierDismissible,
        title: title,
        detail: detail,
        widgetTheme: WidgetTheme.primaryWhite,
        confirmCallback: confirmCallback,
        shouldOverride: shouldOverride);
  }

  static Future<void> showWarning(
      {@required BuildContext parentContext,
      @required String title,
      String detail,
      bool disableBackButton = true,
      bool barrierDismissible = false,
      VoidCallback confirmCallback,
      bool shouldOverride = false}) async {
    sBasic(
        parentContext: parentContext,
        disableBackButton: disableBackButton,
        barrierDismissible: barrierDismissible,
        title: title,
        detail: detail,
        widgetTheme: WidgetTheme.redWhite,
        confirmCallback: confirmCallback,
        shouldOverride: shouldOverride);
  }

  static Future<void> showRestError(
      {@required BuildContext parentContext,
      bool internetConnected = true,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    await sBasicConfirmation(
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

  static Future<void> showNoInternet(
      {@required BuildContext parentContext,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    await sBasicConfirmation(
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

  static Future<void> sBasic(
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
            child: DialogView(
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

  static Future<void> sBasicConfirmation({
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
            child: DialogView(
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
