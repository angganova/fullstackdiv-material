import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [ChoiceChip] that got both [Text] & [Avatar]
class BasicChoiceChip extends StatelessWidget {
  const BasicChoiceChip({
    this.name,
    this.icon,
    this.svg = '',
    this.onSelected,
    this.onSelectedWithContext,
    this.widgetTheme = WidgetTheme.whiteBlack,
    this.selectedWidgetTheme = WidgetTheme.blueWhite,
    this.shadowStrokeType,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.iconColor,
    this.iconSelectedColor,
    this.iconSize = kSmallIconSize,
    this.textColor,
    this.textStyle,
    this.selectedTextColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderColor,
    this.selected = false,
    this.bordered = false,
  });

  /// one of them should not be null
  final String name;
  final IconData icon;
  final String svg;

  /// recommended
  final Function(bool) onSelected;
  final Function(bool, BuildContext) onSelectedWithContext;
  final WidgetTheme widgetTheme;
  final WidgetTheme selectedWidgetTheme;
  final ShadowStrokeType shadowStrokeType;

  /// optional
  final EdgeInsets padding;
  final Color iconColor;
  final Color iconSelectedColor;
  final double iconSize;
  final Color textColor;
  final TextStyle textStyle;
  final Color selectedTextColor;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color borderColor;
  final bool selected;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onSelected != null) {
          onSelected(!selected);
        } else if (onSelectedWithContext != null) {
          onSelectedWithContext(!selected, context);
        }
      },
      child: ShadowStrokeStyles(
        shadowStrokeType:
            bordered ? ShadowStrokeType.stroke2px : _shadowStrokeType,
        radius: AppQuery(context).radius,
        padding: _padding,
        color: _backgroundColor,
        borderColor: borderColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null)
              Padding(
                padding: kSpacer.edgeInsets.right.xxs,
                child: Icon(
                  icon,
                  color: _iconColor,
                  size: iconSize,
                ),
              ),
            if (name != null)
              Text(
                name,
                style: _style,
              ),
          ],
        ),
      ),
    );
  }

  /// for icons
  Color get _iconColor => selected
      ? (iconSelectedColor ?? selectedWidgetTheme.textColor)
      : (iconColor ?? widgetTheme.textColor);

  /// for text styles
  Color get _textColor => selected
      ? (selectedTextColor ?? selectedWidgetTheme.textColor)
      : (textColor ?? widgetTheme.textColor);
  TextStyle get _style => textStyle != null
      ? textStyle.copyWith(color: _textColor)
      : AppTextStyle(color: _textColor).primaryLabel2;

  /// for background color
  Color get _backgroundColor => selected
      ? (selectedBackgroundColor ?? selectedWidgetTheme.backgroundColor)
      : backgroundColor ?? widgetTheme.backgroundColor;

  /// for shadow
  ShadowStrokeType get _shadowStrokeType {
    if (shadowStrokeType == null) {
      return _backgroundColor == kAppWhite
          ? ShadowStrokeType.stroke2px
          : ShadowStrokeType.none;
    } else if (shadowStrokeType == ShadowStrokeType.stroke2px ||
        shadowStrokeType == ShadowStrokeType.stroke1px) {
      if (_backgroundColor == kAppWhite) {
        return shadowStrokeType;
      } else {
        return ShadowStrokeType.none;
      }
    } else {
      return shadowStrokeType;
    }
  }

  /// for padding
  EdgeInsets get _padding {
    if (selected &&
        (shadowStrokeType == ShadowStrokeType.stroke2px ||
            shadowStrokeType == null)) {
      return padding + const EdgeInsets.all(2.0);
    } else if (selected && shadowStrokeType == ShadowStrokeType.stroke1px) {
      return padding + const EdgeInsets.all(1.0);
    } else {
      return padding;
    }
  }
}
