import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/styles/widget_theme.dart';

class ToastView extends StatelessWidget {
  const ToastView({
    Key key,
    @required this.context,
    @required this.text,
    this.widgetTheme = WidgetTheme.primaryWhite,
    this.icon,
    this.image,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final WidgetTheme widgetTheme;
  final IconData icon;
  final String image;

  @override
  Widget build(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    final AppQuery _appQuery = AppQuery(context);

    return SafeArea(
      child: Container(
        padding: _appSpacer.edgeInsets.all.sm,
        width: _appQuery.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadiusTiny),
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
            _appSpacer.vWxs,
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style:
                    AppTextStyle(context: context, color: widgetTheme.textColor)
                        .primaryH4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
