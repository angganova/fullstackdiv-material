// import 'dart:async';
// import 'dart:isolate';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:geofencing/geofencing.dart' as gf;
// import 'package:zest/data/model/location.dart';
// import 'package:zest/data/view_model/geofence_vm.dart';
// import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/zmarker_stop.dart';
// import 'package:fullstackdiv_material/app/components/map/polygon/circle_region.dart';
// import 'package:zest/system/utils/extensions/extensions.dart';
// import 'package:latlong/latlong.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap.dart';
// import 'package:fullstackdiv_material/app/components/map/zmap_controller.dart';
// import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
// import 'package:fullstackdiv_material/app/components/map/polyline/zpolyline.dart';
// import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
// import 'package:fullstackdiv_material/system/global_styles.dart';
// import 'package:zest/system/utils/map_utils.dart';
//
// class DemoGeofencingPage extends StatefulWidget {
//   @override
//   _DemoGeofencingPageState createState() => _DemoGeofencingPageState();
// }
//
// class _DemoGeofencingPageState extends State<DemoGeofencingPage> {
//   static const double _geofencingRadius = 100.0;
//   static const String _geofencingSendPort = 'geofence_isolate_demo';
//
//   ZMapController mapController = ZMapController();
//   String route = r'ikhGsvwxR}SuHtGoQmUqE????hAsV';
//   List<Location> stopPoints = <Location>[];
//
//   ReceivePort port;
//   final List<gf.GeofenceEvent> triggers = <gf.GeofenceEvent>[
//     gf.GeofenceEvent.enter,
//     /*gf.GeofenceEvent.dwell,
//     gf.GeofenceEvent.exit*/
//   ];
//   final gf.AndroidGeofencingSettings androidSettings =
//       gf.AndroidGeofencingSettings(
//     initialTrigger: <gf.GeofenceEvent>[
//       gf.GeofenceEvent.enter,
//       /*gf.GeofenceEvent.exit,
//       gf.GeofenceEvent.dwell*/
//     ],
//     loiteringDelay: 0,
//   );
//
//   @override
//   void dispose() {
//     unRegisterGeofence();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     stopPoints = MapUtils.encodedRouteToLocationList(route)
//         .map((LatLng e) => e.toLocation())
//         .toList();
//
//     _initGeofencing();
//   }
//
//   StreamSubscription<dynamic> geofenceStream;
//
//   Future<void> _initGeofencing() async {
//     /// initialize service
//     await gf.GeofencingManager.initialize();
//
//     /// subscribe Geofencing Service
//     if (IsolateNameServer.lookupPortByName(_geofencingSendPort) != null ) {
//       unsubscribeGeofencing();
//     }
//     final bool result = subscribeGeofencing();
//     if (result) {
//       geofenceStream = port.listen(geofencingEventCallback);
//       print('Success subscribing Geofencing: $result');
//
//       /// Register geofence regions
//       registerGeofence();
//     }else {
//       print('Failed to subscribe Geofencing');
//     }
//   }
//
//   bool subscribeGeofencing(){
//     port = ReceivePort();
//     return IsolateNameServer.registerPortWithName(port.sendPort, _geofencingSendPort);
//   }
//
//   bool unsubscribeGeofencing() {
//     final bool result = IsolateNameServer.removePortNameMapping(_geofencingSendPort);
//     print('Success unsubscribe geofencing: $result');
//     return result;
//   }
//
//   Future<void> registerGeofence() async {
//     for (int i = 0; i < stopPoints.length; i++) {
//       final gf.GeofenceRegion region = gf.GeofenceRegion(
//         'GF-$i',
//         stopPoints[i].latitude,
//         stopPoints[i].longitude,
//         _geofencingRadius,
//         triggers,
//         androidSettings: androidSettings,
//       );
//       await gf.GeofencingManager.registerGeofence(
//           region, geofencingIsolateCallback);
//     }
//
//     final List<String> registeredGeofence =
//     await gf.GeofencingManager.getRegisteredGeofenceIds();
//     print('Registered geofence: $registeredGeofence');
//   }
//
//   static void geofencingIsolateCallback(
//       List<String> ids, gf.Location loc, gf.GeofenceEvent e) {
//     print('Geofencing Event: $e ID: $ids');
//     final SendPort send =
//         IsolateNameServer.lookupPortByName(_geofencingSendPort);
//     final GeofenceRegion region = GeofenceRegion(
//         id: ids.first,
//         location: Location(loc.latitude, loc.longitude),
//         radius: _geofencingRadius);
//     send?.send(region);
//   }
//
//   Future<void> unRegisterGeofence() async {
//     /// unregister fences
//     final List<String> registeredGeofence =
//         await gf.GeofencingManager.getRegisteredGeofenceIds();
//     for (final String id in registeredGeofence) {
//       await gf.GeofencingManager.removeGeofenceById(id);
//     }
//
//     /// unsubscribe geofencing service
//     unsubscribeGeofencing();
//     geofenceStream?.cancel();
//     port.close();
//   }
//
//
//   void geofencingEventCallback(dynamic data) {
//     print('Geofencing Callback Invoked!');
//     showPublicToast(msg: 'You are entering ${(data as GeofenceRegion).id}');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Builder(
//       builder: (BuildContext scaffoldContext) {
//         return Stack(
//           children: <Widget>[
//             _map,
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(kDefaultMargin),
//                 child: Stack(
//                   children: <Widget>[
//                     _backButton,
//                   ],
//                 ),
//               ),
//             )
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
//       stopMarkers: _stopMarkers,
//       circleRegions: _circleRegions,
//       polyline: _polyline,
//       initialZoom: kSecondaryMapZoom,
//       onMapReady: () {
//         mapController.move(stopPoints.first, destZoom: kSecondaryMapZoom);
//       },
//       onLocationUpdate: (Location loc) {},
//     );
//   }
//
//   Widget get _backButton => Align(
//         alignment: Alignment.topLeft,
//         child: CustomIconButton(
//           icon: Icons.back,
//           widgetTheme: WidgetTheme.whiteBlack,
//           shadowStrokeType: ShadowStrokeType.lowShadow,
//           iconSize: kSpacer.sm,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           padding: const EdgeInsets.all(kDefaultSmallMargin),
//         ),
//       );
//
//
//   List<ZMarkerStop> get _stopMarkers {
//     return stopPoints
//         .map((Location e) => ZMarkerStop(e, color: Colors.red))
//         .toList();
//   }
//
//   List<CircleRegion> get _circleRegions {
//     return _stopMarkers
//         .map((ZMarker e) => CircleRegion(_geofencingRadius, e.location))
//         .toList();
//   }
//
//   List<ZPolyline> get _polyline =>
//       <ZPolyline>[ZPolyline.fromEncodedRoute(route, lineColor: Colors.black)];
// }
