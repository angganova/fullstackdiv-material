import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:fullstackdiv_material/app/components/map/marker/cluster_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/icon_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/image_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/live_location_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/app/components/map/marker/stop_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/svg_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/taxi_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/text_marker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker_stop.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker_taxi.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

const double kUserLocationRadius = 40.0; // radius in pixel

/// Function to create multiple type of marker
/// Marker is basically Pin in map
/// [ZMarker] is marker model that have marker information
/// [svgFileName] is where the file located
/// like location, style, etc.
Marker createMarker(ZMarker marker, [String svgFileName]) {
  /// Default anchor position to center
  /// But for some type of marker it will have different anchor point
  AnchorPos<dynamic> anchorPos = AnchorPos.align(AnchorAlign.center);
  Widget child;
  double sidePadding;
  if (marker.edgeInsets == null) {
    sidePadding = 0;
  } else {
    sidePadding = marker.edgeInsets.left +
        marker.edgeInsets.top +
        marker.edgeInsets.right +
        marker.edgeInsets.bottom;
  }
  switch (marker.markerType) {
    // static (png image)
    case MarkerType.origin:
    case MarkerType.destination:
      child = createImageMarker(marker.markerType.image,
          edgeInsets: marker.edgeInsets);
      anchorPos = AnchorPos.align(AnchorAlign.top);
      break;
    case MarkerType.available_taxi:
    case MarkerType.ongoing_taxi:
      child = TaxiMarker(markerTaxi: marker as ZMarkerTaxi);
      anchorPos = AnchorPos.align(AnchorAlign.center);
      break;

    // icon
    case MarkerType.taxi:
    case MarkerType.train:
    case MarkerType.tram:
    case MarkerType.bus:
    case MarkerType.rail:
    case MarkerType.ferry:
    case MarkerType.cable_car:
    case MarkerType.gondola:
    case MarkerType.funicular:
    case MarkerType.restaurant:
      child = createIconMarker(
        marker.markerType.icon,
        theme: marker.theme,
        color: marker.color,
        edgeInsets: marker.edgeInsets,
      );
      anchorPos = AnchorPos.align(AnchorAlign.top);
      break;

    case MarkerType.stop:
      final ZMarkerStop zStopMarker = marker as ZMarkerStop;
      child = StopMarker(
          color: zStopMarker.color,
          borderColor: zStopMarker.borderColor,
          size: zStopMarker.size);
      anchorPos = AnchorPos.align(AnchorAlign.center);
      break;
    case MarkerType.marketplace:
    case MarkerType.svg:
      child = createSvgMarker(svgFileName, marker.theme, marker.highlighted);
      anchorPos = AnchorPos.align(AnchorAlign.top);
      break;
    case MarkerType.group:
      child = createGroupMarker(marker.text, marker.highlighted);
      anchorPos = AnchorPos.align(AnchorAlign.top);
      break;
    case MarkerType.undefined:
      debugPrint('Marker type undefined');
      break;
  }

  return Marker(
    width: kPinSize + sidePadding,
    height: kPinSize + sidePadding,
    point: LatLng(marker.location.latitude, marker.location.longitude),
    anchorPos: anchorPos,
    builder: (BuildContext ctx) => GestureDetector(
      onTap: marker.onTap,
      child: child,
    ),
  );
}

/// Function to create marker from image asset
Widget createImageMarker(String image, {EdgeInsets edgeInsets, double angle}) {
  return ImageMarker(
    image: image,
    edgeInsets: edgeInsets,
    angle: angle,
  );
}

/// Function to create marker from icon
Widget createIconMarker(IconData icon,
    {Color color, WidgetTheme theme, EdgeInsets edgeInsets}) {
  return IconMarker(
      icon: icon, color: color, theme: theme, edgeInsets: edgeInsets);
}

/// Function to create user live (gps) location marker
/// [radius] is radius of glowing circle around center point in pixel
Marker createLiveLocationMarker(ZMarker marker,
    {bool inactive = false, double radius = kUserLocationRadius}) {
  return Marker(
    width: radius * 2,
    height: radius * 2,
    point: LatLng(marker.location.latitude, marker.location.longitude),
    anchorPos: AnchorPos.align(AnchorAlign.center),
    builder: (BuildContext ctx) => LiveLocationMarker(
      radius: radius,
      inactive: inactive,
    ),
  );
}

Widget createClusterMarker(
  int markerCount, {
  Color color,
  EdgeInsets edgeInsets,
  bool highlighted,
}) {
  return ClusterMarker(
    markerCount: markerCount,
    color: color,
    edgeInsets: edgeInsets,
    highlighted: highlighted,
  );
}

// Create marketplace widget svg marker
Widget createSvgMarker(String image, WidgetTheme theme, bool highlighted) {
  return SvgMarker(
    image: image,
    theme: theme,
    highlighted: highlighted,
  );
}

Widget createGroupMarker(String markerCount, bool highlighted) {
  return GroupMarker(
    markerCount: markerCount,
    highlighted: highlighted,
  );
}
