import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

enum ShadowStrokeType {
  /// shadows
  highShadow,
  medShadow,
  lowShadow,
  subtle,
  minimum,
  drawer,

  /// strokes
  stroke2px,
  stroke1px,

  /// no shadow no stroke
  none,
  transparent2px
}

/// this is the class which consists all the [Shadow] & [Stroke] list from [Figma]
class ShadowStrokeStyles extends StatelessWidget {
  const ShadowStrokeStyles({
    @required this.child,
    this.shadowStrokeType = ShadowStrokeType.none,
    this.color = kAppClearWhite,
    this.radius,
    this.radiusTop,
    this.borderColor,
    this.padding = const EdgeInsets.all(kDefaultMargin),
  }) : assert(child != null);

  /// required
  final Widget child;

  /// recommended
  final ShadowStrokeType shadowStrokeType;

  /// optional
  final Color color;
  final double radius;
  final double radiusTop;
  final EdgeInsets padding;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: (radiusTop != null)
            ? BorderRadius.vertical(
                top: Radius.circular(radiusTop),
              )
            : BorderRadius.all(
                Radius.circular(
                  /// auto-rounded the button
                  radius ?? AppQuery(context).radius,
                ),
              ),
        boxShadow: <BoxShadow>[_boxShadow],
        border: _border,
      ),
      child: child,
    );
  }

  BoxShadow get _boxShadow {
    switch (shadowStrokeType) {
      case ShadowStrokeType.highShadow:
        return BoxShadow(
          color: kAppPrimaryDarkShadowHigh.withOpacity(0.16),
          blurRadius: 80,
        );
        break;
      case ShadowStrokeType.medShadow:
        return BoxShadow(
          color: kAppPrimaryDarkShadowMed.withOpacity(0.09),
          blurRadius: 40,
          offset: const Offset(4, 8),
        );
        break;
      case ShadowStrokeType.lowShadow:
        return BoxShadow(
          color: kAppPrimaryDarkShadowLow.withOpacity(0.16),
          blurRadius: 4,
          offset: const Offset(0, 2),
        );
        break;
      case ShadowStrokeType.subtle:
        return BoxShadow(
          color: kAppPrimaryDarkShadowLow.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 0),
        );
        break;
      case ShadowStrokeType.minimum:
        return BoxShadow(
          color: kAppPrimaryDarkShadowLow.withOpacity(0.16),
          blurRadius: 2,
          spreadRadius: -4,
          offset: const Offset(0, 1),
        );
        break;
      case ShadowStrokeType.drawer:
        print('drawer');
        return BoxShadow(
          color: kAppPrimaryDarkShadowHigh.withOpacity(0.20),
          blurRadius: 64,
          offset: const Offset(0, 0),
        );
      default:
        return const BoxShadow(color: kAppClearWhite);
        break;
    }
  }

  Border get _border {
    switch (shadowStrokeType) {
      case ShadowStrokeType.stroke2px:
        return Border.all(color: borderColor ?? kAppGreyD, width: 2.0);
        break;
      case ShadowStrokeType.stroke1px:
        return Border.all(color: borderColor ?? kAppGreyD);
        break;
      case ShadowStrokeType.transparent2px:
        return Border.all(color: kAppClearWhite, width: 2.0);
        break;
      default:
        return Border.all(color: kAppClearWhite, width: 0.0);
        break;
    }
  }
}
