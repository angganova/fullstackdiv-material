import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the class for Carousel Delimiter
/// this delimiter used for PageView
class CarouselDelimiter extends AnimatedWidget {
  const CarouselDelimiter({
    @required this.controller,
    @required this.itemCount,
    this.activeIndex,
    this.inactiveColor,
    this.activeColor = kAppBlack,
  }) : super(listenable: controller);

  /// required
  final PageController controller;
  final int itemCount;
  final int activeIndex;

  ///optional
  final Color inactiveColor;
  final Color activeColor;

  /// this is how we build the dot
  Widget _buildDot(int index) {
    final double currentPage =
        controller.page ?? controller.initialPage.toDouble();

    final double state =
        min(kExtentPoint1, (currentPage - index.toDouble()).abs());

    final Color color = Color.lerp(
      activeColor,
      inactiveColor ?? activeColor.withOpacity(0.32),
      state,
    );
    double height = kSpacer.xs;
    double width = kSpacer.xs;
    if (itemCount > 5 && activeIndex != null) {
      final int diff = (activeIndex - index).abs();

      if (diff >= 2 && diff < 4) {
        if (activeIndex > 3 || itemCount - activeIndex > 2) {
          height = kSpacer.xxs;
          width = kSpacer.xxs;
        }
      } else if (diff >= 4) {
        height = 0;
        width = 0;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSpacer.xxs),
      height: height,
      width: width,
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
