import 'package:flutter/material.dart';

class TransformScaleAnimation extends StatelessWidget {
  const TransformScaleAnimation({
    @required this.child,
    @required this.animation,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: child,
    );
  }
}
