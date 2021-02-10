import 'dart:async';

import 'package:fullstackdiv_material/app/components/map/view_model/location_vm.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

part 'zmap_vm.g.dart';

@injectable
class ZMapViewModel = _ZMapViewModel with _$ZMapViewModel;

abstract class _ZMapViewModel with Store {
  final LocationViewModel _locationViewModel = getIt<LocationViewModel>();

  /// timer started when location get low location accuracy
  /// will be stopped when location accuracy is good
  Timer lowLocationTracker;

  final int maxLowLocationAttempt = 30;

  // indicate low accuracy when location accuracy >= 500m
  final int locationAccuracyThreshold = 500;

  /// attempt count when location accuracy is low
  /// will tick until [maxLowLocationAttempt]
  /// will reset when location accuracy is good
  int lowLocationAttempt = 0;

  @observable
  StreamSubscription<Position> positionStream;

  @observable
  Location currentLocation;

  @observable
  bool lowLocationAccuracy = false;

  @observable
  Location lastCenterLocation;

  @computed
  double get currentHeading {
    if (currentLocation != null && currentLocation.heading != 0.0) {
      return currentLocation.heading;
    }
    return null;
  }

  @action
  void trackLowLocationAccuracyStatus() {
    if (lowLocationTracker == null || !lowLocationTracker.isActive) {
      lowLocationTracker = Timer.periodic(kDuration1000, (Timer timer) {
        //print('Poor location for $lowLocationAttempt seconds');
        if (lowLocationAttempt < maxLowLocationAttempt) {
          if (_isLowLocationAccuracy(currentLocation.accuracy)) {
            lowLocationAttempt++;
          } else {
            lowLocationAttempt = 0;
            timer.cancel();
          }
        } else {
          lowLocationAccuracy =
              _isLowLocationAccuracy(currentLocation.accuracy);
          lowLocationAttempt = 0;
          timer.cancel();
        }
      });
    }
  }

  @action
  Future<Location> getLastKnownLocation() async {
    final Location location = await _locationViewModel.getLastKnownLocation();
    if (!location.equals(currentLocation)){
      currentLocation = location;
    }
    return location;
  }

  @action
  Future<void> getCurrentLocation() async {
    final Location location = await _locationViewModel.getCurrentLocation();
    if (!location.equals(currentLocation)){
      currentLocation = location;
    }
  }

  @action
  void listenLocationUpdates() {
    final Stream<Position> stream = _locationViewModel.getLocationStream();
    if (stream != null) {
      positionStream = stream.listen((Position position) {
        if (position.latitude != null && position.longitude != null) {
          currentLocation = Location(position.latitude, position.longitude,
              heading: position.heading, accuracy: position.accuracy);

          /// when current location accuracy is low, start 30 sec timer
          /// if latest location accuracy is still low after 30 sec, then
          /// update [lowLocationAccuracy] to true to indicate poor location
          ///
          /// if latest location accuracy is sufficient/good (below threshold),
          /// then stop tracker
          if (_isLowLocationAccuracy(position.accuracy)) {
            trackLowLocationAccuracyStatus();
          } else {
            lowLocationTracker?.cancel();
            lowLocationAttempt = 0;
            lowLocationAccuracy = false;
          }
        }
      });
    }
  }

  Future<void> reFetchLocation() async {
    _locationViewModel.reInitState();
    getCurrentLocation();
  }

  @action
  void onDispose() {
    positionStream?.cancel();
    lowLocationTracker?.cancel();
  }

  Future<bool> get isLocationServiceAvailable async {
    return await isLocationPermissionEnabled &&
        await _locationViewModel.isLocationServiceEnabled();
  }

  Future<bool> get isLocationPermissionEnabled async {
    return await _locationViewModel.getLocationPermission() !=
            LocationPermission.denied &&
        await _locationViewModel.getLocationPermission() !=
            LocationPermission.deniedForever;
  }

  bool _isLowLocationAccuracy(double accuracy) {
    return accuracy >= locationAccuracyThreshold;
  }
}
