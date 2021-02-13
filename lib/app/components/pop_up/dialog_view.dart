import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DialogView extends StatelessWidget {
  const DialogView(
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
