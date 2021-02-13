import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class WideButton extends StatefulWidget {
  /// this is the [WideButton] type class
  /// [title] is required
  /// [icon] is optional so we can build a button
  /// with/only/without [icon]

  const WideButton({
    @required this.title,
    this.titleReplacement,
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
  final Widget titleReplacement;

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
  _WideButtonState createState() => _WideButtonState();
}

class _WideButtonState extends State<WideButton> {
  @override
  Widget build(BuildContext context) {
    /// for text styles
    final Color _textColor = (widget.onPressed == null)
        ? widget.widgetTheme.disabledTextColor
        : (widget.selected
            ? (widget.selectedTextColor ?? widget.widgetTheme.selectedTextColor)
            : (widget.textColor ?? widget.widgetTheme.textColor));
    final TextStyle _kDefaultTextStyle =
        AppTextStyle(color: _textColor).primaryB1;

    /// for shadow/stroke type
    final ShadowStrokeType _shadowStrokeType =
        (widget.isTransparent || _backgroundColor != kAppWhite)
            ? ShadowStrokeType.none
            : (widget.shadowStrokeType ?? widget.widgetTheme.shadowStrokeType);

    /// for radius (no radius means auto-rounded the button)
    final double _radius = widget.radius;

    final EdgeInsets _padding =
        (_shadowStrokeType == ShadowStrokeType.stroke2px)
            ? const EdgeInsets.symmetric(vertical: 14.0, horizontal: 51.0)
            : (_shadowStrokeType == ShadowStrokeType.stroke1px)
                ? const EdgeInsets.symmetric(vertical: 15.0, horizontal: 52.0)
                : const EdgeInsets.symmetric(vertical: 16.0, horizontal: 53.0);

    return BasicButton(
      title: widget.title,
      titleReplacement: widget.titleReplacement,
      leadingIcon: widget.icon,
      onPressed: widget.onPressed,
      widgetTheme: widget.widgetTheme,
      shadowStrokeType: _shadowStrokeType,
      padding: widget.padding ?? _padding,
      margin: widget.margin,
      textStyle: widget.textStyle?.copyWith(color: widget.textColor) ??
          _kDefaultTextStyle,
      radius: _radius,
      fullWidth: widget.fullWidth,
    );
  }

  Color get _backgroundColor {
    if (widget.isTransparent)
      return kAppClearWhite;
    else
      return widget.selected
          ? (widget.selectedBackgroundColor ??
              widget.widgetTheme.selectedBackgroundColor)
          : (widget.backgroundColor ?? widget.widgetTheme.backgroundColor);
  }
}
