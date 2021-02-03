import 'dart:async';

import 'package:flutter/material.dart';

class DelayedScaleTransition extends StatefulWidget {
  /// DelayedDisplay constructor
  const DelayedScaleTransition({
    @required this.child,
    this.delay,
    this.duration = const Duration(milliseconds: 350),
  });

  /// Child that will be displayed with the animation and delay
  final Widget child;

  /// Delay before displaying the widget and the animations
  final Duration delay;

  /// Duration of the fading animation
  final Duration duration;

  @override
  _DelayedScaleTransitionState createState() => _DelayedScaleTransitionState();
}

class _DelayedScaleTransitionState extends State<DelayedScaleTransition>
    with TickerProviderStateMixin {
  /// Controller of the animation
  AnimationController _animationController;

  /// Timer used to delayed animation
  Timer _timer;

  /// Simple getter for widget's delay
  Duration get delay => widget.delay;

  /// Simple getter for widget's transitionDuration
  Duration get transitionDuration => widget.duration;

  /// Initialize controllers, curve and offset with given parameters or default values
  /// Use a Timer in order to delay the animations if needed
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: transitionDuration,
    );

    _runFadeAnimation();
  }

  /// Dispose the opacity controller
  @override
  void dispose() {
    _animationController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _runFadeAnimation() {
    if (delay == null) {
      _animationController.forward();
    } else {
      _timer = Timer(delay, () {
        _animationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationController,
      child: widget.child,
    );
  }
}
