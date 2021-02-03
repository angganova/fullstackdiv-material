import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [ChoiceChip] that got both [Text] & [star]
class IconStarTextChoiceChip extends StatelessWidget {
  const IconStarTextChoiceChip({
    this.name,
    @required this.numberStar,
    @required this.onSelected,
    this.widgetTheme = WidgetTheme.whiteBlack,
    this.selectedWidgetTheme = WidgetTheme.blueWhite,
    this.shadowStrokeType,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
    this.iconColor,
    this.iconSelectedColor,
    this.iconSize = kDefaultIconSize,
    this.textColor,
    this.selectedTextColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.selected = false,
  });

  /// required
  final String name;
  final int numberStar;
  final Function(bool) onSelected;

  /// recommended
  final WidgetTheme widgetTheme;
  final WidgetTheme selectedWidgetTheme;
  final ShadowStrokeType shadowStrokeType;

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
    final TextStyle _style = AppTextStyle(color: _textColor).primaryB3;

    /// for icons
    final Color _iconColor = selected
        ? (iconSelectedColor ?? selectedWidgetTheme.textColor)
        : (iconColor ?? widgetTheme.textColor);

    /// for background color
    final Color _backgroundColor = selected
        ? (selectedBackgroundColor ?? selectedWidgetTheme.backgroundColor)
        : backgroundColor ?? widgetTheme.backgroundColor;

    /// for shadow/stroke type
    ShadowStrokeType _shadowStrokeType = shadowStrokeType ??
        (selected
            ? selectedWidgetTheme.shadowStrokeType
            : (_backgroundColor == kAppWhite
                ? ShadowStrokeType.none
                : ShadowStrokeType.none));
    _shadowStrokeType = selected ? ShadowStrokeType.transparent2px : _shadowStrokeType;

  List<Widget> _listIconStar(BuildContext context) {

    final List<Widget> listIcon = <Widget>[];

    for(int i = 0; i < numberStar; i++ ) {
      listIcon.add(
        Padding(
          padding: EdgeInsets.fromLTRB(
            kSpacer.none, kSpacer.none, kSpacer.xxs / 2, kSpacer.none),
            child: Icon(
            Icons.star,
            color: _iconColor,
            size: iconSize,
          ),
        ),
      );
    }
    return listIcon;
  }

    return GestureDetector(
      onTap: () => onSelected(!selected),
      child: ShadowStrokeStyles(
        shadowStrokeType: selected ? ShadowStrokeType.transparent2px :_shadowStrokeType,
        radius: AppQuery(context).radius,
        padding: padding,
        color: _backgroundColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: _listIconStar(context),
            ),
            // SizedBox(width: kSpacer.xxs),
            Text(
              // ignore: unnecessary_string_interpolations
              '${name ?? "+"}' ,
              style: _style,
            ),
          ],
        ),
      ),
    );
  }
}
