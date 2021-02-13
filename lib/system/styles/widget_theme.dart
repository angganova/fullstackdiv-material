import 'package:flutter/material.dart';

import '../global_styles.dart';
import 'shadow_stroke_styles.dart';

/// this is the class that contains all Button Styles
/// to be used immediately inside the classes without
/// adding any style like backgroundColor, selectedBackgroundColor,
/// textColor, selectedTextColor & shadowStrokeType
///
///
/// the naming for the [2 color] styles is based on this rule :
/// [normal_background_color][normal_text_color]
/// so for example : blue normal background color & white normal text color
/// the name will be : blueWhite
/// selected background color = normal text color
/// & selected text color = normal background color

enum WidgetTheme {
  /// 2 colors styles
  clearPrimary,
  primaryWhite,
  whitePrimary,
  blueWhite,
  whiteBlue,
  blackWhite,
  whiteBlack,
  yellowBlack,
  yellowBlackCheckbox,
  blackYellow,
  greyGrey,
  greyWhite,
  whiteGrey,
  greyBlack,
  darkGreyWhite,
  redWhite,
  whiteRed,
  whiteFriendlyRed,
  custom,
  tealWhite,
  secondaryTealWhite,
  greyAWhite,
  pinkBlack,
  blackPink,
  secondaryTeal
}

extension WidgetThemeExtension on WidgetTheme {
  ///
  ///
  /// background colors
  static const Map<WidgetTheme, Color> backgroundColors = <WidgetTheme, Color>{
    WidgetTheme.clearPrimary: kAppClearWhite,
    WidgetTheme.primaryWhite: kAppPrimaryColor,
    WidgetTheme.whitePrimary: kAppWhite,
    WidgetTheme.blueWhite: kAppPrimaryElectricBlue,
    WidgetTheme.whiteBlue: kAppWhite,
    WidgetTheme.blackWhite: kAppBlack,
    WidgetTheme.whiteBlack: kAppWhite,
    WidgetTheme.yellowBlack: kAppSecondaryYellow,
    WidgetTheme.yellowBlackCheckbox: kAppWhite,
    WidgetTheme.blackYellow: kAppBlack,
    WidgetTheme.greyGrey: kAppGreyD,
    WidgetTheme.greyWhite: kAppGreyD,
    WidgetTheme.whiteGrey: kAppWhite,
    WidgetTheme.greyBlack: kAppGreyD,
    WidgetTheme.darkGreyWhite: kAppGreyA,
    WidgetTheme.redWhite: kAppPrimaryRed,
    WidgetTheme.whiteRed: kAppWhite,
    WidgetTheme.whiteFriendlyRed: kAppWhite,
    WidgetTheme.custom: null,
    WidgetTheme.tealWhite: kAppFriendlyTeal,
    WidgetTheme.secondaryTealWhite: kAppSecondaryTeal,
    WidgetTheme.greyAWhite: kAppGreyA,
    WidgetTheme.pinkBlack: kAppSecondaryPink,
    WidgetTheme.blackPink: kAppBlack,
    WidgetTheme.secondaryTeal: kAppSecondaryTeal,
  };

  Color get backgroundColor => backgroundColors[this];

