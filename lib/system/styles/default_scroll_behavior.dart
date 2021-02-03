import 'package:flutter/material.dart';

/// The following ScrollBehavior will remove the glow effect entirely
class DefaultBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
