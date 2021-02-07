import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLifecycleHandler extends WidgetsBindingObserver {
  AppLifecycleHandler(
      {this.detachedCallBack,
      this.inactiveCallBack,
      this.pausedCallBack,
      this.resumeCallBack});

  final AsyncCallback detachedCallBack;
  final AsyncCallback inactiveCallBack;
  final AsyncCallback pausedCallBack;
  final AsyncCallback resumeCallBack;

  @override
  Future<dynamic> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        if (detachedCallBack != null) {
          await detachedCallBack();
        }
        break;
      case AppLifecycleState.inactive:
        if (inactiveCallBack != null) {
          await inactiveCallBack();
        }
        break;
      case AppLifecycleState.paused:
        if (pausedCallBack != null) {
          await pausedCallBack();
        }
        break;
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
    }
  }
}
