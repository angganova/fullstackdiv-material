import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class LargeButton extends StatelessWidget {
  /// this is the [LargeButton] type class
  /// [title] is required
  /// [icon] is optional so we can build a button
  /// with/only/without [icon]

  const LargeButton({
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
    this.selected = false,
    this.isTransparent = false,
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
        AppTextStyle(color: _textColor).primaryB1;

    /// for shadow/stroke type
    final ShadowStrokeType _shadowStrokeType = isTransparent
        ? ShadowStrokeType.none
        : (shadowStrokeType ?? widgetTheme.shadowStrokeType);

    /// for radius (no radius means auto-rounded the button)
    final double _radius = radius ?? (AppQuery(context).radius);

    final EdgeInsets _padding =
        (_shadowStrokeType == ShadowStrokeType.stroke2px)
            ? const EdgeInsets.symmetric(
                vertical: 14.0, horizontal: kDefaultMargin - 2)
            : (_shadowStrokeType == ShadowStrokeType.stroke1px)
                ? const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: kDefaultMargin - 1)
                : const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: kDefaultMargin);

    return BasicButton(
      title: title,
      leadingIcon: icon,
      onPressed: onPressed,
      widgetTheme: widgetTheme,
      shadowStrokeType: _shadowStrokeType,
      padding: padding ?? _padding,
      textStyle: _kDefaultTextStyle,
      radius: _radius,
      fullWidth: fullWidth,
    );
  }
}
