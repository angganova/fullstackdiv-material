import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [NotificationListItem]
/// check how to use this component in :
/// demo/screens/list_item/demo_notification_list_item.dart
class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    @required this.text,
    this.widgetTheme = WidgetTheme.greyBlack,
    this.imagePath,
    this.icon,
    this.imageIconSize,
    this.imageBackgroundColor,
    this.imageBackgroundRadius,
    this.backgroundColor,
    this.textColor,
    this.trailingText,
    this.trailingSubtitle,
    this.actionName,
    this.actionColor = kAppPrimaryElectricBlue,
    this.action,
    this.padding,
    this.radius = kDefaultMargin,
    this.titleTextStyle,
    this.textUseContextInSmallPhone = true,
  });

  /// required
  final String text;

  /// recommended
  final WidgetTheme widgetTheme;

  /// optional
  final String imagePath;
  final IconData icon;
  final double imageIconSize;
  final Color imageBackgroundColor;
  final double imageBackgroundRadius;
  final Color backgroundColor;
  final Color textColor;
  final String trailingText;
  final String trailingSubtitle;
  final String actionName;
  final Color actionColor;
  final VoidCallback action;
  final EdgeInsets padding;
  final double radius;
  final TextStyle titleTextStyle;
  final bool textUseContextInSmallPhone;

  @override
  Widget build(BuildContext context) {
    final int characterCount = text.characters.length;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? widgetTheme.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          padding: padding ?? _defaultPadding,
          child: Row(
            children: <Widget>[
              if (imagePath != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    padding: (imageBackgroundColor != null)
                        ? const EdgeInsets.all(3.0)
                        : kSpacer.edgeInsets.all.none,
                    decoration: BoxDecoration(
                      color: imageBackgroundColor ?? kAppClearWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          imageBackgroundRadius ?? AppQuery(context).radius,
                        ),
                      ),
                    ),
                    child: imagePath.contains('http')
                        ? Image.network(
                            imagePath,
                            width: imageIconSize ?? kSpacer.md,
                            height: imageIconSize ?? kSpacer.md,
                          )
                        : Image.asset(
                            imagePath,
                            width: imageIconSize ?? kSpacer.md,
                            height: imageIconSize ?? kSpacer.md,
                          ),
                  ),
                )
              else if (icon != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    kSpacer.xs,
                    kSpacer.xs,
                    kSpacer.xs + 12.0,
                    kSpacer.xs,
                  ),
                  child: Icon(
                    icon,
                    size: imageIconSize ?? kSmallIconSize,
                    color: textColor ?? widgetTheme.textColor,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: characterCount > 100
                          ? kExtentZeroPoint0
                          : (characterCount > 50 ? 2.0 : 9.0)),
                  child: Text(
                    text,
                    style: titleTextStyle ??
                        (textUseContextInSmallPhone
                            ? AppTextStyle(
                                color: textColor ?? widgetTheme.textColor,
                                context: context,
                              ).primaryLabel2
                            : AppTextStyle(
                                color: textColor ?? widgetTheme.textColor,
                              ).primaryLabel2),
                  ),
                ),
              ),
              if (trailingText != null && trailingSubtitle != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      trailingSubtitle,
                      style: AppTextStyle(
                              color: (textColor ?? widgetTheme.textColor)
                                  .withOpacity(kExtentZeroPoint5))
                          .primaryLabel4,
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      trailingText,
                      style: AppTextStyle(
                              color: textColor ?? widgetTheme.textColor)
                          .primaryLabel1,
                    ),
                  ],
                )
              else if (trailingText != null)
                Text(
                  trailingText,
                  style: AppTextStyle(color: textColor ?? widgetTheme.textColor)
                      .primaryLabel1,
                ),
              if (actionName != null && action != null)
                Padding(
                  padding: EdgeInsets.only(left: kSpacer.sm),
                  child: Text(
                    actionName,
                    style: AppTextStyle(color: actionColor).primaryLabel1,
                  ),
                ),
            ],
          ),
        ),
        if (actionName != null && action != null)
          GestureDetector(
            onTap: action,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: kSpacer.lg,
                height: kSpacer.lg,
                color: kAppClearWhite,
                margin: kSpacer.edgeInsets.right.sm,
              ),
            ),
          ),
      ],
    );
  }

  EdgeInsets get _defaultPadding => EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: AppSpacer().sm,
      );
}
