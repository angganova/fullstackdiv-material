import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:synchronized/extension.dart';

part 'location_vm.g.dart';

enum LocationFetchException {
  locationServiceDisabledException,
  permissionDeniedException,
  timeoutException,
  genericException
}

/// Make it singleton as will be shared across multiple sections
@lazySingleton
class LocationViewModel = _LocationViewModel with _$LocationViewModel;

abstract class _LocationViewModel with Store {
  final String tag = '[LocationViewModel]';

  /// set timeout duration to 10 sec
  final Duration timeoutDuration = kDuration10s;

  /// will set to false after first request
  @observable
  bool firstTimeRequest = true;

  /// cached last location as singleton instance
  @observable
  Location lastFetchedLocation;

  @observable
  LocationFetchException locationFetchException;

  /// indicate able to fetch location
  /// set to true when location fetched
  @observable
  bool locationAvailable;

  void reInitState() {
    locationFetchException = null;
  }

  @action
  Future<Location> getCurrentLocation() async {
    /// prevent concurrent access to this async process
    return synchronized(() async {
      if (locationFetchException ==
              LocationFetchException.locationServiceDisabledException ||
          locationFetchException ==
              LocationFetchException.permissionDeniedException) {
        return null;
      }

      if (firstTimeRequest && !await isLocationPermissionEnabled()) {
        /// Add delay for first time request to make permission dialog show up
        /// after page transition done
        await Future<void>.delayed(kDuration700);
      }

      try {
        final Position position = await Geolocator.getCurrentPosition(
            timeLimit: timeoutDuration, desiredAccuracy: LocationAccuracy.best);
        if (position != null) {
          lastFetchedLocation = Location(position.latitude, position.longitude,
              heading: position.heading, accuracy: position.accuracy);
          locationAvailable = true;
        }
        reInitState();
        return lastFetchedLocation;
      } catch (err) {
        if (err is LocationServiceDisabledException) {
          locationFetchException =
              LocationFetchException.locationServiceDisabledException;
          debugPrint('$tag: LocationServiceDisabledException');
        } else if (err is PermissionDeniedException) {
          locationFetchException =
              LocationFetchException.permissionDeniedException;
          debugPrint('$tag: PermissionDeniedException');
        } else if (err is TimeoutException) {
          // If timeout occurs: If there is last location, use last known location
          final Location lastKnownPosition = await getLastKnownLocation();
          if (lastKnownPosition != null) {
            lastFetchedLocation = Location(
                lastKnownPosition.latitude, lastKnownPosition.longitude,
                heading: lastKnownPosition.heading,
                accuracy: lastKnownPosition.accuracy);
            reInitState();
            return lastFetchedLocation;
          } else {
            locationFetchException = LocationFetchException.timeoutException;
            debugPrint('$tag: TimeoutException');
          }
        } else {
          locationFetchException = LocationFetchException.genericException;
          debugPrint('$tag failed to get location: $err');
        }
      }
      return null;
    });
  }

  /// Returns the last known position stored on the users device.
  @action
  Future<Location> getLastKnownLocation() async {
    final Position position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      locationAvailable = true;
      lastFetchedLocation = Location(position.latitude, position.longitude,
          heading: position.heading, accuracy: position.accuracy);
    }
    firstTimeRequest = false;
    return lastFetchedLocation;
  }

  /// Return steam of position
  /// Will fires whenever the location changes inside the bounds of the
  /// [desiredAccuracy]
  @action
  Stream<Position> getLocationStream() {
    try {
      final Stream<Position> stream = Geolocator.getPositionStream(
          desiredAccuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 2);
      return stream;
    } catch (err) {
      if (err is LocationServiceDisabledException) {
        locationFetchException =
            LocationFetchException.locationServiceDisabledException;
      } else if (err is PermissionDeniedException) {
        locationFetchException =
            LocationFetchException.permissionDeniedException;
      }
      debugPrint('$tag failed to get position stream: $err');
    }
    return null;
  }

  /// Return current location permission status
  Future<LocationPermission> getLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Opens the location settings page.
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// Opens the App settings page.
  Future<void> openAppSetting() async {
    await Geolocator.openAppSettings();
  }

  /// Return true if location permission is granted
  Future<bool> isLocationPermissionEnabled() async {
    return await getLocationPermission() != LocationPermission.denied &&
        await getLocationPermission() != LocationPermission.deniedForever;
  }

  /// Return true if location service / GPS is enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Return true if location permission is granted &
  /// location service (GPS) is enabled
  Future<bool> isLocationServiceAvailable() async {
    return await isLocationPermissionEnabled() &&
        await isLocationServiceEnabled();
  }

  /// Return true if background location permission is granted
  Future<bool> isBackgroundLocationPermissionEnabled() async {
    return await getLocationPermission() == LocationPermission.always;
  }
}
