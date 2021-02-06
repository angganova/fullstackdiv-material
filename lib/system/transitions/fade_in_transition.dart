import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

///
/// This is a custom fade in transition
/// to be used inside CustomRoute
/// in map_routes.dart
///

FadeTransition fadeInTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final Tween<double> tween = Tween<double>(begin: 0.0, end: 1.0);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: kEaseOut,
  );

  return FadeTransition(
    opacity: tween.animate(curvedAnimation),
    child: Align(child: child),
  );
}