  ///
  ///
  /// normal text colors
  static const Map<WidgetTheme, Color> textColors = <WidgetTheme, Color>{
    WidgetTheme.clearPrimary: kAppPrimaryColor,
    WidgetTheme.primaryWhite: kAppWhite,
    WidgetTheme.whitePrimary: kAppPrimaryColor,
    WidgetTheme.blueWhite: kAppWhite,
    WidgetTheme.whiteBlue: kAppPrimaryElectricBlue,
    WidgetTheme.blackWhite: kAppWhite,
    WidgetTheme.whiteBlack: kAppBlack,
    WidgetTheme.yellowBlack: kAppBlack,
    WidgetTheme.yellowBlackCheckbox: kAppWhite,
    WidgetTheme.blackYellow: kAppSecondaryYellow,
    WidgetTheme.greyGrey: kAppGreyC,
    WidgetTheme.greyWhite: kAppWhite,
    WidgetTheme.whiteGrey: kAppGreyC,
    WidgetTheme.darkGreyWhite: kAppWhite,
    WidgetTheme.redWhite: kAppWhite,
    WidgetTheme.whiteRed: kAppPrimaryRed,
    WidgetTheme.whiteFriendlyRed: kAppFriendlyRed,
    WidgetTheme.custom: kAppWhite,
    WidgetTheme.tealWhite: kAppWhite,
    WidgetTheme.secondaryTealWhite: kAppBlack,
    WidgetTheme.greyAWhite: kAppWhite,
    WidgetTheme.pinkBlack: kAppBlack,
    WidgetTheme.blackPink: kAppSecondaryPink,
    WidgetTheme.secondaryTeal: kAppWhite,
  };

  Color get textColor => textColors[this];

  ///
  ///
  /// selected background colors
  static const Map<WidgetTheme, Color> selectedBackgroundColors =
  <WidgetTheme, Color>{
    WidgetTheme.blueWhite: kAppPrimaryBrightBlue,
    WidgetTheme.whiteBlue: kAppPrimaryElectricBlue,
    WidgetTheme.blackWhite: kAppWhite,
    WidgetTheme.whiteBlack: kAppBlack,
    WidgetTheme.yellowBlack: kAppBlack,
    WidgetTheme.yellowBlackCheckbox: kAppSecondaryYellow,
    WidgetTheme.blackYellow: kAppSecondaryYellow,
    WidgetTheme.greyGrey: kAppGreyC,
    WidgetTheme.greyWhite: kAppWhite,
    WidgetTheme.whiteGrey: kAppGreyC,
    WidgetTheme.greyBlack: kAppBlack,
    WidgetTheme.darkGreyWhite: kAppWhite,
    WidgetTheme.redWhite: kAppWhite,
    WidgetTheme.whiteRed: kAppPrimaryRed,
    WidgetTheme.whiteFriendlyRed: kAppFriendlyRed,
    WidgetTheme.custom: kAppWhite,
    WidgetTheme.tealWhite: kAppWhite,
    WidgetTheme.secondaryTealWhite: kAppWhite,
    WidgetTheme.greyAWhite: kAppWhite,
    WidgetTheme.pinkBlack: kAppBlack,
    WidgetTheme.blackPink: kAppSecondaryPink,
    WidgetTheme.secondaryTeal: kAppWhite,
  };

  Color get selectedBackgroundColor => selectedBackgroundColors[this];

  ///
  ///
  /// selected text colors
  static const Map<WidgetTheme, Color> selectedTextColors =
  <WidgetTheme, Color>{
    WidgetTheme.clearPrimary: kAppPrimaryColor,
    WidgetTheme.primaryWhite: kAppWhite,
    WidgetTheme.whitePrimary: kAppPrimaryColor,
    WidgetTheme.blueWhite: kAppBlack,
    WidgetTheme.whiteBlue: kAppWhite,
    WidgetTheme.blackWhite: kAppBlack,
    WidgetTheme.whiteBlack: kAppPrimaryElectricBlue,
    WidgetTheme.yellowBlack: kAppSecondaryYellow,
    WidgetTheme.yellowBlackCheckbox: kAppBlack,
    WidgetTheme.blackYellow: kAppBlack,
    WidgetTheme.greyGrey: kAppGreyD,
    WidgetTheme.greyWhite: kAppGreyD,
    WidgetTheme.whiteGrey: kAppWhite,
    WidgetTheme.greyBlack: kAppGreyD,
    WidgetTheme.darkGreyWhite: kAppGreyA,
    WidgetTheme.redWhite: kAppPrimaryRed,
    WidgetTheme.whiteRed: kAppWhite,
    WidgetTheme.whiteFriendlyRed: kAppWhite,
    WidgetTheme.custom: kAppWhite,
    WidgetTheme.tealWhite: kAppFriendlyTeal,
    WidgetTheme.secondaryTealWhite: kAppSecondaryTeal,
    WidgetTheme.greyAWhite: kAppGreyA,
    WidgetTheme.pinkBlack: kAppSecondaryPink,
    WidgetTheme.blackPink: kAppBlack,
    WidgetTheme.secondaryTeal: kAppSecondaryTeal,
  };

