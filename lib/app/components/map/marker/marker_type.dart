import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// All Possible marker type
enum MarkerType {
  origin,
  destination,
  available_taxi,
  ongoing_taxi,
  taxi,

  // start: public transportation
  train,
  tram,
  bus,
  rail,
  ferry,
  cable_car,
  gondola,
  funicular,
  // end: public transportation

  restaurant,
  stop,
  marketplace,
  undefined,
  svg,

  group
}

extension MarkerTypeExtension on MarkerType {
  /// Get image asset reference based on current marker type
  /// Only for Marker with built from image asset
  String get image {
    switch (this) {
      case MarkerType.origin:
        return 'assets/icons/pins/pin_origin.png';
      case MarkerType.destination:
        return 'assets/icons/pins/pin_destination.png';
      case MarkerType.available_taxi:
        return 'assets/icons/pins/pin_ongoing_taxi.png';
      case MarkerType.ongoing_taxi:
        return 'assets/icons/pins/pin_ongoing_taxi.png';
      default:
        return '';
    }
  }

  /// Get icon based on current marker type
  /// Only for Marker with built from icon
  IconData get icon {
    switch (this) {
      default:
        return null;
    }
  }

  WidgetTheme get theme {
    switch (this) {
      case MarkerType.origin:
        return WidgetTheme.blueWhite;

      case MarkerType.destination:
      case MarkerType.train:
      case MarkerType.tram:
      case MarkerType.bus:
      case MarkerType.gondola:
      case MarkerType.funicular:
      case MarkerType.rail:
      case MarkerType.ferry:
      case MarkerType.cable_car:
      case MarkerType.restaurant:
      default:
        return WidgetTheme.whiteBlue;
    }
  }
}
