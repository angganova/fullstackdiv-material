import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DialogView extends StatelessWidget {
  const DialogView({
    Key key,
    this.topWidget,
    this.title,
    this.subtitle,
    this.firstButtonTitle,
    this.firstButtonOnPressed,
    this.firstButtonWidgetTheme,
    this.secondButtonTitle,
    this.secondButtonOnPressed,
    this.secondButtonWidgetTheme,
    this.botWidget,
  }) : super(key: key);

  final Widget topWidget;
  final String title;
  final String subtitle;
  final Widget botWidget;

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
          padding: _appSpacer.edgeInsets.all.standard,
          decoration: BoxDecoration(
            color: kAppWhite,
            borderRadius: AppRadius.createExceptBotLeftRadius(
                kBorderRadiusMed, kBorderRadiusExtraTiny),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _appSpacer.vHStandard,
              if (topWidget != null) topWidget,
              if (topWidget != null) _appSpacer.vHsm,
              if (title != null) _titleView(context),
              if (title != null) _appSpacer.vHsm,
              if (subtitle != null) _subtitleView(context),
              if (subtitle != null) _appSpacer.vHStandard,
              if (botWidget != null) _childView(context),
              _appSpacer.vHStandard,
              _firstButtonView(context),
              _secondButtonView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleView(BuildContext context) {
    if (title.isNullOrEmpty) {
      return Container();
    } else {
      return Text(title,
          textAlign: TextAlign.center,
          style: AppTextStyle(context: context, color: Colors.black).primaryH2);
    }
  }

  Widget _subtitleView(BuildContext context) {
    if (subtitle.isNullOrEmpty) {
      return Container();
    } else {
      return Text(subtitle,
          textAlign: TextAlign.center,
          style: title.isNullOrEmpty
              ? AppTextStyle(context: context, color: Colors.black).primaryPL
              : AppTextStyle(context: context, color: Colors.black)
                  .primaryLabel1);
    }
  }

  Widget _childView(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);

    if (botWidget == null) {
      return Container();
    }

    return Padding(
      padding: _appSpacer.edgeInsets.x.sm,
      child: botWidget,
    );
  }

  Widget _firstButtonView(BuildContext context) {
    if (firstButtonTitle == null) {
      return Container();
    } else {
      final AppSpacer _appSpacer = AppSpacer(context: context);
      return Container(
        padding: _appSpacer.edgeInsets.top.xs,
        child: WideButton(
            margin: _appSpacer.edgeInsets.all.none,
            onPressed: firstButtonOnPressed,
            title: firstButtonTitle,
            fullWidth: true,
            widgetTheme: firstButtonWidgetTheme,
            shadowStrokeType: ShadowStrokeType.stroke2px),
      );
    }
  }

  Widget _secondButtonView(BuildContext context) {
    if (secondButtonTitle == null) {
      return Container();
    } else {
      final AppSpacer _appSpacer = AppSpacer(context: context);
      return Container(
        padding: _appSpacer.edgeInsets.top.xs,
        child: WideButton(
            margin: _appSpacer.edgeInsets.all.none,
            onPressed: secondButtonOnPressed,
            title: secondButtonTitle,
            fullWidth: true,
            widgetTheme: secondButtonWidgetTheme,
            shadowStrokeType: ShadowStrokeType.stroke2px),
      );
    }
  }
}