  Color get selectedTextColor => selectedTextColors[this];

  ///
  ///
  /// shadow/stroke
  static const Map<WidgetTheme, ShadowStrokeType> shadowStrokeTypes =
  <WidgetTheme, ShadowStrokeType>{
    WidgetTheme.blueWhite: ShadowStrokeType.none,
    WidgetTheme.whiteBlue: ShadowStrokeType.stroke2px,
    WidgetTheme.blackWhite: ShadowStrokeType.none,
    WidgetTheme.whiteBlack: ShadowStrokeType.stroke2px,
    WidgetTheme.yellowBlack: ShadowStrokeType.none,
    WidgetTheme.yellowBlackCheckbox: ShadowStrokeType.none,
    WidgetTheme.blackYellow: ShadowStrokeType.none,
    WidgetTheme.greyGrey: ShadowStrokeType.none,
    WidgetTheme.greyWhite: ShadowStrokeType.none,
    WidgetTheme.whiteGrey: ShadowStrokeType.stroke2px,
    WidgetTheme.greyBlack: ShadowStrokeType.none,
    WidgetTheme.darkGreyWhite: ShadowStrokeType.none,
    WidgetTheme.redWhite: ShadowStrokeType.none,
    WidgetTheme.whiteRed: ShadowStrokeType.stroke2px,
    WidgetTheme.whiteFriendlyRed: ShadowStrokeType.stroke2px,
    WidgetTheme.custom: ShadowStrokeType.none,
    WidgetTheme.tealWhite: ShadowStrokeType.none,
    WidgetTheme.secondaryTealWhite: ShadowStrokeType.none,
    WidgetTheme.greyAWhite: ShadowStrokeType.none,
    WidgetTheme.pinkBlack: ShadowStrokeType.none,
    WidgetTheme.blackPink: ShadowStrokeType.none,
    WidgetTheme.secondaryTeal: ShadowStrokeType.none,
  };

  ShadowStrokeType get shadowStrokeType => shadowStrokeTypes[this];

  ///
  ///
  /// highlighted background color
  static const Map<WidgetTheme, Color> highlightedBackgroundColors =
  <WidgetTheme, Color>{
    WidgetTheme.blueWhite: kAppPrimaryBrightBlue,
    WidgetTheme.whiteBlue: kAppPrimaryElectricBlue,
    WidgetTheme.blackWhite: kAppWhite,
    WidgetTheme.whiteBlack: kAppBlack,
    WidgetTheme.yellowBlack: kAppBlack,
    WidgetTheme.yellowBlackCheckbox: kAppBlack,
    WidgetTheme.blackYellow: kAppSecondaryYellow,
    WidgetTheme.greyGrey: kAppGreyC,
    WidgetTheme.greyWhite: kAppWhite,
    WidgetTheme.whiteGrey: kAppGreyC,
    WidgetTheme.greyBlack: kAppBlack,
    WidgetTheme.darkGreyWhite: kAppWhite,
    WidgetTheme.redWhite: kAppWhite,
    WidgetTheme.whiteRed: kAppPrimaryRed,
    WidgetTheme.whiteFriendlyRed: kAppFriendlyRed,
    WidgetTheme.custom: kAppWhite,
    WidgetTheme.tealWhite: kAppWhite,
    WidgetTheme.secondaryTealWhite: kAppWhite,
    WidgetTheme.greyAWhite: kAppWhite,
    WidgetTheme.pinkBlack: kAppBlack,
    WidgetTheme.blackPink: kAppSecondaryPink,
    WidgetTheme.secondaryTeal: kAppWhite,
  };

