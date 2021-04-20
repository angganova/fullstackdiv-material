import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class AppFlatButton extends StatelessWidget {
  const AppFlatButton({
    @required this.title,
    this.onPressed,
    this.padding,
    this.textStyle,
    this.widgetTheme = WidgetTheme.whitePrimary,
    this.withSplash = false,
    this.leadingWidget,
    this.trailingWidget,
  });

  final String title;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final WidgetTheme widgetTheme;
  final TextStyle textStyle;
  final Widget leadingWidget;
  final Widget trailingWidget;
  final bool withSplash;

  @override
  Widget build(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    return FlatButton(
      splashColor: withSplash ? null : kAppClearWhite,
      highlightColor: withSplash ? null : kAppClearWhite,
      padding: padding ?? _appSpacer.edgeInsets.all.sm,
      child: Wrap(
        children: <Widget>[
          if (leadingWidget != null) leadingWidget,
          if (leadingWidget != null) _appSpacer.vWxs,
          Text(
            title,
            style: textStyle ??
                AppTextStyle(context: context, color: widgetTheme.textColor)
                    .primaryB1,
          ),
          if (trailingWidget != null) _appSpacer.vWxs,
          if (trailingWidget != null) trailingWidget,
        ],
      ),
      onPressed: onPressed,
    );
  }
}
