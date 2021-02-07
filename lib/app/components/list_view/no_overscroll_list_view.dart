import 'package:flutter/material.dart';

class NoOverScrollView extends StatelessWidget {
  const NoOverScrollView({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: child);
  }
}
