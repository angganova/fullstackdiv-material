// import 'package:injectable/injectable.dart';
// import 'package:mobx/mobx.dart';
// import 'package:zest/data/model/location.dart';
// import 'package:zest/data/model/mapbox/driving_route.dart';
// import 'package:zest/data/repository/mapbox_repository.dart';
// import 'package:fullstackdiv_material/app/components/map/polyline/zpolyline.dart';
// import 'package:fullstackdiv_material/system/global_styles.dart';
// import 'package:zest/system/utils/map_utils.dart';
// import 'package:zest/system/utils/extensions/extensions.dart';
//
// part 'demo_marker_movement_vm.g.dart';
//
// @injectable
// class DemoMarkerMovementViewModel = _DemoMarkerMovementViewModel
//     with _$DemoMarkerMovementViewModel;
//
// abstract class _DemoMarkerMovementViewModel with Store {
//   _DemoMarkerMovementViewModel(this._mapboxRepository);
//
//   final MapboxRepository _mapboxRepository;
//
//   Location taxiOrigin = Location(1.377287,103.926466);
//
//   @observable
//   Location taxiPosition = Location(1.377287,103.926466);
//
//   @observable
//   List<DrivingRoute> drivingRoute;
//
//   @observable
//   bool loadingRoute = false;
//
//   @observable
//   String apiError;
//
//   @observable
//   Location userLocation;
//
//   @observable
//   int locationIndex = 0;
//
//   @observable
//   double bearing;
//
//   @observable
//   Location pinnedTaxiLocation;
//
//   @observable
//   bool realTaxiSimulation = false;
//
//   @computed
//   List<ZPolyline> get polyline {
//     if (drivingRoute != null && drivingRoute.isNotEmpty) {
//       return drivingRoute
//           .map((DrivingRoute e) =>
//           ZPolyline.fromEncodedRoute(e.shape, lineColor: kAppBlack))
//           .toList();
//     }else {
//       return <ZPolyline>[];
//     }
//   }
//
//   @computed
//   List<Location> get polylinePoints {
//     if (polyline.isNotEmpty) {
//       final List<Location> points = <Location>[];
//       for (int i=0; i<polyline.length; i++) {
//         for (int k=0; k<polyline[i].points.length; k++) {
//           final double lat = polyline[i].points[k].latitude;
//           final double lng = polyline[i].points[k].longitude;
//           double bearing = 0;
//           if (k > 0) {
//             bearing = computeBearing(polyline[i].points[k-1], polyline[i].points[k]);
//           }
//           final Location location = Location(lat, lng, heading: bearing);
//           points.add(location);
//         }
//       }
//       return points;
//     }else {
//       return <Location>[];
//     }
//   }
//
//   @action
//   Future<void> fetchDrivingRoute(Location origin,  Location destination) async {
//     loadingRoute = true;
//     try {
//       double originHeading = 0.0;
//       if (origin.heading != null) {
//         originHeading = origin.heading.abs();
//       }
//
//       double destinationHeading = 0.0;
//       if (destination.heading != null) {
//         destinationHeading = destination.heading.abs();
//       }
//
//       drivingRoute = await _mapboxRepository.fetchRoute(
//           origin.latitude, origin.longitude, originHeading,
//           destination.latitude, destination.longitude, destinationHeading ?? 0.0);
//     } on Exception catch (e) {
//       apiError = e.toString();
//     }
//     loadingRoute = false;
//   }
//
//   double computeBearing(Location from, Location to) {
//     return MapUtils.computeHeading(from.toLatLng(), to.toLatLng()).toDouble();
//   }
// }
