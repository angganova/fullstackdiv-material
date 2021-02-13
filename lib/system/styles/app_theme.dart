import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/styles/colors.dart';

ThemeData themeLight() {
  return ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kAppPrimaryColor,
    accentColor: kAppPrimaryColorAccent,
    scaffoldBackgroundColor: kAppWhite,
    primaryColorBrightness: Brightness.light,
  );
}
