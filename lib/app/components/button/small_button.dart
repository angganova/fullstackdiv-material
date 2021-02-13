import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class SmallButton extends StatelessWidget {
  /// this is the [SmallButton] type class
  /// [title] is required
  /// [icon] is optional so we can build a button
  /// with/only/without [icon]

  const SmallButton({
    @required this.title,
    this.onPressed,
    this.widgetTheme = WidgetTheme.whiteBlue,
    this.shadowStrokeType,
    this.padding,
    this.icon,
    this.iconColor,
    this.iconSelectedColor,
    this.iconSize = kDefaultIconSize,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.disabledColor,
    this.radius,
    this.isTransparent = false,
    this.textStyle,
    this.selected = false,
    this.fullWidth = false,
  });

  /// required
  final String title;

  /// recommended
  final WidgetTheme widgetTheme;
  final ShadowStrokeType shadowStrokeType;
  final EdgeInsets padding;

  /// optional
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final Color iconSelectedColor;
  final double iconSize;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color textColor;
  final Color selectedTextColor;
  final Color disabledColor;
  final double radius;
  final bool isTransparent;
  final TextStyle textStyle;

  /// this [selected] is to change the state of the button
  /// it's either selected or not selected
  final bool selected;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    /// for text styles
    final Color _textColor = (onPressed == null)
        ? widgetTheme.disabledTextColor
        : (selected
            ? (selectedTextColor ?? widgetTheme.selectedTextColor)
            : (textColor ?? widgetTheme.textColor));
    final TextStyle _kDefaultTextStyle =
        AppTextStyle(color: _textColor).primaryB2;

    /// for shadow/stroke type
    final ShadowStrokeType _shadowStrokeType = isTransparent
        ? ShadowStrokeType.none
        : (shadowStrokeType ?? widgetTheme.shadowStrokeType);

    /// for radius (no radius means auto-rounded the button)
    final double _radius = radius ?? (AppQuery(context).radius);

    final EdgeInsets _padding =
        (_shadowStrokeType == ShadowStrokeType.stroke2px)
            ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0)
            : (_shadowStrokeType == ShadowStrokeType.stroke1px)
                ? const EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0)
                : const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0);

    return BasicButton(
      title: title,
      leadingIcon: icon,
      onPressed: onPressed,
      widgetTheme: widgetTheme,
      shadowStrokeType: _shadowStrokeType,
      padding: padding ?? _padding,
      textStyle: textStyle != null
          ? textStyle.copyWith(color: _textColor)
          : _kDefaultTextStyle,
      radius: _radius,
      fullWidth: fullWidth,
    );
  }
}
