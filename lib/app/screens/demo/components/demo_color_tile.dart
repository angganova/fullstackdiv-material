import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoColorItem extends StatelessWidget {
  /// this is the component to help build the UI to show all the colors

  const DemoColorItem({
    this.name,
    @required this.color,
    this.code,
    this.textColor,
  });

  final String name;
  final Color color;
  final String code;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final TextStyle _defaultStyle =
        AppTextStyle(color: textColor ?? kAppWhite).primaryP;

    return Container(
      color: color,
      padding: kSpacer.edgeInsets.y.xs,
      height: 80.0,
      child: Container(
        padding: kSpacer.edgeInsets.x.xxs,
        child: Center(
          child: Text(
            '$name (color code : $code)',
            textAlign: TextAlign.center,
            style: _defaultStyle,
          ),
        ),
      ),
    );
  }
}
