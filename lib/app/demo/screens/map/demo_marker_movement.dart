// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mobx/mobx.dart';
// import 'package:zest/data/model/location.dart';
// import 'package:zest/data/model/mapbox/driving_route.dart';
// import 'package:zest/data/view_model/location_vm.dart';
// import 'package:zest/demo/screens/map/demo_marker_movement_vm.dart';
// import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
// import 'package:fullstackdiv_material/app/components/button/small_button.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/zmarker_stop.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/zmarker_taxi.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap_controller.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
// import 'package:zest/system/di/index.dart';
// import 'package:fullstackdiv_material/system/global_styles.dart';
//
// class DemoMarkerMovement extends StatefulWidget {
//   @override
//   _DemoMarkerMovementState createState() => _DemoMarkerMovementState();
// }
//
// class _DemoMarkerMovementState extends State<DemoMarkerMovement> {
//   ZMapController mapController = ZMapController();
//   final DemoMarkerMovementViewModel _vm = getIt<DemoMarkerMovementViewModel>();
//   final LocationViewModel _locationViewModel = getIt<LocationViewModel>();
//
//   ReactionDisposer routeDisposer;
//   Timer movementSimulationTimer;
//   bool stopMarkerAnimation = false;
//   bool firsLoad = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _fetchRoute();
//
//     routeDisposer =
//         reaction((_) => _vm.drivingRoute, (List<DrivingRoute> routes) {
//       if (routes != null && routes.isNotEmpty) {
//         if (firsLoad) {
//           firsLoad = false;
//           mapController.fitBounds(
//             locations: _vm.polylinePoints,
//             mapWidth: AppQuery(context).width - 100,
//             mapHeight: _mapHeight,
//           );
//         }
//       }
//     });
//   }
//
//   Future<void> _fetchRoute() async {
//     _vm.userLocation ??= await _locationViewModel.getCurrentLocation();
//     _vm.fetchDrivingRoute(_vm.taxiPosition, _vm.userLocation);
//   }
//
//   @override
//   void dispose() {
//     routeDisposer();
//     movementSimulationTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Observer(
//       builder: (_) {
//         return Stack(
//           children: <Widget>[
//             _map,
//             SafeArea(
//               child: Stack(
//                 children: <Widget>[
//                   _simulationOptionCheckbox,
//                   if (!_vm.realTaxiSimulation) _moveButton,
//                   _backButton,
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     ));
//   }
//
//   Widget get _map {
//     return ZMap(
//       mapController: mapController,
//       showUserLocation: true,
//       mapHeight: _mapHeight,
//       polyline: _vm.polyline,
//       taxiMarkers: _taxiMarkers,
//       stopMarkers: _stopMarkers,
//       userConfirmedLocationMarkers: _pinTaxiMarker,
//       onMapTapped: (Location newLocation) async {
//         if (_vm.realTaxiSimulation) {
//           final double bearing =
//               _vm.computeBearing(_vm.taxiPosition, newLocation);
//           print('bearing: $bearing');
//           final Location loc = Location(
//               newLocation.latitude, newLocation.longitude,
//               heading: bearing);
//           _moveMarkerTo(loc);
//         }
//       },
//       onLocationUpdate: (Location location) {
//         _vm.userLocation = location;
//       },
//     );
//   }
//
//   double get _mapHeight => AppQuery(context).height;
//
//   List<ZMarkerTaxi> get _taxiMarkers {
//     return <ZMarkerTaxi>[
//       ZMarkerTaxi(_vm.taxiPosition,
//           markerType: MarkerType.ongoing_taxi,
//           angle: _vm.bearing),
//     ];
//   }
//
//   List<ZMarker> get _pinTaxiMarker {
//     if (_vm.pinnedTaxiLocation != null) {
//       return <ZMarker>[
//         ZMarker(
//           _vm.pinnedTaxiLocation,
//           markerType: MarkerType.origin,
//         )
//       ];
//     }
//     return <ZMarker>[];
//   }
//
//   List<ZMarkerStop> get _stopMarkers {
//     if (_vm.polylinePoints.isNotEmpty) {
//       return <ZMarkerStop>[
//         ZMarkerStop(_vm.polylinePoints.first, color: kAppBlack),
//         ZMarkerStop(_vm.polylinePoints.last, color: kAppBlack),
//       ];
//     } else {
//       return <ZMarkerStop>[];
//     }
//   }
//
//   Widget get _moveButton => Align(
//         alignment: Alignment.topRight,
//         child: Padding(
//           padding: kSpacer.edgeInsets.all.sm,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               SmallButton(
//                 title: 'Animate Taxi',
//                 onPressed: () async {
//                   _vm.taxiPosition = _vm.taxiOrigin;
//                   _vm.locationIndex = 0;
//                   mapController.move(_vm.taxiPosition,
//                       destZoom: kDefaultMapZoom, afterMoved: () {
//                         simulateTaxiMovement();
//                   });
//                 },
//                 widgetTheme: WidgetTheme.blueWhite,
//               ),
//             ],
//           ),
//         ),
//       );
//
//   Widget get _backButton => Align(
//         alignment: Alignment.topLeft,
//         child: Padding(
//           padding: const EdgeInsets.all(kDefaultMargin),
//           child: CustomIconButton(
//             icon: Icons.back,
//             widgetTheme: WidgetTheme.whiteBlack,
//             shadowStrokeType: ShadowStrokeType.lowShadow,
//             iconSize: kSpacer.sm,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             padding: const EdgeInsets.all(kDefaultSmallMargin),
//           ),
//         ),
//       );
//
//   Widget get _simulationOptionCheckbox {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         padding: kSpacer.edgeInsets.symmetric(x: 'md'),
//         color: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             if (_vm.realTaxiSimulation)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Text(
//                   'For real taxi position simulation, tap any position in the map to update new taxi position',
//                   textAlign: TextAlign.center,
//                   style: AppTextStyle(color: kAppBlack).primaryP,
//                 ),
//               ),
//             Row(
//               children: <Widget>[
//                 Switch(
//                   value: _vm.realTaxiSimulation,
//                   onChanged: (bool value) {
//                     stopMarkerAnimation = true;
//                     _vm.realTaxiSimulation = value;
//                   },
//                   activeTrackColor: kAppPrimaryBrightBlue,
//                   activeColor: kAppPrimaryElectricBlue,
//                 ),
//                 Text(
//                   'Real Time Simulation',
//                   style: AppTextStyle(color: kAppBlack).primaryPL,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// to simulate taxi movement that exactly following mapbox navigation route
//   /// (the taxi location will be picked from route points)
//   void simulateTaxiMovement() {
//     movementSimulationTimer = Timer.periodic(const Duration(milliseconds: 4000), (Timer timer) {
//       if (stopMarkerAnimation) {
//         timer.cancel();
//         return;
//       }
//
//       if (_vm.locationIndex == _vm.polylinePoints.length - 1) {
//         timer.cancel();
//       } else {
//         final Location newPosition = _vm.polylinePoints[_vm.locationIndex + 1];
//         mapController.moveMarker(_taxiMarkers.first, newPosition,
//             duration: const Duration(milliseconds: 2000),
//             onMoveMarker: (Location location) {
//           /// update bearing
//           if (_vm.taxiPosition != null && !location.equals(_vm.taxiPosition)) {
//             _vm.bearing = _vm.computeBearing(_vm.taxiPosition, location);
//           }
//
//           // update position
//           _vm.taxiPosition = location;
//
//           // update index for getting next position
//           if (_vm.taxiPosition
//               .equals(_vm.polylinePoints[_vm.locationIndex + 1])) {
//             _vm.locationIndex++;
//           }
//         });
//       }
//     });
//   }
//
//   /// To move marker from previous location to new location
//   /// Only used for real taxi simulation
//   void _moveMarkerTo(Location newLocation) {
//     mapController.moveMarker(_taxiMarkers.first, newLocation,
//         duration: const Duration(milliseconds: 2000),
//         onMoveMarker: (Location location) async {
//       /// update bearing
//       double bearing = 0;
//       if (_vm.taxiPosition != null && !location.equals(_vm.taxiPosition)) {
//         bearing = _vm.computeBearing(_vm.taxiPosition, location);
//         _vm.bearing = bearing;
//       }
//
//       final Location newLocationWithBearing = Location(location.latitude, location.longitude, heading: bearing);
//
//       // update position
//       _vm.taxiPosition = newLocationWithBearing;
//
//       // update route after taxi moved to clear previous route
//       if (_vm.taxiPosition.equals(newLocation)) {
//         _vm.userLocation ??= await _locationViewModel.getCurrentLocation();
//         _vm.fetchDrivingRoute(_vm.taxiPosition, _vm.userLocation);
//       }
//     });
//   }
// }
