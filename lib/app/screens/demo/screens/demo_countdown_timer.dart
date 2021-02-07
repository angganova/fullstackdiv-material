import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/small_button.dart';
import 'package:fullstackdiv_material/app/components/countdown_timer/countdown_timer.dart';
import 'package:fullstackdiv_material/app/components/countdown_timer/countdown_timer_controller.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoCountdownTimerPage extends StatefulWidget {
  @override
  _DemoCountdownTimerPageState createState() => _DemoCountdownTimerPageState();
}

/// Count down timer state example
/// We can define another state depends on behaviour of our screen
enum TimerState { initial, loading, countingDown }

class _DemoCountdownTimerPageState extends State<DemoCountdownTimerPage>
    with TickerProviderStateMixin {
  TimerState _timerState;

  CountdownTimerController controller;

  @override
  void initState() {
    super.initState();

    _timerState = TimerState.initial;

    /// construct controller for [CountdownTimer]
    /// specify duration in seconds
    controller = CountdownTimerController(
        vsync: this,
        seconds: 10,
        onCompleted: () {
          // after timer finished update current state to initial
          // to update screen to show cta button
          setState(() {
            _timerState = TimerState.initial;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Countdown Timer\nExample',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: kSpacer.edgeInsets.all.md,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _getContent(),
                      ],
                    ),
                    SizedBox(
                      height: kSpacer.sm,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SmallButton(
                          title: 'Reset',
                          onPressed: () {
                            controller.reset();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContent() {
    switch (_timerState) {
      case TimerState.countingDown:
        return CountdownTimer(
          controller: controller,
        );
      case TimerState.loading:
        return const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kAppPrimaryElectricBlue),
        );
      case TimerState.initial:
        return SmallButton(
          title: 'Start Timer',
          onPressed: () async {
            // simulate async operation before starting count down timer
            final bool success = await _doAsyncOperation();

            if (success) {
              // update count down timer state to start counting down
              setState(() {
                _timerState = TimerState.countingDown;
              });
            }
            controller.start();
          },
        );
      default:
        return const Text('Undefined State');
    }
  }

  /// A simple function to simulate background processing like API call
  Future<bool> _doAsyncOperation() async {
    // update current state to loading state
    setState(() {
      _timerState = TimerState.loading;
    });

    await Future<dynamic>.delayed(const Duration(seconds: 2));

    // once API call finished update current state to initial state
    setState(() {
      _timerState = TimerState.initial;
    });

    return true;
  }
}
