import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [ChoiceChip] that got both [Text] & [Avatar]
class AvatarTextChoiceChip extends StatelessWidget {
  const AvatarTextChoiceChip({
    @required this.name,
    @required this.avatar,
    @required this.onSelected,
    this.widgetTheme = WidgetTheme.whiteBlack,
    this.selectedWidgetTheme = WidgetTheme.blueWhite,
    this.shadowStrokeType,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.iconColor,
    this.iconSelectedColor,
    this.iconSize = kDefaultIconSize,
    this.textColor,
    this.selectedTextColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.selected = false,
    this.selectedShadowStrokeType,
  });

  /// required
  final String name;
  final IconData avatar;
  final Function(bool) onSelected;

  /// recommended
  final WidgetTheme widgetTheme;
  final WidgetTheme selectedWidgetTheme;
  final ShadowStrokeType shadowStrokeType;
  final ShadowStrokeType selectedShadowStrokeType;

  /// optional
  final EdgeInsets padding;
  final Color iconColor;
  final Color iconSelectedColor;
  final double iconSize;
  final Color textColor;
  final Color selectedTextColor;
  final bool selected;
  final Color backgroundColor;
  final Color selectedBackgroundColor;


  @override
  Widget build(BuildContext context) {
    /// here we set some of final (immutable) properties

    /// for text styles
    final Color _textColor = selected
        ? (selectedTextColor ?? selectedWidgetTheme.textColor)
        : (textColor ?? widgetTheme.textColor);
    final TextStyle _style = AppTextStyle(color: _textColor).primaryLabel2;

    /// for icons
    final Color _iconColor = selected
        ? (iconSelectedColor ?? selectedWidgetTheme.textColor)
        : (iconColor ?? widgetTheme.textColor);

    /// for background color
    final Color _backgroundColor = selected
        ? (selectedBackgroundColor ?? selectedWidgetTheme.backgroundColor)
        : backgroundColor ?? widgetTheme.backgroundColor;

   /// for shadow/stroke type
    final ShadowStrokeType _shadowStrokeType = shadowStrokeType ??
        (selected
            ? selectedWidgetTheme.shadowStrokeType
            : (_backgroundColor == kAppWhite
                ? ShadowStrokeType.lowShadow
                : ShadowStrokeType.none));

    return GestureDetector(
      onTap: () => onSelected(!selected),
      child: ShadowStrokeStyles(
        shadowStrokeType: _shadowStrokeType,
        radius: AppQuery(context).radius,
        padding: padding,
        color: _backgroundColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              avatar,
              color: _iconColor,
              size: iconSize,
            ),
            SizedBox(width: kSpacer.xxs),
            Text(
              name,
              style: _style,
            ),
          ],
        ),
      ),
    );
  }
}
