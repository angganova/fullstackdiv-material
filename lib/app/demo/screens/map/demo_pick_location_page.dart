// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:latlong/latlong.dart';
// import 'package:mobx/mobx.dart';
// import 'package:zest/config/environments.dart';
// import 'package:zest/data/model/location.dart';
// import 'package:zest/demo/screens/map/demo_map_vm.dart';
// import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
// import 'package:fullstackdiv_material/app/components/button/small_button.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap_controller.dart';
// import 'package:fullstackdiv_material/app/components/map/polyline/zpolyline.dart';
// import 'package:zest/system/di/index.dart';
// import 'package:zest/system/utils/constants.dart';
// import 'package:fullstackdiv_material/system/global_styles.dart';
//
// class DemoPickLocationPage extends StatefulWidget {
//   @override
//   _DemoPickLocationPageState createState() => _DemoPickLocationPageState();
// }
//
// class _DemoPickLocationPageState extends State<DemoPickLocationPage>
//     with TickerProviderStateMixin {
//   /// Just for example
//   Location initialPoint = Location(1.3283494, 103.7732125);
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
//   final MapController _mapController = MapController();
//
//   @override
//   void initState() {
//     mapBoxToken = getIt<Environments>().mapBoxToken;
//     mapBoxUrl = '$mapBoxUrlTemplate?access_token=$mapBoxToken';
//
//     _listenForStates();
//     //_viewModel.fetchLocation();
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
//   /// Listen for all state changes
//   void _listenForStates() {
//     _disposers = <ReactionDisposer>[
//       /// focus map to current location
//       reaction((_) => _viewModel.locationState, (LocationState value) {
//         if (value == LocationState.loaded) {
//           /// Make map focused to current position
//           _moveMapTo(LatLng(_viewModel.currentLat, _viewModel.currentLng),
//               kDefaultMapZoom);
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
//   List<ZPolyline> get _polyline {
//     if (_viewModel.routeDrawn) {
//       final List<Location> points = _viewModel.routePoints
//           .toList()
//           .map((LatLng e) => Location(e.latitude, e.longitude))
//           .toList();
//       final ZPolyline polyline = ZPolyline(
//           points: points, lineColor: kAppPrimaryElectricBlue, lineWidth: 6.0);
//       return <ZPolyline>[polyline];
//     } else {
//       return <ZPolyline>[];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Observer(
//         builder: (_) {
//           return Stack(children: <Widget>[
//             ZMap(
//                 mapController: ZMapController(),
//                 initialPosition: initialPoint,
//                 initialZoom: kDefaultMapZoom,
//                 onLocationUpdate: (Location loc) {},
//                 polyline: _polyline,
//                 onMapPositionChange:
//                     (MapPosition mapPosition, bool hasGesture) {
//                   if (hasGesture) {
//                     _viewModel.updateCenterLocation(mapPosition.center.latitude,
//                         mapPosition.center.longitude);
//                   }
//                 }),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: kSpacer.edgeInsets.all.md,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(
//                       'Lat: ${_viewModel.centerLat},\nLng: ${_viewModel.centerLng}',
//                       style: AppTextStyle(color: kAppBlack).primaryLabel1,
//                     ),
//                     const Spacer(),
//                     SmallButton(
//                       title: 'Done',
//                       onPressed: () async {
//                         LatLng pickedLocation;
//                         if (_viewModel.centerLat != null &&
//                             _viewModel.centerLng != null) {
//                           pickedLocation = LatLng(
//                               _viewModel.centerLat, _viewModel.centerLng);
//                         }
//                         Navigator.pop(context, pickedLocation);
//                       },
//                       widgetTheme: WidgetTheme.blueWhite,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: kSpacer.edgeInsets.only(top: 'xl', right: 'sm'),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     CustomIconButton(
//                       shadowStrokeType: ShadowStrokeType.lowShadow,
//                       icon: Icons.location,
//                       onPressed: () {
//                         _viewModel.fetchLocation();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             TweenAnimationBuilder<double>(
//               tween: Tween<double>(
//                   begin: 0, end: MediaQuery.of(context).size.height / 2),
//               builder: (BuildContext context, double val, Widget child) {
//                 return Positioned(
//                     top: val,
//                     left: (MediaQuery.of(context).size.width / 2) - 25,
//                     child: Image.asset(
//                       'assets/icons/pins/black_pin.png',
//                       width: 50,
//                       height: 50,
//                     ));
//               },
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeIn,
//             ),
//           ]);
//         },
//       ),
//     );
//   }
//
//   /// Move map to particular location with tween animation
//   void _moveMapTo(LatLng destLocation, double destZoom) {
//     // Create some tweens. These serve to split up the transition from one location to another.
//     // In our case, we want to split the transition be<tween> our current map center and the destination.
//     final Tween<double> _latTween = Tween<double>(
//         begin: _mapController.center.latitude, end: destLocation.latitude);
//     final Tween<double> _lngTween = Tween<double>(
//         begin: _mapController.center.longitude, end: destLocation.longitude);
//     final Tween<double> _zoomTween =
//         Tween<double>(begin: _mapController.zoom, end: destZoom);
//
//     // Create a animation controller that has a duration and a TickerProvider.
//     final AnimationController controller = AnimationController(
//         duration: const Duration(milliseconds: 500), vsync: this);
//     // The animation determines what path the animation will take. You can try different Curves values, although I found
//     // fastOutSlowIn to be my favorite.
//     final Animation<double> animation =
//         CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
//
//     controller.addListener(() {
//       _mapController.move(
//           LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
//           _zoomTween.evaluate(animation));
//     });
//
//     animation.addStatusListener((AnimationStatus status) {
//       if (status == AnimationStatus.completed) {
//         controller.dispose();
//       } else if (status == AnimationStatus.dismissed) {
//         controller.dispose();
//       }
//     });
//
//     controller.forward();
//   }
// }
