// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocationViewModel on _LocationViewModel, Store {
  final _$firstTimeRequestAtom =
      Atom(name: '_LocationViewModel.firstTimeRequest');

  @override
  bool get firstTimeRequest {
    _$firstTimeRequestAtom.reportRead();
    return super.firstTimeRequest;
  }

  @override
  set firstTimeRequest(bool value) {
    _$firstTimeRequestAtom.reportWrite(value, super.firstTimeRequest, () {
      super.firstTimeRequest = value;
    });
  }

  final _$lastFetchedLocationAtom =
      Atom(name: '_LocationViewModel.lastFetchedLocation');

  @override
  Location get lastFetchedLocation {
    _$lastFetchedLocationAtom.reportRead();
    return super.lastFetchedLocation;
  }

  @override
  set lastFetchedLocation(Location value) {
    _$lastFetchedLocationAtom.reportWrite(value, super.lastFetchedLocation, () {
      super.lastFetchedLocation = value;
    });
  }

  final _$locationFetchExceptionAtom =
      Atom(name: '_LocationViewModel.locationFetchException');

  @override
  LocationFetchException get locationFetchException {
    _$locationFetchExceptionAtom.reportRead();
    return super.locationFetchException;
  }

  @override
  set locationFetchException(LocationFetchException value) {
    _$locationFetchExceptionAtom
        .reportWrite(value, super.locationFetchException, () {
      super.locationFetchException = value;
    });
  }

  final _$locationAvailableAtom =
      Atom(name: '_LocationViewModel.locationAvailable');

  @override
  bool get locationAvailable {
    _$locationAvailableAtom.reportRead();
    return super.locationAvailable;
  }

  @override
  set locationAvailable(bool value) {
    _$locationAvailableAtom.reportWrite(value, super.locationAvailable, () {
      super.locationAvailable = value;
    });
  }

  final _$getCurrentLocationAsyncAction =
      AsyncAction('_LocationViewModel.getCurrentLocation');

  @override
  Future<Location> getCurrentLocation() {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation());
  }

  final _$getLastKnownLocationAsyncAction =
      AsyncAction('_LocationViewModel.getLastKnownLocation');

  @override
  Future<Location> getLastKnownLocation() {
    return _$getLastKnownLocationAsyncAction
        .run(() => super.getLastKnownLocation());
  }

  final _$_LocationViewModelActionController =
      ActionController(name: '_LocationViewModel');

  @override
  Stream<Position> getLocationStream() {
    final _$actionInfo = _$_LocationViewModelActionController.startAction(
        name: '_LocationViewModel.getLocationStream');
    try {
      return super.getLocationStream();
    } finally {
      _$_LocationViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
firstTimeRequest: ${firstTimeRequest},
lastFetchedLocation: ${lastFetchedLocation},
locationFetchException: ${locationFetchException},
locationAvailable: ${locationAvailable}
    ''';
  }
}
