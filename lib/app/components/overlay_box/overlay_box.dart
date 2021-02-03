import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class OverlayBox extends StatelessWidget {
  const OverlayBox({
    this.beginColor = kAppClearWhite,
    this.endColor = kAppWhite,
    this.height = kDefaultOverlayHeight,
    this.width = kDefaultOverlayWidth,
    this.beginAlignment,
    this.endAlignment,
    this.horizontal = false,
  });

  final Color beginColor;
  final Color endColor;
  final double height;
  final double width;
  final Alignment beginAlignment;
  final Alignment endAlignment;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    if (horizontal) {
      return Container(
        /// default width of gradient's box
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: beginAlignment ?? kHorizontalBeginAlignment,
            end: endAlignment ?? kHorizontalEndAlignment,
            colors: <Color>[
              beginColor,
              endColor,
            ],
          ),
        ),
      );
    } else {
      return Container(
        /// default height of gradient's box
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: beginAlignment ?? kVerticalBeginAlignment,
            end: endAlignment ?? kVerticalEndAlignment,
            colors: <Color>[
              beginColor,
              endColor,
            ],
          ),
        ),
      );
    }
  }
}