  Color get highlightedBackgroundColor => highlightedBackgroundColors[this];

  ///
  ///
  /// disabled background color
  static const Map<WidgetTheme, Color> disabledBackgroundColors =
  <WidgetTheme, Color>{
    WidgetTheme.clearPrimary: kAppGreyD,
    WidgetTheme.primaryWhite: kAppGreyD,
    WidgetTheme.whitePrimary: kAppGreyD,
    WidgetTheme.blueWhite: kAppGreyD,
    WidgetTheme.whiteBlue: kAppGreyD,
    WidgetTheme.blackWhite: kAppGreyC,
    WidgetTheme.whiteBlack: kAppGreyC,
    WidgetTheme.yellowBlack: kAppGreyC,
    WidgetTheme.yellowBlackCheckbox: kAppGreyC,
    WidgetTheme.blackYellow: kAppGreyC,
    WidgetTheme.greyGrey: kAppGreyD,
    WidgetTheme.greyWhite: kAppGreyD,
    WidgetTheme.whiteGrey: kAppGreyD,
    WidgetTheme.greyBlack: kAppGreyD,
    WidgetTheme.darkGreyWhite: kAppGreyD,
    WidgetTheme.redWhite: kAppGreyD,
    WidgetTheme.whiteRed: kAppGreyD,
    WidgetTheme.whiteFriendlyRed: kAppGreyD,
    WidgetTheme.custom: kAppGreyD,
    WidgetTheme.tealWhite: kAppGreyD,
    WidgetTheme.secondaryTealWhite: kAppGreyD,
    WidgetTheme.greyAWhite: kAppGreyD,
    WidgetTheme.pinkBlack: kAppGreyD,
    WidgetTheme.blackPink: kAppGreyD,
    WidgetTheme.secondaryTeal: kAppGreyD,
  };

  Color get disabledBackgroundColor => disabledBackgroundColors[this];

  ///
  ///
  /// disabled text color
  static const Map<WidgetTheme, Color> disabledTextColors =
  <WidgetTheme, Color>{
    WidgetTheme.clearPrimary: kAppWhite,
    WidgetTheme.primaryWhite: kAppWhite,
    WidgetTheme.whitePrimary: kAppWhite,
    WidgetTheme.blueWhite: kAppGreyB,
    WidgetTheme.whiteBlue: kAppGreyB,
    WidgetTheme.blackWhite: kAppWhite,
    WidgetTheme.whiteBlack: kAppWhite,
    WidgetTheme.yellowBlack: kAppWhite,
    WidgetTheme.yellowBlackCheckbox: kAppWhite,
    WidgetTheme.blackYellow: kAppWhite,
    WidgetTheme.greyGrey: kAppGreyC,
    WidgetTheme.greyWhite: kAppWhite,
    WidgetTheme.whiteGrey: kAppWhite,
    WidgetTheme.greyBlack: kAppWhite,
    WidgetTheme.darkGreyWhite: kAppWhite,
    WidgetTheme.redWhite: kAppWhite,
    WidgetTheme.whiteRed: kAppWhite,
    WidgetTheme.whiteFriendlyRed: kAppWhite,
    WidgetTheme.custom: kAppWhite,
    WidgetTheme.tealWhite: kAppWhite,
    WidgetTheme.secondaryTealWhite: kAppWhite,
    WidgetTheme.greyAWhite: kAppWhite,
    WidgetTheme.pinkBlack: kAppWhite,
    WidgetTheme.blackPink: kAppWhite,
    WidgetTheme.secondaryTeal: kAppWhite,
  };

  Color get disabledTextColor => disabledTextColors[this];
}
