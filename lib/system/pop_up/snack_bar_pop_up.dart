import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/pop_up/snack_bar_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class SnackBarPopUp {
  static void sInformation(
      {@required BuildContext context,
      @required String text,
      IconData icon = Icons.info_outline_rounded,
      WidgetTheme widgetTheme = WidgetTheme.primaryWhite,
      Duration duration = kDuration5s}) {
    sBasic(
        context: context,
        text: text,
        icon: icon,
        widgetTheme: widgetTheme,
        duration: duration);
  }

  static void sWarning(
      {@required BuildContext context,
      @required String text,
      IconData icon = Icons.warning_amber_outlined,
      WidgetTheme widgetTheme = WidgetTheme.yellowBlack,
      Duration duration = kDuration5s}) {
    sBasic(
        context: context,
        text: text,
        icon: icon,
        widgetTheme: widgetTheme,
        duration: duration);
  }

  static void sError(
      {@required BuildContext context,
      @required String text,
      IconData icon = Icons.error_outline,
      WidgetTheme widgetTheme = WidgetTheme.redWhite,
      Duration duration = kDuration5s}) {
    sBasic(
        context: context,
        text: text,
        icon: icon,
        widgetTheme: widgetTheme,
        duration: duration);
  }

  static void sBasic({
    @required BuildContext context,
    String text,
    WidgetTheme widgetTheme = WidgetTheme.yellowBlack,
    String assetImageName,
    String networkImageUrl,
    IconData icon,
    double iconSize,
    Color backgroundColor,
    Color textColor,
    Duration duration,
    VoidCallback action,
    String trailingText,
    String trailingSubtitle,
    String trailingActionName,
    Color trailingActionColor,
    VoidCallback trailingAction,
    EdgeInsets padding,
    double radius = kBorderRadiusTiny,
    VoidCallback onClose,
  }) {
    /// declare basic snack bar view
    final SnackBarView _snackBarView = SnackBarView(
      text: text,
      widgetTheme: widgetTheme,
      assetImageName: assetImageName,
      icon: icon,
      onClickSnackBar: action,
      trailingText: trailingText,
      trailingSubtitle: trailingSubtitle,
      trailingActionName: trailingActionName,
      trailingActionColor: trailingActionColor,
      onClickTrailing: trailingAction,
      duration: duration ?? kDuration5s,
      padding: padding,
      radius: radius,
      onClose: onClose,
    );

    Scaffold.of(context).removeCurrentSnackBar();

    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? kDuration5s,
        elevation: 0.0,
        backgroundColor: kAppClearWhite,
        padding: AppSpacer(context: context).edgeInsets.x.sm,
        content: _snackBarView,
      ),
    );
  }
}
