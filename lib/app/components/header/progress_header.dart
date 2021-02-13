import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/percent_indicator/linear_precent_indicator.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// Component TextStyle
enum ProgressHeaderStyle { h1, h2 }

extension ProgressHeaderStyleExtension on ProgressHeaderStyle {
  TextStyle getStyle(Color titleColor, BuildContext context) {
    switch (this) {
      case ProgressHeaderStyle.h1:
        return AppTextStyle(color: titleColor, context: context).primaryH1;
      case ProgressHeaderStyle.h2:
        return AppTextStyle(color: titleColor, context: context).primaryH2;
      default:
        return null;
    }
  }
}

/// this is the [ProgressHeader] class
/// this is one of the Header used in the app
/// this class contains Linear Progress Indicator, Back Button
/// & Text Widget
class ProgressHeader extends StatelessWidget {
  const ProgressHeader({
    this.progressValue = 0.0,
    this.title,
    this.onBackButtonTapped,
    this.widgetTheme = WidgetTheme.greyGrey,
    this.inactiveProgressColor,
    this.activeProgressColor,
    this.backButtonColor = kAppBlackOpacity50,
    this.titleColor = kAppBlack,
    this.backgroundColor = kAppClearWhite,
    this.animation,
    this.style = ProgressHeaderStyle.h2,
  });

  ///recommended
  final double progressValue;
  final VoidCallback onBackButtonTapped;
  final String title;
  final WidgetTheme widgetTheme;
  final Color inactiveProgressColor;
  final Color activeProgressColor;

  ///optional
  final Color backButtonColor;
  final Color titleColor;
  final Color backgroundColor;
  final Animation<double> animation;
  final ProgressHeaderStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: backgroundColor,
          padding: EdgeInsets.fromLTRB(
            animation != null
                ? (animation.value > 0.0
                    ? kSpacer.xs
                    : kSpacer.standard - kSpacer.xs)
                : kSpacer.xs,
            AppSpacer(context: context).standard,
            kSpacer.standard,
            AppSpacer(context: context).standard,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Transform.scale(
                    scale: animation != null ? animation.value : 1.0,
                    child: GestureDetector(
                      child: Container(
                        color: kAppClearWhite,
                        width: (kSmallIconSize * 3) *
                            (animation != null ? animation.value : 1.0),
                        height: (kSmallIconSize * 2) *
                            (animation != null ? animation.value : 1.0),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back,
                          color: backButtonColor,
                          size: kSmallIconSize,
                        ),
                      ),
                      onTap: () {
                        if (onBackButtonTapped != null) {
                          onBackButtonTapped();
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: kSpacer.edgeInsets.left.xs,
                      height: kSpacer.lg,
                      child: LinearPercentIndicator(
                        percent: progressValue,
                        lineHeight: 4.0,
                        backgroundColor:
                            inactiveProgressColor ?? kAppBlack.withOpacity(0.1),
                        progressColor: activeProgressColor ??
                            widgetTheme.selectedBackgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
              if (title != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: kSpacer.standard - kSpacer.xs,
                    top: kSpacer.sm,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: style.getStyle(titleColor, context),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
