import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [CheckboxItem] which used inside the custom [Checkboxes] class
/// as the tile inside the ListView
class CheckboxItem extends StatelessWidget {
  const CheckboxItem({
    @required this.onItemTap,
    this.title,
    this.subtitle,
    this.widgetTheme = WidgetTheme.whiteBlue,
    this.shadowStrokeType,
    this.selected = false,
    this.titleColor = kAppBlack,
    this.subtitleColor,
    this.icon,
    this.iconSize = kSmallIconSize,
    this.titleStyle,
    this.buttonPadding = const EdgeInsets.all(8.0),
    this.borderColor,
    this.margin,
  });

  /// required
  final VoidCallback onItemTap;

  /// recommended
  final WidgetTheme widgetTheme;
  final ShadowStrokeType shadowStrokeType;

  /// optional
  final String title;
  final String subtitle;
  final bool selected;
  final Color titleColor;
  final Color subtitleColor;
  final IconData icon;
  final double iconSize;
  final TextStyle titleStyle;
  final EdgeInsets buttonPadding;
  final Color borderColor;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        padding: margin ?? kSpacer.edgeInsets.all.xs,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ShadowStrokeStyles(
              padding: kSpacer.edgeInsets.all.none,
              shadowStrokeType: _shadowStrokeType,
              borderColor: borderColor,
              child: CustomIconButton(
                icon: icon ?? Icons.brightness_1_outlined,
                iconSize: iconSize,
                onPressed: onItemTap,
                widgetTheme: widgetTheme,
                selected: selected,
                padding: _padding,
                shadowStrokeType: ShadowStrokeType.none,

                /// setting icon color to white
                /// to build the white round view
                /// without any icons in the middle
                iconColor: kAppWhite,
              ),
            ),
            SizedBox(width: kSpacer.sm),
            if (title != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _currentTexts,
                ),
              ),
          ],
        ),
      ),
    );
  }

  EdgeInsets get _padding {
    if (selected && shadowStrokeType == ShadowStrokeType.stroke2px) {
      return buttonPadding + const EdgeInsets.all(2.0);
    } else if (selected && shadowStrokeType == ShadowStrokeType.stroke1px) {
      return buttonPadding + const EdgeInsets.all(1.0);
    } else {
      return buttonPadding;
    }
  }

  ShadowStrokeType get _shadowStrokeType {
    if (selected && widgetTheme.selectedBackgroundColor != kAppWhite)
      return ShadowStrokeType.none;
    else
      return shadowStrokeType ?? ShadowStrokeType.lowShadow;
  }

  List<Widget> get _currentTexts {
    /// here we set some of final (immutable) properties
    /// for text styles
    final TextStyle _titleStyle =
        titleStyle ?? AppTextStyle(color: titleColor ?? kAppBlack).primaryH4;
    final TextStyle _subtitleStyle =
        AppTextStyle(color: subtitleColor ?? kAppBlack).primaryLabel4;

    return <Widget>[
      Text(
        title,
        maxLines: 2,
        style: _titleStyle,
      ),
      if (subtitle != null)
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            subtitle,
            maxLines: 2,
            style: _subtitleStyle,
          ),
        ),
    ];
  }
}
