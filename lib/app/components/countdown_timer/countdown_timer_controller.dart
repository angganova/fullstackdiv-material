import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:meta/meta.dart';

/// A controller class to control [CountdownTimer]
/// see [DemoCountdownTimerPage] to check the concrete implementation
class CountdownTimerController extends AnimationController {
  /// Creates a controller for [CountdownTimer]
  ///
  /// The [vsync] and [seconds] arguments must not be null
  /// Please make sure that widget that will use this controller need to
  /// implement [TickerProviderStateMixin] mixin
  /// [onCompleted] can be provided as a callback after count down finished.
  CountdownTimerController({
    @required this.vsync,
    @required this.seconds,
    VoidCallback onCompleted,
  }) : super(vsync: vsync, duration: Duration(seconds: seconds)) {
    /// if [onCompleted] defined, invoke it on animation dismissed
    if (onCompleted != null) {
      addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          onCompleted();
        }
      });
    }
  }

  /// [TickerProvider] for the current context that required by
  /// [AnimationController] super class
  final TickerProvider vsync;

  // duration of timer in second
  final int seconds;

  /// trigger count down from given duration
  void start() {
    reverse(from: value == kExtentZeroPoint0 ? kExtentPoint1 : value);
  }
}
