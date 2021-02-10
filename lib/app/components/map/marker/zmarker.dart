import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import '../marker_helper.dart';

/// A map marker model
class ZMarker {
  ZMarker(this.location,
      {@required this.markerType,
      this.color,
      this.theme = WidgetTheme.whiteBlue,
      this.edgeInsets,
      this.angle = 0.0,
      this.svgFileName,
      this.onTap,
      this.text,
      this.highlighted = false});

  /// required
  Location location;
  MarkerType markerType;

  /// for svg marker
  String svgFileName;

  /// for group marker or any kind of marker that use text
  String text;

  /// only applies for icon / shape marker
  ///
  /// if we don't specify color,
  /// [WidgetTheme.backgroundColor] will be applied for
  /// marker foreground icon color
  /// but if we specify [color], it will override [WidgetTheme.backgroundColor]
  WidgetTheme theme;

  /// only applies for icon / shape marker
  /// This color will override [WidgetTheme.backgroundColor]
  ///
  /// We can use this color in case the Color is not provided in [WidgetTheme]
  /// or [WidgetTheme] provides unintended color
  Color color;

  /// Used to adjust marker padding
  EdgeInsets edgeInsets;

  /// callback function when pin tapped
  Function() onTap;

  /// For rotation
  double angle;

  /// Currently applied for marketplace marker
  bool highlighted;

  /// Function to create marker
  Marker build() {
    return createMarker(this, svgFileName);
  }

}
