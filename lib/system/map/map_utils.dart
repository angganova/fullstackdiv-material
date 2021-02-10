import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: implementation_imports
import 'package:flutter_map/src/core/bounds.dart';
import 'package:latlong/latlong.dart';
import 'package:polyline/polyline.dart' as pl;
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/utils/math_utils.dart';

///
/// Utility class for Flutter map
///
/// Taken from: https://pub.dev/packages/maps_curved_line with a bit modification
class MapUtils {
  // From https://pub.dev/packages/maps_toolkit.
  // Cloned this because the original lib is not compatible with google maps
  static const num earthRadius = 6371009.0;

  /// Returns the distance between two LatLngs, in meters.
  static num computeDistanceBetween(LatLng from, LatLng to) =>
      computeAngleBetween(from, to) * earthRadius;

  /// Returns distance on the unit sphere; the arguments are in radians.
  static num distanceRadians(num lat1, num lng1, num lat2, num lng2) =>
      MathUtil.arcHav(MathUtil.havDistance(lat1, lat2, lng1 - lng2));

  /// Returns the angle between two LatLngs, in radians. This is the same as the
  /// distance on the unit sphere.
  static num computeAngleBetween(LatLng from, LatLng to) => distanceRadians(
      MathUtil.toRadians(from.latitude),
      MathUtil.toRadians(from.longitude),
      MathUtil.toRadians(to.latitude),
      MathUtil.toRadians(to.longitude));

  /// Returns the heading from one LatLng to another LatLng. Headings are
  /// expressed in degrees clockwise from North within the range [-180,180).
  /// @return The heading in degrees clockwise from north.
  static num computeHeading(LatLng from, LatLng to) {
    // http://williams.best.vwh.net/avform.htm#Crs
    final num fromLat = MathUtil.toRadians(from.latitude);
    final num fromLng = MathUtil.toRadians(from.longitude);
    final num toLat = MathUtil.toRadians(to.latitude);
    final num toLng = MathUtil.toRadians(to.longitude);
    final num dLng = toLng - fromLng;
    final num heading = atan2(sin(dLng) * cos(toLat),
        cos(fromLat) * sin(toLat) - sin(fromLat) * cos(toLat) * cos(dLng));

    return MathUtil.wrap(MathUtil.toDegrees(heading), -180, 180);
  }

  /// Returns the LatLng resulting from moving a distance from an origin
  /// in the specified heading (expressed in degrees clockwise from north).
  /// @param from     The LatLng from which to start.
  /// @param distance The distance to travel.
  /// @param heading  The heading in degrees clockwise from north.
  static LatLng computeOffset(LatLng from, num distance, num heading) {
    distance /= earthRadius;
    heading = MathUtil.toRadians(heading);
    // http://williams.best.vwh.net/avform.htm#LL
    final num fromLat = MathUtil.toRadians(from.latitude);
    final num fromLng = MathUtil.toRadians(from.longitude);
    final num cosDistance = cos(distance);
    final num sinDistance = sin(distance);
    final num sinFromLat = sin(fromLat);
    final num cosFromLat = cos(fromLat);
    final num sinLat =
        cosDistance * sinFromLat + sinDistance * cosFromLat * cos(heading);
    final num dLng = atan2(sinDistance * cosFromLat * sin(heading),
        cosDistance - sinFromLat * sinLat);

    return LatLng(MathUtil.toDegrees(asin(sinLat)).toDouble(),
        MathUtil.toDegrees(fromLng + dLng).toDouble());
  }

  static List<LatLng> getPointsOnCurve(
      LatLng startLocation, LatLng endLocation) {
    // https://medium.com/better-programming/curved-lines-on-google-maps-2938bbb15f6a
    final List<LatLng> path = <LatLng>[];
    const double angle = pi / 2;
    // ignore: non_constant_identifier_names
    final double SE =
        computeDistanceBetween(startLocation, endLocation).toDouble();
    // ignore: non_constant_identifier_names
    final double ME = SE / 2.0;
    final double R = ME / sin(angle / 2);
    // ignore: non_constant_identifier_names
    final double MO = R * cos(angle / 2);

    final double heading =
        computeHeading(startLocation, endLocation).toDouble();
    final LatLng mCoordinate = computeOffset(startLocation, ME, heading);

    final double direction =
        (startLocation.longitude - endLocation.longitude > 0) ? -1.0 : 1.0;
    final double angleFromCenter = 90.0 * direction;
    final LatLng oCoordinate =
        computeOffset(mCoordinate, MO, heading + angleFromCenter);

    path.add(endLocation);

    const int num = 100;

    final double initialHeading =
        MapUtils.computeHeading(oCoordinate, endLocation).toDouble();
    const double degree = (180.0 * angle) / pi;

    for (int i = 1; i <= num; i++) {
      final double step = i.toDouble() * (degree / num.toDouble());
      final double heading = (-1.0) * direction;
      final LatLng pointOnCurvedLine = MapUtils.computeOffset(
          oCoordinate, R, initialHeading + heading * step);
      path.add(pointOnCurvedLine);
    }

    path.add(startLocation);



    return path;
  }

