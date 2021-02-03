import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/overlay_box/overlay_box.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import 'bottom_navigation_item.dart';

typedef ItemBuilder = Widget Function(
    BuildContext context, CustomBottomNavigationItem items);

class CustomBottomNavigationBar extends StatefulWidget {
  /// Github reference : https://github.com/right7ctrl/flutter_floating_bottom_navigation_bar
  /// this is the [CustomBottomNavigationBar] class
  /// the required param are [items], [currentIndex], [onTap]
  /// NOTE : The maximum item count of this class is 4 [FOUR] items

  /// the default values didn't use [kSpacer] cause it should be a constant
  /// so we stored the values inside [constants.dart] in /utils/styles/
  CustomBottomNavigationBar({
    Key key,
    @required this.items,
    @required this.currentIndex,
    @required this.onTap,
    ItemBuilder itemBuilder,
    this.backgroundColor = kAppWhite,
    this.selectedBackgroundColor = kAppWhite,
    this.selectedItemColor = kAppPrimaryElectricBlue,
    this.iconSize = kDefaultIconSize,
    this.textStyle,
    this.borderRadius,
    this.itemBorderRadius = kBorderRadiusMed,
    this.unselectedItemColor = kAppGreyC,

    ///
    /// this is the value of padding between the rounded view & white gradient
    this.margin,

    /// this is the value of padding between the items and rounded view
    this.padding,
    this.useGradientBox = true,
  })  : assert(items.length > 1),
        assert(items.length <= 4),
        assert(currentIndex <= items.length),
        itemBuilder = itemBuilder ??
            _defaultItemBuilder(
              unselectedItemColor: unselectedItemColor,
              selectedItemColor: selectedItemColor,
              borderRadius: borderRadius,
              textStyle: textStyle,
              backgroundColor: backgroundColor,
              currentIndex: currentIndex,
              iconSize: iconSize,
              itemBorderRadius: itemBorderRadius,
              items: items,
              onTap: onTap,
              selectedBackgroundColor: selectedBackgroundColor,
            ),
        super(key: key);

  /// required
  final List<CustomBottomNavigationItem> items;
  final int currentIndex;
  final void Function(int val) onTap;

  /// optional
  final Color selectedBackgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double iconSize;
  final double itemBorderRadius;
  final double borderRadius;
  final ItemBuilder itemBuilder;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool useGradientBox;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  List<CustomBottomNavigationItem> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    final double _radiusValue = widget.borderRadius ?? AppQuery(context).radius;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        /// this container is to make the white gradient better in long screens (e.g: iPhoneX)
        if (widget.useGradientBox)
          const Positioned.fill(
            child: OverlayBox(
              height: double.infinity,
              endAlignment: Alignment(0.0, -0.5),
            ),
          ),

        /// this is the navigation bar
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: widget.margin ??
                  EdgeInsets.fromLTRB(
                    kSpacer.standard,
                    2.0,
                    kSpacer.standard,
                    AppQuery(context).kDefaultBottomMargin,
                  ),
              child: ShadowStrokeStyles(
                shadowStrokeType: ShadowStrokeType.lowShadow,
                padding: widget.padding ??
                    EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: AppSpacer(context: context).standard,
                    ),
                color: widget.backgroundColor,
                radius: _radiusValue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items.map((CustomBottomNavigationItem f) {
                    return widget.itemBuilder(context, f);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

ItemBuilder _defaultItemBuilder({
  Function(int val) onTap,
  List<CustomBottomNavigationItem> items,
  int currentIndex,
  Color selectedBackgroundColor,
  Color selectedItemColor,
  Color unselectedItemColor,
  Color backgroundColor,
  TextStyle textStyle,
  double iconSize,
  double itemBorderRadius,
  double borderRadius,
}) {
  return (BuildContext context, CustomBottomNavigationItem item) => Expanded(
        child: AnimatedContainer(
          duration: kDuration300,
          decoration: BoxDecoration(
            color: currentIndex == items.indexOf(item)
                ? selectedBackgroundColor
                : backgroundColor,
            borderRadius: BorderRadius.circular(itemBorderRadius),
          ),
          child: InkWell(
            onTap: () {
              onTap(items.indexOf(item));
            },
            borderRadius: BorderRadius.circular(itemBorderRadius),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: currentItems(
                item: item,
                color: currentIndex == items.indexOf(item)
                    ? selectedItemColor
                    : unselectedItemColor,
                iconSize: item.iconSize ?? iconSize,
                style: textStyle ??
                    AppTextStyle(
                      color: currentIndex == items.indexOf(item)
                          ? selectedItemColor
                          : kAppGreyB,
                    ).primaryLabel4,
                selected: currentIndex == items.indexOf(item),
              ),
            ),
          ),
        ),
      );
}

List<Widget> currentItems({
  CustomBottomNavigationItem item,
  Color color,
  double iconSize,
  TextStyle style,
  bool selected,
}) {
  return <Widget>[
    Icon(
      item.icon,
      color: color,
      size: iconSize,
    ),
    SizedBox(
      height: iconSize > kDefaultIconSize ? kSpacer.none : kSpacer.xs,
    ),
    Text(
      item.title,
      style: style,
    ),
  ];
}
