import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// A countdown timer
///
/// A countdown timer is a simple stateful widget to run count-down timer feature
///
/// We can use countdown timer on OTP screen or other screen that requires
/// count down feature
///
/// [CountdownTimer] need [AnimationController] to control count down state
/// The reason using [AnimationController] is to have a control to timer state
/// from outside the class and to make it possible to add custom animation if needed
///
/// The [controller] argument must not be null.
/// see [DemoCountdownTimerPage] to check the concrete implementation
///
class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key key, @required this.controller}) : super(key: key);

  /// Control timer using animation controller
  /// We can only specify duration of this timer from this Animation Controller
  /// Make sure to call [AnimationController.dispose] from the corresponding screen
  /// that hold this widget
  ///
  /// see [DemoCountdownTimerPage] to check the concrete implementation
  final AnimationController controller;

  /// Get duration of timer
  Duration get duration => controller.duration;

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  // Size for this countdown timer component
  static const double _width = 49.0;
  static const double _height = 44.0;

  /// Timer value that will be printed on the screen
  String get timerValue {
    final Duration duration = widget.controller.duration *
        (widget.controller.isAnimating ? widget.controller.value : 1);
    return (duration.inSeconds).toString().padLeft(1, '0');
  }

  @override
  Widget build(BuildContext context) {
    /// for shadow/stroke type
    final ShadowStrokeType _shadowStrokeType =
        WidgetTheme.whiteBlue.shadowStrokeType;

    /// radius = auto-rounded the button
    final double _radius = AppQuery(context).radius;

    /// for text styles
    final TextStyle _kDefaultTextStyle =
        AppTextStyle(color: kAppGreyB).primaryB2;

    return Container(
      child: AnimatedBuilder(
          animation: widget.controller,
          builder: (BuildContext context, Widget child) {
            return SizedBox(
              height: _height,
              width: _width,
              child: ShadowStrokeStyles(
                shadowStrokeType: _shadowStrokeType,
                radius: _radius,
                padding: kSpacer.edgeInsets.all.none,
                child: Center(
                  child: Text(
                    timerValue,
                    style: _kDefaultTextStyle,
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    //widget.controller.dispose();
    super.dispose();
  }
}
