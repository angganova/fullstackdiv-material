import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/app/components/map/view_model/location_vm.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:geofencing/geofencing.dart' as gf;
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'geofence_vm.g.dart';

@lazySingleton
class GeofenceViewModel = _GeofenceViewModel with _$GeofenceViewModel;

abstract class _GeofenceViewModel with Store {
  final LocationViewModel _locationViewModel = getIt<LocationViewModel>();

  static const String _geofencingSendPort = 'geofencing_isolate_port';

  /// Geofencing Error Code (for Android)
  /// Please check: https://developers.google.com/android/reference/com/google/android/gms/location/GeofenceStatusCodes
  static const String _unavailableServiceErrorCode =
      'com.google.android.gms.common.api.ApiException: 1000: ';
  static const String _insufficientLocationPermissionErrorCode =
      'com.google.android.gms.common.api.ApiException: 1004: ';

  ReceivePort receivePort;
  final List<gf.GeofenceEvent> triggers = <gf.GeofenceEvent>[
    gf.GeofenceEvent.enter,
  ];

  /// Define initial trigger (only works on android)
  /// Initial trigger means the geofencing event will immediately triggered
  /// when location is already inside geofence on the first time
  final gf.AndroidGeofencingSettings androidSettings =
      gf.AndroidGeofencingSettings(initialTrigger: <gf.GeofenceEvent>[
    gf.GeofenceEvent.enter,
  ], loiteringDelay: 0 /*1000 * 60*/);
  StreamSubscription<dynamic> geofencingSubscription;

  @observable
  ObservableList<GeofenceRegion> allRegisteredRegions =
      ObservableList<GeofenceRegion>();

  @observable
  GeofenceRegion lastActiveRegion;

  /// Indicate no sufficient location permission to perform geofencing operations.
  /// (Start from android 10, background location access is required to perform geofencing)
  /// Please check: https://developer.android.com/training/location/permissions#request-background-location
  ///
  /// Set true when no sufficient location permission
  @observable
  bool locationPermissionExceptionOccurs = false;

  /// Indicate location permission dialog already shown
  @observable
  bool locationPermissionWarningShown = false;

  /// Registering geofencing service
  @action
  Future<void> register(List<GeofenceRegion> regions) async {
    locationPermissionExceptionOccurs = false;

    /// initialize service
    await gf.GeofencingManager.initialize();

    /// Unsubscribe service if there's active geofencing service port,
    if (IsolateNameServer.lookupPortByName(_geofencingSendPort) != null) {
      _unsubscribeGeofencing();
    }

    /// Subscribe service
    final bool result = _subscribeGeofencing();
    if (result) {
      geofencingSubscription = receivePort.listen((dynamic data) {
        print('Geofencing callback invoked!');
        _onGeofenceUpdated(data as String);
      });
      print('Subscribing Geofencing: $result');

      /// Register geofence regions after success subscription
      _addGeofenceRegions(regions);
    } else {
      print('Failed to subscribe Geofencing');
    }
  }

  /// Unregister geofencing service
  @action
  Future<void> unregister() async {
    /// Unregister geofence regions
    allRegisteredRegions.clear();
    lastActiveRegion = null;
    final List<String> ids =
        await gf.GeofencingManager.getRegisteredGeofenceIds();
    for (final String id in ids) {
      await gf.GeofencingManager.removeGeofenceById(id);
    }

    /// Stop listening to service
    _unsubscribeGeofencing();
    geofencingSubscription?.cancel();
    receivePort.close();
  }

  /// Subscribe geofencing service callback
  bool _subscribeGeofencing() {
    receivePort = ReceivePort();
    return IsolateNameServer.registerPortWithName(
        receivePort.sendPort, _geofencingSendPort);
  }

  /// Unsubscribe geofencing service callback
  bool _unsubscribeGeofencing() {
    final bool result =
        IsolateNameServer.removePortNameMapping(_geofencingSendPort);
    print('Unsubscribe geofencing: $result');
    return result;
  }

  /// Function to add geofence regions
  /// Make sure geofencing is initialised before call this function
  @action
  Future<void> _addGeofenceRegions(List<GeofenceRegion> regions) async {
    try {
      for (final GeofenceRegion geofenceRegion in regions) {
        final gf.GeofenceRegion region = gf.GeofenceRegion(
            geofenceRegion.id,
            geofenceRegion.location.latitude,
            geofenceRegion.location.longitude,
            geofenceRegion.radius,
            triggers,
            androidSettings: androidSettings);
        await gf.GeofencingManager.registerGeofence(
            region, _geofencingIsolateCallback);
        allRegisteredRegions.add(geofenceRegion);
        locationPermissionExceptionOccurs = false;
      }
    } catch (e) {
      print('Geofencing Error: ${e.toString()}');
      if (e is PlatformException) {
        /// Platform Exception on Android
        if (e.code == _insufficientLocationPermissionErrorCode ||
            e.code == _unavailableServiceErrorCode) {
          locationPermissionExceptionOccurs = true;
        }
      }
    }
  }

  /// platform channel callback
  /// Please use Isolate to communicate with UI thread
  static void _geofencingIsolateCallback(
      List<String> ids, gf.Location loc, gf.GeofenceEvent e) {
    print('Current Geofence:');
    print('ID: ${ids.first} Location $loc Event: $e');
    for (final String id in ids) {
      final SendPort send =
          IsolateNameServer.lookupPortByName(_geofencingSendPort);
      send?.send(id);
    }
  }

  /// This is callback when geofence event triggered
  /// Please add all UI reaction to geofence event here
  @action
  void _onGeofenceUpdated(String regionId) {
    final GeofenceRegion newActiveRegion = allRegisteredRegions
        .firstWhere((GeofenceRegion e) => e.id == regionId, orElse: () => null);

    if (lastActiveRegion == null) {
      lastActiveRegion = newActiveRegion;
    } else {
      final int newActiveRegionIndex = allRegisteredRegions
          .indexWhere((GeofenceRegion e) => e.id == regionId);
      final int lastActiveRegionIndex = allRegisteredRegions
          .indexWhere((GeofenceRegion e) => e.id == lastActiveRegion.id);

      /// Make sure active region will only move forwards
      if (newActiveRegionIndex > lastActiveRegionIndex) {
        lastActiveRegion = newActiveRegion;
      }
    }
  }

  Future<bool> isBackgroundLocationEnabled() async {
    return await _locationViewModel.isBackgroundLocationPermissionEnabled();
  }

  /// Redirect user to app setting page
  void openLocationSettings() {
    _locationViewModel.openAppSetting();
  }
}

class GeofenceRegion {
  GeofenceRegion({
    @required this.location,
    @required this.radius,
    this.id,
  });

  final String id;
  final Location location;
  final double radius;
}
