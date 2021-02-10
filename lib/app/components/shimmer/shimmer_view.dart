import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  const ShimmerView({
    @required this.child,
    this.play = true,
    this.baseColor = kAppGreyD,
    this.highlightColor = kAppWhite,
    this.width,
    this.height,
    this.padding,
  });

  ///required
  final Widget child;

  /// optional
  final bool play;
  final Color baseColor;
  final Color highlightColor;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppSpacer(context: context).edgeInsets.x.standard,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        enabled: play,
        child: child,
      ),
    );
  }
}
