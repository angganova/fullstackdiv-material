// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofence_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GeofenceViewModel on _GeofenceViewModel, Store {
  final _$allRegisteredRegionsAtom =
      Atom(name: '_GeofenceViewModel.allRegisteredRegions');

  @override
  ObservableList<GeofenceRegion> get allRegisteredRegions {
    _$allRegisteredRegionsAtom.reportRead();
    return super.allRegisteredRegions;
  }

  @override
  set allRegisteredRegions(ObservableList<GeofenceRegion> value) {
    _$allRegisteredRegionsAtom.reportWrite(value, super.allRegisteredRegions,
        () {
      super.allRegisteredRegions = value;
    });
  }

  final _$lastActiveRegionAtom =
      Atom(name: '_GeofenceViewModel.lastActiveRegion');

  @override
  GeofenceRegion get lastActiveRegion {
    _$lastActiveRegionAtom.reportRead();
    return super.lastActiveRegion;
  }

  @override
  set lastActiveRegion(GeofenceRegion value) {
    _$lastActiveRegionAtom.reportWrite(value, super.lastActiveRegion, () {
      super.lastActiveRegion = value;
    });
  }

  final _$locationPermissionExceptionOccursAtom =
      Atom(name: '_GeofenceViewModel.locationPermissionExceptionOccurs');

  @override
  bool get locationPermissionExceptionOccurs {
    _$locationPermissionExceptionOccursAtom.reportRead();
    return super.locationPermissionExceptionOccurs;
  }

  @override
  set locationPermissionExceptionOccurs(bool value) {
    _$locationPermissionExceptionOccursAtom
        .reportWrite(value, super.locationPermissionExceptionOccurs, () {
      super.locationPermissionExceptionOccurs = value;
    });
  }

  final _$locationPermissionWarningShownAtom =
      Atom(name: '_GeofenceViewModel.locationPermissionWarningShown');

  @override
  bool get locationPermissionWarningShown {
    _$locationPermissionWarningShownAtom.reportRead();
    return super.locationPermissionWarningShown;
  }

  @override
  set locationPermissionWarningShown(bool value) {
    _$locationPermissionWarningShownAtom
        .reportWrite(value, super.locationPermissionWarningShown, () {
      super.locationPermissionWarningShown = value;
    });
  }

  final _$registerAsyncAction = AsyncAction('_GeofenceViewModel.register');

  @override
  Future<void> register(List<GeofenceRegion> regions) {
    return _$registerAsyncAction.run(() => super.register(regions));
  }

  final _$unregisterAsyncAction = AsyncAction('_GeofenceViewModel.unregister');

  @override
  Future<void> unregister() {
    return _$unregisterAsyncAction.run(() => super.unregister());
  }

  final _$_addGeofenceRegionsAsyncAction =
      AsyncAction('_GeofenceViewModel._addGeofenceRegions');

  @override
  Future<void> _addGeofenceRegions(List<GeofenceRegion> regions) {
    return _$_addGeofenceRegionsAsyncAction
        .run(() => super._addGeofenceRegions(regions));
  }

  final _$_GeofenceViewModelActionController =
      ActionController(name: '_GeofenceViewModel');

  @override
  void _onGeofenceUpdated(String regionId) {
    final _$actionInfo = _$_GeofenceViewModelActionController.startAction(
        name: '_GeofenceViewModel._onGeofenceUpdated');
    try {
      return super._onGeofenceUpdated(regionId);
    } finally {
      _$_GeofenceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allRegisteredRegions: ${allRegisteredRegions},
lastActiveRegion: ${lastActiveRegion},
locationPermissionExceptionOccurs: ${locationPermissionExceptionOccurs},
locationPermissionWarningShown: ${locationPermissionWarningShown}
    ''';
  }
}
