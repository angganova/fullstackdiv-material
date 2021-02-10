import 'package:flutter/material.dart';

import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';

class ZMarkerTaxi extends ZMarker {
  ZMarkerTaxi(
    Location location, {
    @required MarkerType markerType,
    this.showUserLocation = false,
    double angle,
  }) : super(location, markerType: markerType, angle: angle);

  /// set this value will show user location on taxi marker
  /// use case example: when user on the taxi
  final bool showUserLocation;
}
