import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// Component TextStyle
enum BasicHeaderStyle { h1, h2 }

extension BasicHeaderStyleExtension on BasicHeaderStyle {
  TextStyle getStyle(Color titleColor) {
    switch (this) {
      case BasicHeaderStyle.h1:
        return AppTextStyle(color: titleColor).primaryH1;
      case BasicHeaderStyle.h2:
        return AppTextStyle(color: titleColor).primaryH2;
      default:
        return null;
    }
  }
}

/// this is the [BasicHeader] class
/// this is one of the Header used in the app
/// this class Back Button & Text Widget
class BasicHeader extends StatelessWidget {
  const BasicHeader({
    @required this.onBackButtonTapped,
    this.theKey,
    this.title,
    this.backButtonIcon,
    this.backButtonColor = kAppGreyB,
    this.titleColor = kAppBlack,
    this.backgroundColor = kAppClearWhite,
    this.style = BasicHeaderStyle.h2,
  });

  /// required
  final VoidCallback onBackButtonTapped;

  ///optional
  final Key theKey;
  final String title;
  final IconData backButtonIcon;
  final Color backButtonColor;
  final Color titleColor;
  final Color backgroundColor;
  final BasicHeaderStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: theKey,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: backgroundColor,
          padding: EdgeInsets.fromLTRB(
            kSpacer.xs,
            kSpacer.xs,
            kSpacer.standard,
            (title != null) ? kSpacer.standard : kSpacer.none,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    /// if we use the existing button,
                    /// there's this padding that we can't remove
                    child: Container(
                      color: kAppClearWhite,
                      width: kSmallIconSize * 3,
                      height: kSmallIconSize * 3,
                      alignment: Alignment.center,
                      child: Icon(
                        backButtonIcon ?? Icons.arrow_back,
                        size: kSmallIconSize,
                        color: backButtonColor,
                      ),
                    ),
                    onTap: onBackButtonTapped,
                  ),
                ],
              ),
              if (title != null)
                Padding(
                  padding: EdgeInsets.only(
                    top: AppSpacer(context: context).sm,
                    left: kSpacer.sm,
                    right: kSpacer.standard,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: style.getStyle(titleColor),
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
