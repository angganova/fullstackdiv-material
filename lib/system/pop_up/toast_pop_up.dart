import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullstackdiv_material/app/components/pop_up/toast_view.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ToastPopUp {
  static void sInformation(
      {BuildContext context,
      @required String text,
      IconData icon = Icons.info_outline_rounded,
      String image,
      Duration duration = kDuration3s}) {
    sBasic(
        text: text,
        context: context,
        duration: duration,
        widgetTheme: WidgetTheme.primaryWhite,
        icon: icon,
        image: image);
  }

  static void sWarning(
      {BuildContext context,
      @required String text,
      IconData icon = Icons.warning,
      String image,
      Duration duration = kDuration3s}) {
    sBasic(
        text: text,
        context: context,
        duration: duration,
        widgetTheme: WidgetTheme.yellowBlack,
        icon: icon,
        image: image);
  }

  static void sError(
      {BuildContext context,
      @required String text,
      IconData icon = Icons.error,
      String image,
      Duration duration = kDuration3s}) {
    sBasic(
        text: text,
        context: context,
        duration: duration,
        widgetTheme: WidgetTheme.redWhite,
        icon: icon,
        image: image);
  }

  static void sBasic(
      {BuildContext context,
      @required String text,
      IconData icon,
      String image,
      Duration duration = kDuration5s,
      WidgetTheme widgetTheme = WidgetTheme.primaryWhite}) {
    if (context == null) {
      _sBasicWithoutContext(
          text: text,
          widgetTheme: widgetTheme,
          length: duration.isMoreThan(kDuration3s)
              ? Toast.LENGTH_LONG
              : Toast.LENGTH_SHORT);
    } else {
      _sCustom(
          context: context,
          text: text,
          icon: icon,
          image: image,
          duration: duration,
          widgetTheme: widgetTheme);
    }
  }

  static void _sBasicWithoutContext(
      {Toast length = Toast.LENGTH_LONG,
      @required String text,
      WidgetTheme widgetTheme = WidgetTheme.primaryWhite}) {
    Fluttertoast?.cancel();

    Fluttertoast.showToast(
        msg: text,
        toastLength: length,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: widgetTheme.backgroundColor,
        textColor: widgetTheme.textColor,
        fontSize: 16);
  }

  static void _sCustom(
      {@required BuildContext context,
      @required String text,
      IconData icon,
      String image,
      Duration duration = kDuration5s,
      WidgetTheme widgetTheme = WidgetTheme.primaryWhite}) {
    final AppSpacer _appSpacer = AppSpacer(context: context);

    final FToast _fToast = FToast();
    _fToast.init(context);
    _fToast.removeCustomToast();
    _fToast.showToast(
        child: ToastView(
            context: context,
            text: text,
            widgetTheme: widgetTheme,
            icon: icon,
            image: image),
        gravity: ToastGravity.BOTTOM,
        toastDuration: duration,
        positionedToastBuilder: (BuildContext context, Widget child) {
          return Positioned(
            child: child,
            bottom: _appSpacer.sm,
            left: _appSpacer.sm,
            right: _appSpacer.sm,
          );
        });
  }
}
