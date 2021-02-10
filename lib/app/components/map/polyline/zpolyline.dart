import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:latlong/latlong.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/map/map_utils.dart';

/// A Polyline model
class ZPolyline {
  ZPolyline({
    this.points = const <Location>[],
    this.lineColor = kAppBlack,
    this.lineWidth = 4.0,
    this.isDotted = false,
  });

  /// Factory function to build [ZPolyline] instance using encoded route
  factory ZPolyline.fromEncodedRoute(String encodedRoute,
      {Color lineColor = kAppBlack,
      double lineWidth = 4.0,
      bool isDotted = false}) {
    final List<Location> points =
        MapUtils.encodedRouteToLocationList(encodedRoute)
            .map((LatLng e) => e.toLocation())
            .toList();
    return ZPolyline(
        points: points,
        lineColor: lineColor,
        lineWidth: lineWidth,
        isDotted: isDotted);
  }

  final List<Location> points;
  final Color lineColor;
  final double lineWidth;
  final bool isDotted;

  /// Get first point of polyline
  Location get firstPoint {
    if (points.isNotEmpty) {
      return points.first;
    } else {
      return null;
    }
  }

  /// Get last point of polyline
  Location get lastPoint {
    if (points.isNotEmpty) {
      return points.last;
    } else {
      return null;
    }
  }
}
