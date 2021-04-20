import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class AppWDivider extends StatelessWidget {
  const AppWDivider({
    this.color = kAppGreyD,
    this.height = kDefaultDividerSize,
    this.thickness = kDefaultDividerSize,
    this.padding,
  });

  final Color color;
  final double height;
  final double thickness;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Divider(
        height: height,
        thickness: thickness,
        color: color,
      ),
    );
  }
}

class AppHDivider extends StatelessWidget {
  const AppHDivider({this.color = kAppGreyD, this.width = kDefaultDividerSize});

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: AppSpacer(context: context).standard,
      color: color,
    );
  }
}

class AppCardDivider extends StatelessWidget {
  const AppCardDivider({Key key, this.height}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAppGreyD,
      height: height ?? kSpacer.sm,
    );
  }
}
