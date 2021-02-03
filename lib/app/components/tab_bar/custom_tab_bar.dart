import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    @required this.tabs,
    this.controller,
    this.padding = const EdgeInsets.only(left: 12),
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.indicatorColor = kAppPrimaryElectricBlue,
    this.labelColor = kAppPrimaryElectricBlue,
    this.unselectedLabelColor = kAppGreyB,
    this.isScrollable = true,
    this.indicatorWeight = 2,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorPadding,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.dragStartBehavior = DragStartBehavior.start,
    this.indicator,
    this.mouseCursor,
    this.scrollPhysics,
    this.onTap,
  });

  // required
  final List<Widget> tabs;
  final TabController controller;

  // optional
  final EdgeInsets padding;
  final EdgeInsets labelPadding;
  final Color indicatorColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final bool isScrollable;
  final double indicatorWeight;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final EdgeInsets indicatorPadding;
  final TabBarIndicatorSize tabBarIndicatorSize;
  final DragStartBehavior dragStartBehavior;
  final Decoration indicator;
  final MouseCursor mouseCursor;
  final ScrollPhysics scrollPhysics;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: kAppTransparent,
        highlightColor: kAppTransparent,
      ),
      child: Padding(
        padding: padding ?? kSpacer.edgeInsets.all.none,
        child: TabBar(
          key: key,
          labelPadding: labelPadding,
          indicatorColor: indicatorColor,
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          isScrollable: isScrollable,
          indicatorWeight: indicatorWeight,
          labelStyle: labelStyle ??
              AppTextStyle(color: kAppPrimaryElectricBlue).primaryH4,
          unselectedLabelStyle:
              unselectedLabelStyle ?? AppTextStyle(color: kAppGreyB).primaryH4,
          indicatorPadding:
              indicatorPadding ?? kSpacer.edgeInsets.only(bottom: 'xs'),
          indicatorSize: tabBarIndicatorSize,
          onTap: onTap,
          tabs: tabs,
          controller: controller,
          dragStartBehavior: dragStartBehavior,
          indicator: indicator,
          mouseCursor: mouseCursor,
          physics: scrollPhysics,
        ),
      ),
    );
  }
}
