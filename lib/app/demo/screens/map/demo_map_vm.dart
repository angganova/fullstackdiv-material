// import 'package:injectable/injectable.dart';
// import 'package:latlong/latlong.dart';
// import 'package:mobx/mobx.dart';
// import 'package:zest/data/model/location.dart';
// import 'package:zest/data/model/moovit/itinerary.dart';
// import 'package:zest/data/view_model/location_vm.dart';
// import 'package:zest/data/repository/moovit_repository.dart';
// import 'package:zest/demo/screens/map/demo_map_page.dart';
// import 'package:zest/demo/screens/map/demo_pick_location_page.dart';
// import 'package:zest/system/di/dependency_index.dart';
// import 'package:zest/system/utils/map_utils.dart';
//
// part 'demo_map_vm.g.dart';
//
// enum GetRouteState { initial, loading, loaded }
// enum LocationState { initial, loading, loaded }
//
// @Injectable()
// class DemoMapViewModel = _DemoMapViewModel with _$DemoMapViewModel;
//
// /// A shared ViewModel Class for [DemoMapPage] and [DemoPickLocationPage]
// abstract class _DemoMapViewModel with Store {
//   _DemoMapViewModel(this._moovitRepository);
//
//   final MoovItRepository _moovitRepository;
//   final LocationViewModel _locationViewModel = getIt<LocationViewModel>();
//
//   @observable
//   double currentLat;
//
//   @observable
//   double currentLng;
//
//   @observable
//   double centerLat;
//
//   @observable
//   double centerLng;
//
//   @observable
//   String encodedRoute;
//
//   @observable
//   bool routeDrawn = false;
//
//   @observable
//   bool isCurveRoute = false;
//
//   @observable
//   bool isDottedRoute = false;
//
//   @observable
//   GetRouteState getRouteState = GetRouteState.initial;
//
//   @observable
//   LocationState locationState = LocationState.initial;
//
//   @observable
//   ObservableList<LatLng> routePoints = ObservableList<LatLng>();
//
//   @observable
//   ObservableList<LatLng> pinLocations = ObservableList<LatLng>();
//
//   @action
//   void fetchSuggestedRoutes(
//       {Location origin, Location destination, int timeType}) {
//     clearRoute();
//
//     getRouteState = GetRouteState.loading;
//     _moovitRepository
//         .fetchRoute(origin.latitude, origin.longitude, destination.latitude,
//             destination.longitude, timeType)
//         .then((Itinerary itinerary) {
//       print('ItineraryID; ${itinerary.itineraryId}');
//       fetchItineraryDetails(itinerary.itineraryId);
//     });
//   }
//
//   @action
//   void fetchItineraryDetails(String itineraryId) {
//     getRouteState = GetRouteState.loading;
//     _moovitRepository
//         .fetchItineraryDetail(itineraryId)
//         .then((Itinerary itinerary) {
//       if (itinerary.legs.isNotEmpty) {
//         encodedRoute = itinerary.legs.first.shape;
//         if (encodedRoute != null) {
//           findRoutePolyline();
//         }
//       }
//     });
//   }
//
//   @action
//   void findRoutePolyline() {
//     getRouteState = GetRouteState.loading;
//     final List<LatLng> points = MapUtils.encodedRouteToLocationList(encodedRoute)
//         .toList();
//     routePoints.clear();
//     routePoints.addAll(points);
//     routeDrawn = true;
//     getRouteState = GetRouteState.loaded;
//   }
//
//   @action
//   void fetchLocation() {
//     locationState = LocationState.loading;
//     _locationViewModel.getCurrentLocation().then((Location location) {
//       currentLat = location.latitude;
//       currentLng = location.longitude;
//       locationState = LocationState.loaded;
//     });
//   }
//
//   @action
//   void addPinLocation(double latitude, double longitude) {
//     pinLocations.add(LatLng(latitude, longitude));
//   }
//
//   @action
//   void updateCenterLocation(double latitude, double longitude) {
//     centerLat = latitude;
//     centerLng = longitude;
//   }
//
//   @action
//   void clearRoute() {
//     routePoints.clear();
//     routeDrawn = false;
//   }
//
//   @action
//   void setCurveRoute(bool curveRoute) {
//     isCurveRoute = curveRoute;
//   }
//
//   @action
//   void setDottedRoute(bool dottedRoute) {
//     isDottedRoute = dottedRoute;
//   }
// }
