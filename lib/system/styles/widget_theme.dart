import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
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
  blueWhite,
  whiteBlue,
  blackWhite,
  whiteBlack,
  yellowBlack,
  yellowBlackCheckbox, // yellow black style for check box
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
  secondaryTeal,

  /// MRT Theme
  mrtDTTheme,
  mrtEWTheme,
  mrtNSTheme,
  mrtNETheme,
  mrtCCTheme,
  mrtTETheme,

  /// LRT Theme
  lrtBPTheme,
  lrtSETheme,
  lrtSWTheme,
  lrtPETheme,
  lrtPWTheme,

  ///Tram
  sentosaExpressTheme,

  /// Bus Theme
  busTheme,
  grandShuttleTheme,
  beachShuttleTheme,
  mountFaberTheme,

  /// Walk Theme
  walkTheme,
}

extension WidgetThemeExtension on WidgetTheme {
  ///
  ///
  /// background colors
  static const Map<WidgetTheme, Color> backgroundColors = <WidgetTheme, Color>{
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
    WidgetTheme.walkTheme: kAppWhite,
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
    WidgetTheme.mrtDTTheme: kAppWhite,
    WidgetTheme.mrtEWTheme: kAppWhite,
    WidgetTheme.mrtNSTheme: kAppWhite,
    WidgetTheme.mrtNETheme: kAppWhite,
    WidgetTheme.mrtCCTheme: kAppWhite,
    WidgetTheme.mrtTETheme: kAppWhite,
    WidgetTheme.lrtBPTheme: kAppWhite,
    WidgetTheme.lrtSETheme: kAppWhite,
    WidgetTheme.lrtSWTheme: kAppWhite,
    WidgetTheme.lrtPETheme: kAppWhite,
    WidgetTheme.lrtPWTheme: kAppWhite,
    WidgetTheme.sentosaExpressTheme: kAppWhite,
    WidgetTheme.busTheme: kAppWhite,
    WidgetTheme.grandShuttleTheme: kAppWhite,
    WidgetTheme.beachShuttleTheme: kAppWhite,
    WidgetTheme.mountFaberTheme: kAppWhite,
    WidgetTheme.walkTheme: kAppGreyA,
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
    WidgetTheme.mrtDTTheme: kAppWhite,
    WidgetTheme.mrtEWTheme: kAppWhite,
    WidgetTheme.mrtNSTheme: kAppWhite,
    WidgetTheme.mrtNETheme: kAppWhite,
    WidgetTheme.mrtCCTheme: kAppWhite,
    WidgetTheme.mrtTETheme: kAppWhite,
    WidgetTheme.lrtBPTheme: kAppWhite,
    WidgetTheme.lrtSETheme: kAppWhite,
    WidgetTheme.lrtSWTheme: kAppWhite,
    WidgetTheme.lrtPETheme: kAppWhite,
    WidgetTheme.lrtPWTheme: kAppWhite,
    WidgetTheme.sentosaExpressTheme: kAppWhite,
    WidgetTheme.busTheme: kAppWhite,
    WidgetTheme.grandShuttleTheme: kAppWhite,
    WidgetTheme.beachShuttleTheme: kAppWhite,
    WidgetTheme.mountFaberTheme: kAppWhite,
    WidgetTheme.walkTheme: kAppGreyA,
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
    WidgetTheme.walkTheme: kAppWhite,
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
    WidgetTheme.mrtDTTheme: ShadowStrokeType.none,
    WidgetTheme.mrtEWTheme: ShadowStrokeType.none,
    WidgetTheme.mrtNSTheme: ShadowStrokeType.none,
    WidgetTheme.mrtNETheme: ShadowStrokeType.none,
    WidgetTheme.mrtCCTheme: ShadowStrokeType.none,
    WidgetTheme.mrtTETheme: ShadowStrokeType.none,
    WidgetTheme.lrtBPTheme: ShadowStrokeType.none,
    WidgetTheme.lrtSETheme: ShadowStrokeType.none,
    WidgetTheme.lrtSWTheme: ShadowStrokeType.none,
    WidgetTheme.lrtPETheme: ShadowStrokeType.none,
    WidgetTheme.lrtPWTheme: ShadowStrokeType.none,
    WidgetTheme.sentosaExpressTheme: ShadowStrokeType.none,
    WidgetTheme.busTheme: ShadowStrokeType.none,
    WidgetTheme.grandShuttleTheme: ShadowStrokeType.none,
    WidgetTheme.beachShuttleTheme: ShadowStrokeType.none,
    WidgetTheme.mountFaberTheme: ShadowStrokeType.none,
    WidgetTheme.walkTheme: ShadowStrokeType.stroke2px,
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
    WidgetTheme.mrtDTTheme: kAppWhite,
    WidgetTheme.mrtEWTheme: kAppWhite,
    WidgetTheme.mrtNSTheme: kAppWhite,
    WidgetTheme.mrtNETheme: kAppWhite,
    WidgetTheme.mrtCCTheme: kAppWhite,
    WidgetTheme.mrtTETheme: kAppWhite,
    WidgetTheme.lrtBPTheme: kAppWhite,
    WidgetTheme.lrtSETheme: kAppWhite,
    WidgetTheme.lrtSWTheme: kAppWhite,
    WidgetTheme.lrtPETheme: kAppWhite,
    WidgetTheme.lrtPWTheme: kAppWhite,
    WidgetTheme.sentosaExpressTheme: kAppWhite,
    WidgetTheme.busTheme: kAppWhite,
    WidgetTheme.grandShuttleTheme: kAppWhite,
    WidgetTheme.beachShuttleTheme: kAppWhite,
    WidgetTheme.mountFaberTheme: kAppWhite,
    WidgetTheme.walkTheme: kAppGreyA,
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
    WidgetTheme.mrtDTTheme: kAppGreyD,
    WidgetTheme.mrtEWTheme: kAppGreyD,
    WidgetTheme.mrtNSTheme: kAppGreyD,
    WidgetTheme.mrtNETheme: kAppGreyD,
    WidgetTheme.mrtCCTheme: kAppGreyD,
    WidgetTheme.mrtTETheme: kAppGreyD,
    WidgetTheme.lrtBPTheme: kAppGreyD,
    WidgetTheme.lrtSETheme: kAppGreyD,
    WidgetTheme.lrtSWTheme: kAppGreyD,
    WidgetTheme.lrtPETheme: kAppGreyD,
    WidgetTheme.lrtPWTheme: kAppGreyD,
    WidgetTheme.sentosaExpressTheme: kAppGreyD,
    WidgetTheme.busTheme: kAppGreyD,
    WidgetTheme.grandShuttleTheme: kAppGreyD,
    WidgetTheme.beachShuttleTheme: kAppGreyD,
    WidgetTheme.mountFaberTheme: kAppGreyD,
    WidgetTheme.walkTheme: kAppGreyD,
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
    WidgetTheme.mrtDTTheme: kAppWhite,
    WidgetTheme.mrtEWTheme: kAppWhite,
    WidgetTheme.mrtNSTheme: kAppWhite,
    WidgetTheme.mrtNETheme: kAppWhite,
    WidgetTheme.mrtCCTheme: kAppWhite,
    WidgetTheme.mrtTETheme: kAppWhite,
    WidgetTheme.lrtBPTheme: kAppWhite,
    WidgetTheme.lrtSETheme: kAppWhite,
    WidgetTheme.lrtSWTheme: kAppWhite,
    WidgetTheme.lrtPETheme: kAppWhite,
    WidgetTheme.lrtPWTheme: kAppWhite,
    WidgetTheme.sentosaExpressTheme: kAppWhite,
    WidgetTheme.busTheme: kAppWhite,
    WidgetTheme.grandShuttleTheme: kAppWhite,
    WidgetTheme.beachShuttleTheme: kAppWhite,
    WidgetTheme.mountFaberTheme: kAppWhite,
    WidgetTheme.walkTheme: kAppWhite,
    WidgetTheme.custom: kAppWhite,
    WidgetTheme.tealWhite: kAppWhite,
    WidgetTheme.secondaryTealWhite: kAppWhite,
    WidgetTheme.greyAWhite: kAppWhite,
    WidgetTheme.pinkBlack: kAppWhite,
    WidgetTheme.blackPink: kAppWhite,
    WidgetTheme.secondaryTeal: kAppWhite,
  };

