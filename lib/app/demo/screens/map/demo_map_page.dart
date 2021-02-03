// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:latlong/latlong.dart';
// import 'package:mobx/mobx.dart';
// import 'package:zest/config/environments.dart';
// import 'package:zest/data/model/location.dart';
// import 'package:zest/demo/screens/map/demo_map_vm.dart';
// import 'package:zest/demo/screens/map/demo_pick_location_page.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap_controller.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
// import 'package:fullstackdiv_material/app/components/button/small_button.dart';
// import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
// import 'package:fullstackdiv_material/app/components/map/loading_indicator/map_loading_indicator.dart';
// import 'package:zest/system/utils/extensions/extensions.dart';
// import 'package:fullstackdiv_material/app/components/map/polyline/zpolyline.dart';
// import 'package:zest/system/di/index.dart';
// import 'package:zest/system/utils/constants.dart';
// import 'package:fullstackdiv_material/system/global_styles.dart';
// import 'package:zest/system/utils/map_utils.dart';
//
// /// Just example of center point for initial position (as postman example)
// LatLng kPoint1 = LatLng(1.3702218, 103.8652942);
// LatLng kPoint2 = LatLng(1.299187, 103.8437073);
//
// const double pinSize = 50;
//
// /// can be 2 * [pinSize]
// const double pinBoundarySize = 100;
//
// class DemoMapPage extends StatefulWidget {
//   @override
//   _DemoMapPageState createState() => _DemoMapPageState();
// }
//
// class _DemoMapPageState extends State<DemoMapPage>
//     with TickerProviderStateMixin {
//   /// Just for example
//   /// We need to specify any initial point for the map to focus on
//   /// because on the first load, we can't guarantee to immediately get current location
//   final Location _initialPosition = Location(initialLatitude, initialLongitude);
//
//   /// map box api token
//   String mapBoxToken;
//
//   /// Map template url using Mapbox
//   String mapBoxUrl;
//
//   /// list of disposers
//   /// make sure to dispose all disposer on [dispose]
//   List<ReactionDisposer> _disposers;
//
//   final DemoMapViewModel _viewModel = getIt<DemoMapViewModel>();
//
//   final ZMapController _mapController = ZMapController();
//
//   @override
//   void initState() {
//     mapBoxToken = getIt<Environments>().mapBoxToken;
//     mapBoxUrl = '$mapBoxUrlTemplate?access_token=$mapBoxToken';
//
//     _viewModel.fetchLocation();
//     _listenForStates();
//     super.initState();
//   }
//
//   /// Make sure to release all resources on dispose
//   @override
//   void dispose() {
//     for (final ReactionDisposer d in _disposers) {
//       d();
//     }
//     super.dispose();
//   }
//
//   /// Listen for all state changes from vm
//   void _listenForStates() {
//     _disposers = <ReactionDisposer>[
//       /// focus map to origin point
//       reaction((_) => _viewModel.routeDrawn, (bool value) {
//         if (value) {
//           final List<Location> locations = <Location>[
//             _viewModel.routePoints.first.toLocation(),
//             _viewModel.routePoints.last.toLocation(),
//           ];
//
//           _mapController.fitBounds(
//             locations: locations,
//             mapHeight: AppQuery(context).height,
//             mapWidth: AppQuery(context).width,
//           );
//         }
//       }),
//
//       /// focus map to current location
//       reaction((_) => _viewModel.locationState, (LocationState value) {
//         if (value == LocationState.loaded) {
//           _mapController.move(
//               Location(_viewModel.currentLat, _viewModel.currentLng),
//               destZoom: kDefaultMapZoom);
//
//           /// once location fetched, map center position = current position
//           /// So, just update current lat lng value
//           _viewModel.updateCenterLocation(
//               _viewModel.currentLat, _viewModel.currentLng);
//         }
//       }),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Observer(
//           builder: (_) {
//             return Column(
//               children: <Widget>[
//                 BasicHeader(
//                   title: 'Map Example',
//                   onBackButtonTapped: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 Expanded(
//                     child: Stack(
//                   children: <Widget>[
//                     _buildMap(),
//                     _buildActionButtons(),
//                     if (_viewModel.routeDrawn) _buildRouteStyleOption(),
//                     if (_viewModel.getRouteState == GetRouteState.loading)
//                       Align(
//                         alignment: Alignment.center,
//                         child: MapLoadingIndicator(),
//                       )
//                   ],
//                 )),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   List<ZMarker> get _markers {
//     if (_viewModel.getRouteState == GetRouteState.loading) {
//       /// when showing loading indicator, hide all marker
//       /// adjust this based on your implementation
//       return <ZMarker>[];
//     } else {
//       if (_viewModel.routeDrawn) {
//         /// if route drawn then there will be 2 markers (origin and destination)
//         return _originDestinationMarkers;
//       } else if (_viewModel.pinLocations.isNotEmpty) {
//         return _viewModel.pinLocations.map((LatLng e) {
//           return ZMarker(e.toLocation(), markerType: MarkerType.origin);
//         }).toList();
//       }
//     }
//     return <ZMarker>[];
//   }
//
//   List<ZMarker> get _originDestinationMarkers {
//     final ZMarker origin = ZMarker(
//         Location(_viewModel.routePoints.first.latitude,
//             _viewModel.routePoints.first.longitude),
//         markerType: MarkerType.origin);
//     final ZMarker destination = ZMarker(
//         Location(_viewModel.routePoints.last.latitude,
//             _viewModel.routePoints.last.longitude),
//         markerType: MarkerType.destination);
//     return <ZMarker>[origin, destination];
//   }
//
//   ZMap _buildMap() {
//     return ZMap(
//         mapController: _mapController,
//         initialPosition: _initialPosition,
//         initialZoom: kDefaultMapZoom,
//         onLocationUpdate: (Location loc) {},
//         userConfirmedLocationMarkers: _markers,
//         polyline: _polyline,
//         onMapPositionChange: (MapPosition mapPosition, bool hasGesture) {
//           if (hasGesture) {
//             _viewModel.updateCenterLocation(
//                 mapPosition.center.latitude, mapPosition.center.longitude);
//           }
//         });
//   }
//
//   List<ZPolyline> get _polyline {
//     final List<LatLng> routePoints = _viewModel.isCurveRoute
//         ? MapUtils.getPointsOnCurve(
//             _viewModel.routePoints.first, _viewModel.routePoints.last)
//         : _viewModel.routePoints;
//
//     if (_viewModel.routeDrawn) {
//       final List<Location> points = routePoints
//           .toList()
//           .map((LatLng e) => Location(e.latitude, e.longitude))
//           .toList();
//       final ZPolyline polyline = ZPolyline(
//           points: points,
//           lineColor: kAppPrimaryElectricBlue,
//           lineWidth: 6.0,
//           isDotted: _viewModel.isDottedRoute);
//       return <ZPolyline>[polyline];
//     } else {
//       return <ZPolyline>[];
//     }
//   }
//
//   Widget _buildActionButtons() {
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Padding(
//         padding: kSpacer.edgeInsets.all.md,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             /// ---- Add pin button
//             SmallButton(
//               title: 'Add Pin',
//               onPressed: () async {
//                 /// clear drawn route before adding pin
//                 _viewModel.clearRoute();
//
//                 /// Just a simple example to add pin
//                 /// Add pin to center of the map
//                 if (_viewModel.centerLat == null ||
//                     _viewModel.centerLng == null) {
//                   _viewModel.addPinLocation(
//                       kPoint1.latitude, kPoint1.longitude);
//                   _mapController.move(
//                       Location(kPoint1.latitude, kPoint1.longitude),
//                       destZoom: kDefaultMapZoom);
//                 } else {
//                   _viewModel.addPinLocation(
//                       _viewModel.centerLat, _viewModel.centerLng);
//
//                   _mapController.move(
//                       Location(_viewModel.centerLat, _viewModel.centerLng),
//                       destZoom: kDefaultMapZoom);
//                 }
//               },
//               widgetTheme: WidgetTheme.blueWhite,
//             ),
//             SizedBox(
//               height: kSpacer.xxs,
//             ),
//
//             /// ------ Get Location Button
//             if (_viewModel.locationState == LocationState.loading)
//               const Padding(
//                 padding: EdgeInsets.all(6),
//                 child: CircularProgressIndicator(
//                   backgroundColor: kAppPrimaryElectricBlue,
//                 ),
//               )
//             else
//               SmallButton(
//                 title: 'Current Location',
//                 onPressed: () async {
//                   _viewModel.fetchLocation();
//                 },
//                 widgetTheme: WidgetTheme.blueWhite,
//               ),
//
//             /// ----- Get Route Button
//             SizedBox(
//               height: kSpacer.xxs,
//             ),
//             SmallButton(
//               title: 'Get Route',
//               onPressed: () async {
//                 final Location origin = kPoint1.toLocation();
//                 final Location destination = kPoint2.toLocation();
//
//                 _viewModel.clearRoute();
//
//                 _mapController.move(
//                     Location(_viewModel.currentLat, _viewModel.currentLng),
//                     destZoom: 16.0, afterMoved: () {
//                   _viewModel.fetchSuggestedRoutes(
//                       origin: origin, destination: destination, timeType: 2);
//                 });
//               },
//               widgetTheme: WidgetTheme.blueWhite,
//             ),
//
//             SizedBox(
//               height: kSpacer.xxs,
//             ),
//             SmallButton(
//               title: 'Pick Location',
//               onPressed: () async {
//                 final LatLng pickedLocation = await Navigator.push(
//                   context,
//                   MaterialPageRoute<LatLng>(
//                       builder: (_) => DemoPickLocationPage()),
//                 );
//
//                 if (pickedLocation != null) {
//                   _mapController.move(pickedLocation.toLocation(),
//                       destZoom: kDefaultMapZoom);
//
//                   _viewModel.addPinLocation(
//                       pickedLocation.latitude, pickedLocation.longitude);
//                 }
//               },
//               widgetTheme: WidgetTheme.blueWhite,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRouteStyleOption() {
//     return Align(
//       alignment: Alignment.bottomLeft,
//       child: Column(
//         children: <Widget>[
//           CheckboxListTile(
//             title: Text(
//               'Dotted Route',
//               style: AppTextStyle(color: kAppBlack).primaryP2,
//             ),
//             value: _viewModel.isDottedRoute,
//             onChanged: (bool value) {
//               _viewModel.setDottedRoute(value);
//             },
//             checkColor: kAppWhite,
//             activeColor: kAppPrimaryElectricBlue,
//             controlAffinity:
//                 ListTileControlAffinity.leading, //  <-- leading Checkbox
//           ),
//           CheckboxListTile(
//             title: Text(
//               'Curve Route',
//               style: AppTextStyle(color: kAppBlack).primaryP2,
//             ),
//             value: _viewModel.isCurveRoute,
//             onChanged: (bool value) {
//               _viewModel.setCurveRoute(value);
//             },
//             checkColor: kAppWhite,
//             activeColor: kAppPrimaryElectricBlue,
//             controlAffinity:
//                 ListTileControlAffinity.leading, //  <-- leading Checkbox
//           ),
//         ],
//       ),
//     );
//   }
// }
