import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

///
/// This is a custom slide bottom transition
/// to be used inside CustomRoute
/// in map_routes.dart
///

SlideTransition slideBottomTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const Offset begin = Offset(0.0, 1.0);
  const Offset end = Offset.zero;

  final Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: kZestEaseOut,
    reverseCurve: kZestEaseIn,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}
