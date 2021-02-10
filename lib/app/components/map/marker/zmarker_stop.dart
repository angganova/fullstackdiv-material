import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ZMarkerStop extends ZMarker {
  ZMarkerStop(
    Location location, {
    Color color,
    this.borderColor = kAppWhite,
    this.size = kPolylineStopPinSize,
  }) : super(location, markerType: MarkerType.stop, color: color);

  final Color borderColor;
  final double size;
}