  Color get disabledTextColor => disabledTextColors[this];

  //// --------- For Pin (Map Marker)

  ///
  /// This attribute is only for [ZMarker] pin
  /// return pin image resource
  String get pinImage {
    switch (this) {
      case WidgetTheme.blueWhite:
        return 'assets/icons/pins/pin_shape_blue.png';
      case WidgetTheme.whiteBlue:
      case WidgetTheme.whiteBlack:
      case WidgetTheme.whiteRed:
      case WidgetTheme.whiteFriendlyRed:

      /// MRT Theme
      case WidgetTheme.mrtDTTheme:
      case WidgetTheme.mrtEWTheme:
      case WidgetTheme.mrtNSTheme:
      case WidgetTheme.mrtNETheme:
      case WidgetTheme.mrtTETheme:
      case WidgetTheme.mrtCCTheme:

      /// LRT Theme
      case WidgetTheme.lrtBPTheme:
      case WidgetTheme.lrtSETheme:
      case WidgetTheme.lrtSWTheme:
      case WidgetTheme.lrtPETheme:
      case WidgetTheme.lrtPWTheme:

      /// Tram
      case WidgetTheme.sentosaExpressTheme:

      /// Bus
      case WidgetTheme.busTheme:
      case WidgetTheme.grandShuttleTheme:
      case WidgetTheme.beachShuttleTheme:
      case WidgetTheme.mountFaberTheme:
        return 'assets/icons/pins/pin_shape_white.png';

      /// undefined
      default:
        return 'assets/icons/pins/pin_shape_white.png';
    }
  }

  ///
  ///
  /// pin icon colors
  Color get pinForegroundColor {
    switch (this) {
      case WidgetTheme.blueWhite:
        return kAppWhite;
      case WidgetTheme.whiteBlue:
        return kAppPrimaryElectricBlue;
      case WidgetTheme.whiteBlack:
        return kAppBlack;
      case WidgetTheme.custom:
        return null;
      case WidgetTheme.tealWhite:
        return kAppFriendlyTeal;
      case WidgetTheme.secondaryTealWhite:
        return kAppSecondaryTeal;
      case WidgetTheme.greyAWhite:
        return kAppGreyA;
      case WidgetTheme.secondaryTeal:
        return kAppSecondaryTeal;
      default:
        return kAppBlack;
    }
  }
}
