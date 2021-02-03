import 'package:flutter/material.dart';

///
/// This is a custom slide left transition
/// to be used inside CustomRoute
/// in map_routes.dart
///

SlideTransition slideLeftTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const Offset begin = Offset(1.0, 0.0);
  const Offset end = Offset.zero;
  const Cubic curve = Cubic(1.0, 0.69, 0.0, 1.0);

  final Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  // ignore: void_checks
  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}
