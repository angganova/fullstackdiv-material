import 'package:flutter/material.dart';

class NoOverScrollView extends StatelessWidget {
  const NoOverScrollView(
      {Key key,
      this.child,
      this.controller,
      this.scrollDirection = Axis.vertical})
      : super(key: key);
  final Widget child;
  final ScrollController controller;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: child,
          controller: controller,
          scrollDirection: scrollDirection,
        ));
  }
}
