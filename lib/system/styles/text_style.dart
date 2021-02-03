import 'package:flutter/material.dart';

import 'media_query.dart';

const String kPrimaryFontFam = 'Poppins';

///
/// Main Text Style Class
///
/// used for custom icons
///
/// Letter Spacing : convert [em] to [px]
class AppTextStyle {
  AppTextStyle({@required this.color, this.context}) {
    textScaleFactor = 1.0;
    if (context != null) {
      final AppQuery _query = AppQuery(context);
      if (_query.isSmallDevice) {
        textScaleFactor = 0.8;
      } else if (!_query.isLargeDevice) {
        textScaleFactor = 0.9;
      }
    }
  }

  final Color color;
  final BuildContext context;
  double textScaleFactor;

  TextStyle get primaryH1 => TextStyle(
      color: color,
      height: 1.1,
      letterSpacing: -0.32 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 40.0 * textScaleFactor);

  TextStyle get primaryH2 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 24.0 * textScaleFactor);

  TextStyle get primaryH3 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 16.0 * textScaleFactor);

  TextStyle get secondaryH3 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w300,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 16.0 * textScaleFactor);

  TextStyle get primaryH4 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 14.0 * textScaleFactor);

  // Can i add this? For walk view on step by step mode view
  TextStyle get primaryH6 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 10.0 * textScaleFactor);

  TextStyle get primaryP => TextStyle(
      color: color,
      height: 1.5,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w400,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 14.0 * textScaleFactor);

  TextStyle get primaryLabel1 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.32 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 12.0 * textScaleFactor);

  TextStyle get primaryLabel2 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.16 * textScaleFactor,
      fontWeight: FontWeight.w500,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 12.0 * textScaleFactor);

  TextStyle get primaryLabel3 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.32 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 10.0 * textScaleFactor);

  TextStyle get secondaryLabel3 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.32 * textScaleFactor,
      fontWeight: FontWeight.w300,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 10.0 * textScaleFactor);

  TextStyle get primaryLabel4 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.32 * textScaleFactor,
      fontWeight: FontWeight.w500,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 10.0 * textScaleFactor);

  TextStyle get primaryLabel4LineThrough => TextStyle(
      decoration: TextDecoration.lineThrough,
      color: color,
      height: 1.2,
      letterSpacing: 0.32 * textScaleFactor,
      fontWeight: FontWeight.w500,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 10.0 * textScaleFactor);

  TextStyle get primaryLabel5 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w500,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 18.0 * textScaleFactor);

  TextStyle get primaryLabel6 => TextStyle(
      color: color,
      height: 1.2,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w400,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 10.0 * textScaleFactor);

  TextStyle get primaryPL => TextStyle(
      color: color,
      height: 1.5,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w500,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 16.0 * textScaleFactor);

  TextStyle get primaryP1 => TextStyle(
      color: color,
      height: 1.4,
      letterSpacing: 0.32 * textScaleFactor,
      fontWeight: FontWeight.w400,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 13.0 * textScaleFactor);

  TextStyle get primaryP2 => TextStyle(
      color: color,
      height: 1.5,
      letterSpacing: 0.32 * textScaleFactor,
      fontWeight: FontWeight.w400,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 12.0 * textScaleFactor);

  TextStyle get primaryB1 => TextStyle(
      color: color,
      height: 1.5,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w600,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 17.0 * textScaleFactor);

  TextStyle get primaryB2 => TextStyle(
      color: color,
      height: 1.7,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w500,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 15.0 * textScaleFactor);

  TextStyle get primaryB3 => TextStyle(
      color: color,
      height: 1.7,
      letterSpacing: 0.0 * textScaleFactor,
      fontWeight: FontWeight.w400,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 14.0 * textScaleFactor);

  TextStyle get primaryForm => TextStyle(
      color: color,
      height: 1.83,
      letterSpacing: 0.64 * textScaleFactor,
      fontWeight: FontWeight.w500,
      fontFamily: kPrimaryFontFam,
      fontStyle: FontStyle.normal,
      fontSize: 18.0 * textScaleFactor);
}
