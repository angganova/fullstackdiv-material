import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class SingleChildScroll extends StatelessWidget {
  const SingleChildScroll({
    this.theKey,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
  });

  final Key theKey;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry padding;
  final bool primary;
  final ScrollPhysics physics;
  final ScrollController controller;
  final Widget child;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DefaultBehavior(),
      child: SingleChildScrollView(
        key: theKey,
        scrollDirection: scrollDirection,
        reverse: reverse,
        padding: padding ?? kSpacer.edgeInsets.all.none,
        primary: primary,
        physics: physics,
        controller: controller,
        child: child,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
      ),
    );
  }
}
