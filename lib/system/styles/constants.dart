import 'package:flutter/cupertino.dart';

/// for screen sizes
/// store the breakpoints for dynamic padding and texts
const double kSmallScreenWidth = 350;
const double kMedScreenHeight = 700;

/// this is the list of default value(s)
///
///
/// for [BorderRadius]
const double kBorderRadiusExtraTiny = 8.0;
const double kBorderRadiusTiny = 12.0;
const double kBorderRadiusExtraSmall = 16.0;
const double kBorderRadiusSmall = 24.0;
const double kBorderRadiusMed = 32.0;

/// for Margins
/// store here the values that you can't find in [dimensions.dart]
const double kDefaultMargin = 24.0;
const double kSecondaryMargin = 20.0;
const double kDefaultMediumMargin = 18.0;
const double kDefaultSmallMargin = 12.0;
const double kDefaultTinyMargin = 10.0;

/// for [Divider]
/// I recommend you to use [ZDivider] for [Divider]
const double kDefaultDividerSize = 2.0;

/// for carousel used in deal and F&B
const double kCarouselDotSize = 7.0;
const double kCarouselDotRadius = 8.0;
const double kCarouselDotSpacing = 5.0;
const double kCarouselDotActiveStrokeWidth = 2.8;

/// for icon's size
const double kExtraTinyIconSize = 8.0;
const double kSubIconSize = 10.0;
const double kTinyIconSize = 12.0;
const double kSmallIconSize = 16.0;
const double kPinIconSize = 20.0;
const double kDefaultIconSize = 24.0;
const double kMedIconSize = 32.0;
const double kMedTappableArea = 40.0;
const double kStandardTappableArea = 44.0;
const double kBigIconSize = 52;

/// for drawer
const double kHomeDrawerTop = 200.0;
const double kDefaultDrawerTop = 191.0;
const double kSecondaryDrawerTop = 110.0;
const double kTertiaryDrawerTop = 60.0;
const double kExploreDrawerTop = 80.0;
const double kDefaultMinHeight = 260.0;
const double kSecondaryMinHeight = 320.0;
const double kTertiaryMinHeight = 360.0;
const Offset kStartOffsetY = Offset(0.0, 1.0);
const Offset kEndOffsetY = Offset(0.0, 0.0);
const Offset kStartOffsetX = Offset(1.0, 0.0);
const Offset kEndOffsetX = Offset(0.0, 0.0);
const double kMarketPlaceHeaderHeight = 240;
const double kDefaultCarouselAspectRatio = 2.5;

/// for overlay box
const double kDefaultOverlayHeight = 100.0;
const double kDefaultOverlayWidth = 20.0;
const Alignment kVerticalBeginAlignment = Alignment(0.0, -1.0);
const Alignment kVerticalEndAlignment = Alignment(0.0, 0.2);
const Alignment kHorizontalBeginAlignment = Alignment(-1.0, 0.0);
const Alignment kHorizontalEndAlignment = Alignment(0.2, 0.0);
const double kMarketPlaceOverlay = 0.16;

/// for map
const double kPinSize = 60.0;
const double kCusterPinWidth = 80.0;
const double kCusterPinBadgeSize = 27.0;
const double kDefaultMapZoom = 13.3;
const double kSecondaryMapZoom = 15.0;
const double kPinLocationMapZoom = 15.0;
const double kMaxMapZoom =
    18.4; // set value greater than this will make map blank
const double kMinMapZoom = 10; // can be re-adjusted later
const double kPolylineStopPinSize = 16;
const double kPolylineSubsidiaryStopPinSize = 10;
const double kDefaultPolylineHeight = 4.0;
const double kDefaultPinBottomMargin = 12.0;
const int kDisableClusteringZoomLevel =
    16; // map zoom level to disable clustering
const int kMaxClusterRadius = 100; // distance between marker in pixel

/// for rating
const double kRatingItemSize = 56.0;

/// for routes
const double kDashedLength = 3.34;
const double kRouteMarginHorizontal = 22.0;
const double kDashMarginLeft = (32 - 3.34) / 2;

/// for search
const double kImageSearchSize = 56.0;

// for gradient
const double kMinGradientShow = 20.0;

///
///
///
///
/// this is the string constants
const String placeholderString =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
const String placeholderAssetImage = 'assets/demo/flutter_logo.png';

/// for user profile options
const double kUserProfileOptionCardWidth = 120.0;
const double kUserProfileOptionCardHeight = 140.0;

/// for booking
const double kButtonNumberOfPeopleSize = 38.0;

/// calendar
const double kCalendarHeight = 460.0;
const double kCalendarSmallHeight = 380.0;
const double kBorderDayWidth = 2.0;
const double kTimeLineDayWidth = 72.0;
const double kTimeLineDayHeight = 64.0;

// Marketplace images to be stored in cache storage
const int cacheMaxHeightImage = 1024;

// CTC Marketplace
const double kSmallHeightImageFoodDetail = 300.0;
const double kHeightImageFoodDetail = 388.0;
const double kCollapsedHeight = 96.0;
const double kPreferredSize = 60.0;
const double kHideBadgeDiscount = 200.0;
const double kHeightHeaderOrderSummary = 175.0;
