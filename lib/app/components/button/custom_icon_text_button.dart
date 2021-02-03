import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class CustomIconTextButton extends StatelessWidget {
  /// this is the [CustomIconTextButton] type class,
  /// an icon button with more customisable properties
  /// [onPressed] & [icon] are required

  const CustomIconTextButton({
    @required this.icon,
    @required this.text,
    this.onPressed,
    this.widgetTheme = WidgetTheme.whiteBlue,
    this.shadowStrokeType,
    this.padding,
    this.iconColor,
    this.iconSelectedColor,
    this.iconSize = kSmallIconSize,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.disabledColor,
    this.radius,
    this.selected = false,
    this.isTransparent = false,
    this.textStyle,
  });

  /// required
  final IconData icon;
  final String text;

  /// recommended
  final WidgetTheme widgetTheme;
  final ShadowStrokeType shadowStrokeType;
  final EdgeInsets padding;

  /// optional
  final VoidCallback onPressed;
  final Color iconColor;
  final Color iconSelectedColor;
  final double iconSize;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color disabledColor;
  final double radius;
  final bool isTransparent;
  final TextStyle textStyle;

  /// this [selected] is to change the state of the button
  /// it's either selected or not selected
  final bool selected;

  @override
  Widget build(BuildContext context) {
    /// here we set some of final (immutable) properties
    /// for icons
    final Color _iconColor = (onPressed == null)
        ? widgetTheme.disabledTextColor
        : (selected
            ? (iconSelectedColor ?? widgetTheme.selectedTextColor)
            : (iconColor ?? widgetTheme.textColor));

    /// for shadow/stroke type
    final ShadowStrokeType _shadowStrokeType = isTransparent
        ? ShadowStrokeType.none
        : (shadowStrokeType ?? widgetTheme.shadowStrokeType);

    /// for radius (no radius means auto-rounded the button)
    final double _radius = radius ?? (AppQuery(context).radius);

    /// for disabled colors
    final Color _disabledColor =
        disabledColor ?? widgetTheme.disabledBackgroundColor;

    final EdgeInsets _padding =
        (_shadowStrokeType == ShadowStrokeType.stroke2px)
            ? const EdgeInsets.symmetric(vertical: 18, horizontal: 18)
            : (_shadowStrokeType == ShadowStrokeType.stroke1px)
                ? const EdgeInsets.symmetric(vertical: 19, horizontal: 19)
                : const EdgeInsets.symmetric(vertical: 16, horizontal: 16);

    return Column(
      children: <Widget>[
        BasicButton(
          icon: icon,
          onPressed: onPressed,
          widgetTheme: widgetTheme,
          shadowStrokeType: _shadowStrokeType,
          padding: padding ?? _padding,
          iconColor: _iconColor,
          iconSize: iconSize,
          backgroundColor: _backgroundColor,
          disabledColor: _disabledColor,
          radius: _radius,
        ),
        SizedBox(
          height: kSpacer.xs,
        ),
        Text(
          text,
          style: textStyle ?? AppTextStyle(color: kAppGreyC).primaryLabel3,
        ),
      ],
    );
  }

  Color get _backgroundColor {
    if (isTransparent)
      return kAppClearWhite;
    else
      return selected
          ? (selectedBackgroundColor ?? widgetTheme.selectedBackgroundColor)
          : (backgroundColor ?? widgetTheme.backgroundColor);
  }
}
