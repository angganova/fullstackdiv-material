// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zmap_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ZMapViewModel on _ZMapViewModel, Store {
  Computed<double> _$currentHeadingComputed;

  @override
  double get currentHeading =>
      (_$currentHeadingComputed ??= Computed<double>(() => super.currentHeading,
              name: '_ZMapViewModel.currentHeading'))
          .value;

  final _$positionStreamAtom = Atom(name: '_ZMapViewModel.positionStream');

  @override
  StreamSubscription<Position> get positionStream {
    _$positionStreamAtom.reportRead();
    return super.positionStream;
  }

  @override
  set positionStream(StreamSubscription<Position> value) {
    _$positionStreamAtom.reportWrite(value, super.positionStream, () {
      super.positionStream = value;
    });
  }

  final _$currentLocationAtom = Atom(name: '_ZMapViewModel.currentLocation');

  @override
  Location get currentLocation {
    _$currentLocationAtom.reportRead();
    return super.currentLocation;
  }

  @override
  set currentLocation(Location value) {
    _$currentLocationAtom.reportWrite(value, super.currentLocation, () {
      super.currentLocation = value;
    });
  }

  final _$lowLocationAccuracyAtom =
      Atom(name: '_ZMapViewModel.lowLocationAccuracy');

  @override
  bool get lowLocationAccuracy {
    _$lowLocationAccuracyAtom.reportRead();
    return super.lowLocationAccuracy;
  }

  @override
  set lowLocationAccuracy(bool value) {
    _$lowLocationAccuracyAtom.reportWrite(value, super.lowLocationAccuracy, () {
      super.lowLocationAccuracy = value;
    });
  }

  final _$lastCenterLocationAtom =
      Atom(name: '_ZMapViewModel.lastCenterLocation');

  @override
  Location get lastCenterLocation {
    _$lastCenterLocationAtom.reportRead();
    return super.lastCenterLocation;
  }

  @override
  set lastCenterLocation(Location value) {
    _$lastCenterLocationAtom.reportWrite(value, super.lastCenterLocation, () {
      super.lastCenterLocation = value;
    });
  }

  final _$getLastKnownLocationAsyncAction =
      AsyncAction('_ZMapViewModel.getLastKnownLocation');

  @override
  Future<Location> getLastKnownLocation() {
    return _$getLastKnownLocationAsyncAction
        .run(() => super.getLastKnownLocation());
  }

  final _$getCurrentLocationAsyncAction =
      AsyncAction('_ZMapViewModel.getCurrentLocation');

  @override
  Future<void> getCurrentLocation() {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation());
  }

  final _$_ZMapViewModelActionController =
      ActionController(name: '_ZMapViewModel');

  @override
  void trackLowLocationAccuracyStatus() {
    final _$actionInfo = _$_ZMapViewModelActionController.startAction(
        name: '_ZMapViewModel.trackLowLocationAccuracyStatus');
    try {
      return super.trackLowLocationAccuracyStatus();
    } finally {
      _$_ZMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listenLocationUpdates() {
    final _$actionInfo = _$_ZMapViewModelActionController.startAction(
        name: '_ZMapViewModel.listenLocationUpdates');
    try {
      return super.listenLocationUpdates();
    } finally {
      _$_ZMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDispose() {
    final _$actionInfo = _$_ZMapViewModelActionController.startAction(
        name: '_ZMapViewModel.onDispose');
    try {
      return super.onDispose();
    } finally {
      _$_ZMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
positionStream: ${positionStream},
currentLocation: ${currentLocation},
lowLocationAccuracy: ${lowLocationAccuracy},
lastCenterLocation: ${lastCenterLocation},
currentHeading: ${currentHeading}
    ''';
  }
}
