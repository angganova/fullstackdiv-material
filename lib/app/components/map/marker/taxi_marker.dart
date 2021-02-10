import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/map/marker/image_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/live_location_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker_taxi.dart';
import 'package:fullstackdiv_material/app/components/map/marker_helper.dart';

class TaxiMarker extends StatelessWidget {
  const TaxiMarker({this.markerTaxi});

  final ZMarkerTaxi markerTaxi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: markerTaxi.showUserLocation,
          child: const LiveLocationMarker(radius: kUserLocationRadius),
        ),
        ImageMarker(
          image: markerTaxi.markerType.image,
          angle: markerTaxi.angle,
          edgeInsets: markerTaxi.edgeInsets,
        )
      ],
    );
  }
}