  /// Find center of multiple points
  static Future<LatLng> getCenterBound(
      List<LatLng> points, double zoom, EdgeInsets padding) async {
    final CustomPoint<double> paddingTL =
        CustomPoint<double>(padding.left, padding.top);
    final CustomPoint<double> paddingBR =
        CustomPoint<double>(padding.right, padding.bottom);

    final LatLngBounds bounds = LatLngBounds.fromPoints(points);
    final CustomPoint<double> paddingOffset = (paddingBR - paddingTL) / 2;
    final CustomPoint<num> swPoint = latLngToPoint(bounds.southWest, zoom);
    final CustomPoint<num> nePoint = latLngToPoint(bounds.northEast, zoom);
    return pointToLatLng((swPoint + nePoint) / 2 + paddingOffset, zoom);
  }

  /// Compute zoom level of particular location bounds
  static num calculateBoundZoom(LatLngBounds bounds, double mapZoom,
      CustomPoint<num> mapSize, CustomPoint<double> padding,
      {bool inside = false}) {
    final double zoom = mapZoom ?? 0.0;
    const double min = 0.0;
    const double max = kMaxMapZoom;
    final LatLng nw = bounds.northWest;
    final LatLng se = bounds.southEast;
    CustomPoint<num> size = mapSize - padding;

    // Prevent negative size which results in NaN zoom value later on in the calculation
    size = CustomPoint<num>(math.max(0, size.x), math.max(0, size.y));
    final CustomPoint<num> boundsSize =
        Bounds<num>(latLngToPoint(se, zoom), latLngToPoint(nw, zoom)).size;
    final double scaleX = size.x / boundsSize.x;
    final double scaleY = size.y / boundsSize.y;
    final double scale =
        inside ? math.max(scaleX, scaleY) : math.min(scaleX, scaleY);
    final num newZoom = getScaleZoom(scale, zoom);
    return math.max(min, math.min(max, newZoom));
  }

  static CustomPoint<num> latLngToPoint(LatLng location, [double zoom]) {
    return const Epsg3857().latLngToPoint(location, zoom);
  }

  static LatLng pointToLatLng(CustomPoint<num> point, [double zoom]) {
    return const Epsg3857().pointToLatLng(point, zoom);
  }

  static double meterPerPixel(LatLng centerPoint, double zoom){
    /// ground resolution = cos(latitude * π / 180) * earth circumference / map width
    /// earth circumference =  2 * π * 6378137
    /// ground_resolution = (cos(latitude * π / 180) * 2 * π * 6378137) / (256 * 2^zoomLevel)
    ///
    /// Reference:
    /// http://blog.madebylotus.com/blog/creating-static-distance-circles-in-map-box-how-many-miles-are-in-a-pixel
    /// https://medium.com/techtrument/how-many-miles-are-in-a-pixel-a0baf4611fff
    const num earthRadius = 6378137; // in meter
    const num earthCircumference = 2 * math.pi * earthRadius;
    final num mapWidth = 256 *  math.pow(2, zoom);
    final num groundResolution = (math.cos(centerPoint.latitude * math.pi / 180) * earthCircumference) / mapWidth;
    return groundResolution.toDouble();
  }

  static double meterInPixels(LatLng centerPoint, double zoom, double pixel){
    return meterPerPixel(centerPoint, zoom) * pixel;
  }

  static num getScaleZoom(double scale, double fromZoom) {
    return const Epsg3857().zoom(scale * const Epsg3857().scale(fromZoom));
  }

  static LatLng latLngOffset(
      LatLng position, double offsetX, double offsetY, double zoom) {
    final CustomPoint<num> screenPosition =
        const Epsg3857().latLngToPoint(position, zoom);
    final num x = screenPosition.x + offsetX;
    final num y = screenPosition.y + offsetY;
    final CustomPoint<num> point = CustomPoint<num>(x, y);
    return const Epsg3857().pointToLatLng(point, zoom);
  }

  static List<LatLng> computeClosestLatLngToRoute(
      List<LatLng> locationsOutsideRoute, List<LatLng> routePoints) {
    final List<LatLng> result = <LatLng>[];
    for (int i = 0; i < locationsOutsideRoute.length; i++) {
      LatLng closestPoint;
      num closestDistance;
      for (int k = 0; k < routePoints.length; k++) {
        final num distance = MathUtil.findDistanceFromLatLng(
            locationsOutsideRoute[i].latitude,
            locationsOutsideRoute[i].longitude,
            routePoints[k].latitude,
            routePoints[k].longitude);
        if (closestDistance == null || distance < closestDistance) {
          closestDistance = distance;
          closestPoint = routePoints[k];
        }
      }
      result.add(closestPoint);
    }
    return result;
  }

  /// Function to convert latitude-longitude to screen absolute position
  static LatLng getLatLngFromScreenPosition(
      {LatLngBounds bounds, double posX, double posY, double zoom}) {
    final CustomPoint<num> northWestPoint =
        const Epsg3857().latLngToPoint(bounds.southWest, zoom);
    final CustomPoint<num> point =
        CustomPoint<num>(posX + northWestPoint.x, northWestPoint.y - posY);

    return const Epsg3857().pointToLatLng(point, zoom);
  }

  /// Convert encoded route string to list of location
  static List<LatLng> encodedRouteToLocationList(String encodedRoute) {
    final pl.Polyline polyline =
        pl.Polyline.Decode(encodedString: encodedRoute, precision: 5);
    return polyline.decodedCoords
        .map((List<double> locations) => LatLng(locations[0], locations[1]))
        .toList();
  }
}
