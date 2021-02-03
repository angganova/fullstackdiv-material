import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// types of [Option]
enum OptionSize {
  big,
  small,
}

/// this is the [OptionTile] which used inside the custom [Option] class
/// as the tile inside the ListView
class OptionTile extends StatelessWidget {
  const OptionTile({
    @required this.title,
    @required this.onItemTap,
    this.subtitle,
    this.widgetTheme = WidgetTheme.tealWhite,
    this.selected = false,
    this.titleColor = kAppBlack,
    this.subtitleColor = kAppGreyB,
    this.icon,
    this.optionSize = OptionSize.big,
    this.useSeparator = false,
    this.trailingText,
  });

  /// required
  final String title;
  final VoidCallback onItemTap;

  /// recommended
  final WidgetTheme widgetTheme;

  /// optional
  final String subtitle;
  final bool selected;
  final Color titleColor;
  final Color subtitleColor;
  final IconData icon;
  final OptionSize optionSize;
  final bool useSeparator;
  final String trailingText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        color: kAppClearWhite,
        padding:
            useSeparator ? kSpacer.edgeInsets.y.sm : kSpacer.edgeInsets.y.xs,
        child: Row(
          crossAxisAlignment:
              (subtitle != null && optionSize == OptionSize.small)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: <Widget>[
            CustomIconButton(
              icon: selected
                  ? (icon ?? Icons.brightness_1_rounded)
                  : Icons.brightness_1_outlined,
              iconSize: optionSize == OptionSize.big ? kSpacer.md : kSpacer.sm,
              padding: kSpacer.edgeInsets.all.none,
              iconColor: kAppGreyC,
              backgroundColor: kAppWhite,
              iconSelectedColor: widgetTheme.selectedTextColor,
              selectedBackgroundColor: widgetTheme.selectedBackgroundColor,
              selected: selected,
              onPressed: onItemTap,
              shadowStrokeType: ShadowStrokeType.none,
            ),
            SizedBox(
              width: optionSize == OptionSize.big
                  ? kSpacer.sm
                  : kDefaultTinyMargin,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _currentTexts,
              ),
            ),
            if (trailingText != null)
              Padding(
                padding: EdgeInsets.only(
                    left: optionSize == OptionSize.big
                        ? kSpacer.sm
                        : kDefaultTinyMargin),
                child: Text(
                  trailingText,
                  maxLines: 1,
                  style: AppTextStyle(color: subtitleColor).primaryH4,
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> get _currentTexts {
    return <Widget>[
      Text(
        title,
        maxLines: 2,
        style: _titleTextStyle,
        overflow: TextOverflow.ellipsis,
      ),
      if (subtitle != null)
        Padding(
          padding: kSpacer.edgeInsets.top.xxs,
          child: Text(
            subtitle,
            maxLines: 2,
            style: _subtitleTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
    ];
  }

  TextStyle get _titleTextStyle {
    if (optionSize == OptionSize.big) {
      return AppTextStyle(color: titleColor).primaryH3;
    } else {
      return AppTextStyle(color: titleColor).primaryH4;
    }
  }

  TextStyle get _subtitleTextStyle {
    if (optionSize == OptionSize.big) {
      return AppTextStyle(color: subtitleColor).primaryP1;
    } else {
      return AppTextStyle(color: subtitleColor).primaryLabel2;
    }
  }
}
