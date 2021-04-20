import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/pop_up/dialog_view.dart';
import 'package:fullstackdiv_material/app/components/pop_up/error_view.dart';
import 'package:fullstackdiv_material/app/components/pop_up/sso_error_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DialogPopUp {
  DialogPopUp._();

  static final DialogPopUp instance = DialogPopUp._();
  BuildContext loadingDialogContext;
  BuildContext currentDialogContext;

  /// Progress Dialog
  /// Show Progress Dialog
  Future<void> sLoading(BuildContext context) async {
    if (loadingDialogContext != null) {
      await hLoading();
    }

    const Dialog progressDialog = Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ));

    await showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          loadingDialogContext = context;
          return WillPopScope(
              onWillPop: () {
                return;
              },
              child: progressDialog);
        });
  }

  /// Hide Progress Dialog
  Future<void> hLoading() async {
    if (loadingDialogContext != null) {
      try {
        Navigator.pop(loadingDialogContext, false);
        loadingDialogContext = null;
      } catch (_) {}
    }
  }

  /// Dialog start
  Future<void> sInformation(
      {@required BuildContext parentContext,
      String title,
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

  Future<void> sWarning(
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

  Future<void> sApiError(
      {@required BuildContext parentContext,
      String message,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    if (retryCallback != null) {
      await sConfirmation(
        parentContext: parentContext,
        title: 'Whoops...',
        detail: message,
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
    } else {
      sInformation(parentContext: parentContext, detail: message);
    }
  }

  Future<void> sNoInternet(
      {@required BuildContext parentContext,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    await sConfirmation(
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

  Future<void> sNoInternetFullScreen(
      {@required BuildContext parentContext,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    await dismissCurrentPopUp();

    await showDialog<void>(
        useSafeArea: false,
        context: parentContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          currentDialogContext = context;
          return WillPopScope(
            onWillPop: () async => Future<bool>.value(false),
            child: ErrorView(
              text:
                  'Oops... your internet connection is not connected / working',
              imageAsset: 'assets/images/image_error.png',
              retryCallback: retryCallback,
              cancelCallback: cancelCallback,
            ),
          );
        });
    resetPopUp();
  }

  Future<void> sServerMaintenanceFullScreen(
      {@required BuildContext parentContext,
      VoidCallback retryCallback,
      VoidCallback cancelCallback}) async {
    await dismissCurrentPopUp();

    await showDialog<void>(
        useSafeArea: false,
        context: parentContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          currentDialogContext = context;
          return WillPopScope(
            onWillPop: () async => Future<bool>.value(false),
            child: ErrorView(
              text:
                  'Oops... unfortunately something is wrong - please try again',
              imageAsset: 'assets/images/image_error.png',
              retryCallback: retryCallback,
              cancelCallback: cancelCallback,
            ),
          );
        });
    resetPopUp();
  }

  Future<void> sSSOError(
      {@required BuildContext parentContext,
      VoidCallback submitCallback}) async {
    await dismissCurrentPopUp();

    await showDialog<void>(
        useSafeArea: false,
        context: parentContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          currentDialogContext = context;
          return WillPopScope(
            onWillPop: () async => Future<bool>.value(false),
            child: SSOErrorView(
              submitCallback: submitCallback,
            ),
          );
        });
    resetPopUp();
  }

  Future<void> sBasic(
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
    }

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

  Future<void> sConfirmation({
    @required BuildContext parentContext,
    String title,
    Widget topWidget,
    Widget botWidget,
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
              topWidget: topWidget,
              subtitle: detail,
              botWidget: botWidget,
              firstButtonTitle: confirmCallback == null ? null : confirmText,
              firstButtonWidgetTheme: firstButtonWidgetTheme,
              firstButtonOnPressed: () {
                if (autoDismissWhenConfirm) {
                  dismissCurrentPopUp();
                }
                if (confirmCallback != null) {
                  confirmCallback();
                }
              },
              secondButtonTitle: cancelText,
              secondButtonWidgetTheme: secondButtonWidgetTheme,
              secondButtonOnPressed: () {
                if (autoDismissWhenCancel) {
                  dismissCurrentPopUp();
                }
                if (cancelCallback != null) {
                  cancelCallback();
                }
              },
            ),
          );
        });
    resetPopUp();
  }

  Future<void> sFullScreenWidget(
      {@required BuildContext parentContext,
      @required Widget child,
      bool disableBackButton = true,
      bool shouldOverride = true}) async {
    if (shouldOverride) {
      await dismissCurrentPopUp();
    }

    await showDialog<void>(
        useSafeArea: false,
        context: parentContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          currentDialogContext = context;
          return child;
        });
  }


  /// Dialog end

  Future<void> dismissCurrentPopUp() async {
    if (currentDialogContext != null) {
      try {
        Navigator.of(currentDialogContext).pop();
      } catch (_) {}
    }
    resetPopUp();
  }

  void resetPopUp() {
    currentDialogContext = null;
  }
}
