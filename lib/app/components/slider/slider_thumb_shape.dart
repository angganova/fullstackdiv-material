import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class SliderThumbShape extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.

  const SliderThumbShape({
    this.min = 0.0,
    this.max = 1.0,
    this.unit = 'km',
    this.enabledThumbRadius = 16.0,
    this.disabledThumbRadius,
    this.textColor = kAppPrimaryElectricBlue,
    this.circleColor = kAppPrimaryElectricBlue,
  });

  final double min;
  final double max;
  final String unit;
  final Color textColor;
  final Color circleColor;

  /// The preferred radius of the round thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then the material default of 10 is used.
  final double enabledThumbRadius;

  /// The preferred radius of the round thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbRadius]
  final double disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);
    assert(!sizeWithOverflow.isEmpty);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );

    final double radius = radiusTween.evaluate(enableAnimation);
    const double blueRadius = 12.0;

    {
      // shadow
      {
        final Paint paint = Paint()..color = kAppPrimaryDarkShadowLow;
        paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
        final Offset offset = Offset(center.dx, center.dy + 2);

        canvas.drawCircle(
          offset,
          radius,
          paint,
        );
      }
      // White circle
      {
        final Paint paint = Paint()..color = kAppWhite;
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(
          center,
          radius,
          paint,
        );
      }
      // Blue circle
      {
        final Paint paint = Paint()..color = circleColor;
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(
          center,
          blueRadius,
          paint,
        );
      }
    }

    // Text
    final TextSpan textSpan = TextSpan(
      text: '${getValue(value)}$unit',
      style: AppTextStyle(color: textColor).primaryLabel1,
    );
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 100,
    );
    final Offset textCenter = Offset(center.dx - (textPainter.width / 2),
        center.dy - (textPainter.height / 2) - 30);
    textPainter.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
