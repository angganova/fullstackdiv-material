import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'constants.dart';
import 'dimensions.dart';

///
/// Main Query Class
///
/// To store all MediaQuery constant needed inside the app

class AppQuery {
  AppQuery(this.context);

  final BuildContext context;

  /// current context radius calculated by height
  double get radius => MediaQuery.of(context).size.height / 2;

  /// current context height
  double get height => MediaQuery.of(context).size.height;

  /// current context width
  double get width => MediaQuery.of(context).size.width;

  /// current context padding
  EdgeInsets get padding => MediaQuery.of(context).padding;

  /// current context view padding
  EdgeInsets get viewPadding => MediaQuery.of(context).viewPadding;

  /// current context view padding
  bool get notchNotNull =>
      MediaQuery.of(context).viewPadding.top > 0 &&
      MediaQuery.of(context).viewPadding.bottom > 0;

  /// current device is iPhone 5 or smaller
  bool get isSmallDevice => width < kSmallScreenWidth;

  /// current device is iPhone X or larger
  bool get isLargeDevice => height > kMedScreenHeight;

  /// current device is iPhone X or larger
  bool get isAndroid => Platform.isAndroid;

  /// current device is iPhone X or larger
  bool get isIOS => Platform.isIOS;

  /// current context view padding
  double get kDefaultBottomMargin =>
      (MediaQuery.of(context).viewPadding.top > 0 &&
              MediaQuery.of(context).viewPadding.bottom > 0)
          ? 35.0
          : AppSpacer(context: context).standard;
}
