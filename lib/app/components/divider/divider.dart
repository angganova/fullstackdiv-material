import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class AppDivider extends StatelessWidget {
  /// just a normal divider, to help make the code shorter ;)
  /// there's no required values in here

  const AppDivider({
    this.color = kAppGreyD,
    this.height = kDefaultDividerSize,
    this.thickness = kDefaultDividerSize,
  });

  final Color color;
  final double height;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: color,
    );
  }
}
