import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:latlong/latlong.dart';

extension LatLngExtension on LatLng {
  Location toLocation() {
    return Location(latitude, longitude);
  }
}
