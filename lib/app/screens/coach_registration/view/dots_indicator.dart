import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.stepByStep = false,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color activeColor;
  final Color inactiveColor;
  final bool stepByStep;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }

  Widget _buildDot(int index) {
    final bool activePage = controller.page == index;

    final double selected = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );

    final double zoom = 1.0 + (_kMaxZoom - 1.0) * selected;

    if (stepByStep) {
      final bool pageBeforeCurrent = controller.page >= index;
      return Container(
        width: _kDotSpacing,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _kDotSize * zoom,
          height: _kDotSize * zoom,
          decoration: BoxDecoration(
              color: pageBeforeCurrent ? activeColor : inactiveColor,
              shape: BoxShape.circle),
          child: InkWell(
            onTap: onPageSelected == null ? null : () => onPageSelected(index),
          ),
        ),
      );
    } else {
      return Container(
        width: _kDotSpacing,
        child: Center(
          child: Material(
            color: activePage ? activeColor : inactiveColor,
            type: MaterialType.circle,
            child: Container(
              width: _kDotSize * zoom,
              height: _kDotSize * zoom,
              child: InkWell(
                onTap: () => onPageSelected(index),
              ),
            ),
          ),
        ),
      );
    }
  }
}
