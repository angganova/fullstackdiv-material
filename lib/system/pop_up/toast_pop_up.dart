import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';

class ToastPopUp {
  static void sInformationalToast(String text,
      {BuildContext context,
      IconData icon = Icons.info_outline_rounded,
      String image,
      Duration duration = kDuration3s}) {
    sBasicToast(text,
        context: context,
        duration: duration,
        widgetTheme: WidgetTheme.primaryWhite,
        icon: icon,
        image: image);
  }

  static void sWarningToast(String text,
      {BuildContext context,
      IconData icon = Icons.warning,
      String image,
      Duration duration = kDuration3s}) {
    sBasicToast(text,
        context: context,
        duration: duration,
        widgetTheme: WidgetTheme.yellowBlack,
        icon: icon,
        image: image);
  }

  static void sErrorToast(String text,
      {BuildContext context,
      IconData icon = Icons.error,
      String image,
      Duration duration = kDuration3s}) {
    sBasicToast(text,
        context: context,
        duration: duration,
        widgetTheme: WidgetTheme.redWhite,
        icon: icon,
        image: image);
  }

  static void sBasicToast(String text,
      {BuildContext context,
      IconData icon,
      String image,
      Duration duration = kDuration5s,
      WidgetTheme widgetTheme = WidgetTheme.primaryWhite}) {
    if (context == null) {
      _sBasicToastWithoutContext(text,
          widgetTheme: widgetTheme,
          length: duration.isMoreThan(kDuration3s)
              ? Toast.LENGTH_LONG
              : Toast.LENGTH_SHORT);
    } else {
      _sCustomToast(context, text,
          icon: icon,
          image: image,
          duration: duration,
          widgetTheme: widgetTheme);
    }
  }

  static void _sBasicToastWithoutContext(String text,
      {Toast length = Toast.LENGTH_LONG,
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

  static void _sCustomToast(BuildContext context, String text,
      {IconData icon,
      String image,
      Duration duration = kDuration5s,
      WidgetTheme widgetTheme = WidgetTheme.primaryWhite}) {
    final AppSpacer _appSpacer = AppSpacer(context: context);

    final FToast _fToast = FToast();
    _fToast.init(context);
    _fToast.removeCustomToast();
    _fToast.showToast(
        child: _customToastView(context, text,
            widgetTheme: widgetTheme, icon: icon, image: image),
        gravity: ToastGravity.BOTTOM,
        toastDuration: duration,
        positionedToastBuilder: (BuildContext context, Widget child) {
          return Positioned(
            child: child,
            bottom: _appSpacer.standard,
            left: _appSpacer.standard,
            right: _appSpacer.standard,
          );
        });
  }

  static Widget _customToastView(BuildContext context, String text,
      {WidgetTheme widgetTheme = WidgetTheme.primaryWhite,
      IconData icon,
      String image}) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    final AppQuery _appQuery = AppQuery(context);

    return Container(
      padding: _appSpacer.edgeInsets.symmetric(x: 'standard', y: 'sm'),
      width: _appQuery.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadiusMed),
        color: widgetTheme.backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (image != null)
            Image.asset(image)
          else if (icon != null)
            Icon(
              icon,
              color: widgetTheme.textColor,
            )
          else
            Container(),
          SizedBox(
            width: _appSpacer.xs,
          ),
          Expanded(
            child: Text(
              text,
              style:
                  AppTextStyle(context: context, color: widgetTheme.textColor)
                      .primaryH4,
            ),
          ),
        ],
      ),
    );
  }
}
