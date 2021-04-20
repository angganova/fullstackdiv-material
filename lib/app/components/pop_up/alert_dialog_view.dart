import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class AlertDialogView extends StatelessWidget {
  const AlertDialogView(
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
    final AppQuery _appQuery = AppQuery(context);
    return Dialog(
      insetPadding: _appSpacer.edgeInsets.all.standard,
      backgroundColor: kAppClearWhite,
      elevation: 0,
      child: Center(
        child: Container(
          width: _appQuery.width,
          padding: _appSpacer.edgeInsets.all.sm,
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
              _appSpacer.vHStandard,
              _childView(context),
              Row(
                children: <Widget>[
                  Expanded(child: _secondButtonView(context)),
                  Expanded(child: _firstButtonView(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleView(BuildContext context) {
    if (title.isNullOrEmpty) {
      return AppSpacer(context: context).vHsm;
    } else {
      return Text(title,
          textAlign: TextAlign.center,
          style: AppTextStyle(context: context, color: Colors.black).primaryH3);
    }
  }

  Widget _subtitleView(BuildContext context) {
    return Text(subtitle,
        textAlign: TextAlign.center,
        style: title.isNullOrEmpty
            ? AppTextStyle(context: context, color: Colors.black).primaryPL
            : AppTextStyle(context: context, color: Colors.black)
                .primaryLabel1);
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
      return WideButton(
          onPressed: firstButtonOnPressed,
          title: firstButtonTitle,
          fullWidth: true,
          widgetTheme: firstButtonWidgetTheme,
          shadowStrokeType: ShadowStrokeType.stroke2px,
          padding: _appSpacer.edgeInsets.y.sm);
    }
  }

  Widget _secondButtonView(BuildContext context) {
    if (secondButtonTitle == null) {
      return Container();
    } else {
      final AppSpacer _appSpacer = AppSpacer(context: context);
      return WideButton(
          onPressed: secondButtonOnPressed,
          title: secondButtonTitle,
          fullWidth: true,
          widgetTheme: secondButtonWidgetTheme,
          shadowStrokeType: ShadowStrokeType.stroke2px,
          padding: _appSpacer.edgeInsets.y.sm);
    }
  }
}
