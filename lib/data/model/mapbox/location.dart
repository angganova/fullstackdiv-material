import 'package:latlong/latlong.dart';

class Location {
  Location(this.latitude, this.longitude, {this.heading, this.accuracy});

  final double latitude;
  final double longitude;

  /// optional
  final double heading;
  final double accuracy;

  bool equals(Location location) {
    if (location == null) {
      return false;
    }
    return latitude == location.latitude && longitude == location.longitude;
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
