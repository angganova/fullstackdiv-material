import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class WideButton extends StatelessWidget {
  /// this is the [WideButton] type class
  /// [title] is required
  /// [icon] is optional so we can build a button
  /// with/only/without [icon]

  const WideButton({
    @required this.title,
    this.onPressed,
    this.widgetTheme = WidgetTheme.whiteBlack,
    this.shadowStrokeType = ShadowStrokeType.lowShadow,
    this.padding,
    this.margin,
    this.icon,
    this.iconColor,
    this.iconSelectedColor,
    this.iconSize = kDefaultIconSize,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.textStyle,
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
  final EdgeInsets margin;

  /// optional
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final Color iconSelectedColor;
  final double iconSize;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color textColor;
  final TextStyle textStyle;
  final Color selectedTextColor;
  final Color disabledColor;
  final double radius;
  final bool isTransparent;

  /// this [selected] is to change the state of the button
  /// it's either selected or not selected
  final bool selected;

  /// this [fullWidth] is to change button to full width or not
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    /// here we set some of final (immutable) properties
    /// for icons
    final Color _iconColor = (onPressed == null)
        ? widgetTheme.disabledTextColor
        : (selected
            ? (iconSelectedColor ?? widgetTheme.selectedTextColor)
            : (iconColor ?? widgetTheme.textColor));

    /// for text styles
    final Color _textColor = (onPressed == null)
        ? widgetTheme.disabledTextColor
        : (selected
            ? (selectedTextColor ?? widgetTheme.selectedTextColor)
            : (textColor ?? widgetTheme.textColor));
    final TextStyle _kDefaultTextStyle =
        AppTextStyle(color: _textColor).primaryB1;

    /// for shadow/stroke type
    final ShadowStrokeType _shadowStrokeType =
        (isTransparent || _backgroundColor != kAppWhite)
            ? ShadowStrokeType.none
            : (shadowStrokeType ?? widgetTheme.shadowStrokeType);

    /// for radius (no radius means auto-rounded the button)
    final double _radius = radius ?? (AppQuery(context).radius);

    /// for disabled colors
    final Color _disabledColor =
        disabledColor ?? widgetTheme.disabledBackgroundColor;

    final EdgeInsets _padding =
        (_shadowStrokeType == ShadowStrokeType.stroke2px)
            ? const EdgeInsets.symmetric(vertical: 14.0, horizontal: 51.0)
            : (_shadowStrokeType == ShadowStrokeType.stroke1px)
                ? const EdgeInsets.symmetric(vertical: 15.0, horizontal: 52.0)
                : const EdgeInsets.symmetric(vertical: 16.0, horizontal: 53.0);

    return BasicButton(
      title: title,
      icon: icon,
      onPressed: onPressed,
      widgetTheme: widgetTheme,
      shadowStrokeType: _shadowStrokeType,
      padding: padding ?? _padding,
      margin: margin,
      iconColor: _iconColor,
      iconSize: iconSize,
      backgroundColor: _backgroundColor,
      textStyle: textStyle != null
          ? textStyle.copyWith(color: textColor)
          : _kDefaultTextStyle,
      textColor: textColor,
      selectedTextColor: selectedTextColor,
      disabledColor: _disabledColor,
      radius: _radius,
      fullWidth: fullWidth,
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
