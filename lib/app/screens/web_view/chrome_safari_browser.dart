import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future<void> onLoadStart(String url) async {
    debugPrint('\n\nStarted $url\n\n');
  }

  @override
  Future<void> onLoadStop(String url) async {
    debugPrint('\n\nStopped $url\n\n');
  }

  @override
  void onLoadError(String url, int code, String message) {
    debugPrint("\n\nCan't load $url.. Error: $message\n\n");
  }

  @override
  void onExit() {
    debugPrint('\n\nBrowser closed!\n\n');
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  MyChromeSafariBrowser({InAppBrowser browserFallback})
      : super(bFallback: browserFallback);
  String body;
  @override
  void onOpened() {
    debugPrint('ChromeSafari browser opened');
  }

  @override
  void onCompletedInitialLoad() {
    debugPrint('ChromeSafari browser initial load completed');
  }

  @override
  void onClosed() {
    debugPrint('ChromeSafari browser closed');
  }
}
