import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/divider/divider.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoTextItem extends StatelessWidget {
  /// this is the component to help build the UI to show all the text styles

  DemoTextItem({
    @required this.name,
    this.style,
    this.fontName,
    this.fontWeight,
    this.fontStyle,
  });

  final String name;
  final TextStyle style;
  final String fontName;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  final String _defaultFontName = kPrimaryFontFam;
  final FontWeight _defaultFontWeight = FontWeight.normal;
  final FontStyle _defaultFontStyle = FontStyle.normal;

  @override
  Widget build(BuildContext context) {
    final TextStyle _defaultStyle =
        AppTextStyle(color: kAppPrimaryElectricBlue).primaryLabel1;
    final TextStyle _fontStyle = AppTextStyle(color: kAppBlack)
        .primaryP
        .copyWith(
            fontFamily: fontName ?? _defaultFontName,
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontStyle: fontStyle ?? _defaultFontStyle);

    return Container(
      padding: kSpacer.edgeInsets.y.xs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            name,
            style: _defaultStyle,
          ),
          SizedBox(
            height: kSpacer.xxs,
          ),
          Text(
            placeholderString,
            maxLines: 1,
            style: style ?? _fontStyle,
          ),
          SizedBox(
            height: kSpacer.sm,
          ),
          const AppDivider(color: kAppBlack),
        ],
      ),
    );
  }
}
