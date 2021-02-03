import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// Custom shape for [ZSlider] slider thumb
class CustomThumbShape extends SliderComponentShape {
  CustomThumbShape({
    this.radius = 20.0,
    this.thumbValue = 0.0,
  });

  /// radius of slider thumb
  final double radius;

  /// thumb's actual position value
  double thumbValue;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = kAppWhite
      ..style = PaintingStyle.fill;

    const double evaluatedElevation = 4;
    final Path shadowPath = Path()
      ..addArc(
          Rect.fromCenter(
              center: center, width: 2 * radius, height: 2 * radius),
          0,
          math.pi * 2);

    /// add a shadow behind the circle
    canvas.drawShadow(
        shadowPath, kAppPrimaryDarkShadowLow, evaluatedElevation, true);

    /// create a circle
    canvas.drawCircle(center, radius, fillPaint);
    thumbValue = value;
  }

  double get value => thumbValue;
}
