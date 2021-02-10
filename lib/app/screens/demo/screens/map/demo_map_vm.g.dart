// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_map_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DemoMapViewModel on _DemoMapViewModel, Store {
  final _$currentLatAtom = Atom(name: '_DemoMapViewModel.currentLat');

  @override
  double get currentLat {
    _$currentLatAtom.reportRead();
    return super.currentLat;
  }

  @override
  set currentLat(double value) {
    _$currentLatAtom.reportWrite(value, super.currentLat, () {
      super.currentLat = value;
    });
  }

  final _$currentLngAtom = Atom(name: '_DemoMapViewModel.currentLng');

  @override
  double get currentLng {
    _$currentLngAtom.reportRead();
    return super.currentLng;
  }

  @override
  set currentLng(double value) {
    _$currentLngAtom.reportWrite(value, super.currentLng, () {
      super.currentLng = value;
    });
  }

  final _$centerLatAtom = Atom(name: '_DemoMapViewModel.centerLat');

  @override
  double get centerLat {
    _$centerLatAtom.reportRead();
    return super.centerLat;
  }

  @override
  set centerLat(double value) {
    _$centerLatAtom.reportWrite(value, super.centerLat, () {
      super.centerLat = value;
    });
  }

  final _$centerLngAtom = Atom(name: '_DemoMapViewModel.centerLng');

  @override
  double get centerLng {
    _$centerLngAtom.reportRead();
    return super.centerLng;
  }

  @override
  set centerLng(double value) {
    _$centerLngAtom.reportWrite(value, super.centerLng, () {
      super.centerLng = value;
    });
  }

  final _$encodedRouteAtom = Atom(name: '_DemoMapViewModel.encodedRoute');

  @override
  String get encodedRoute {
    _$encodedRouteAtom.reportRead();
    return super.encodedRoute;
  }

  @override
  set encodedRoute(String value) {
    _$encodedRouteAtom.reportWrite(value, super.encodedRoute, () {
      super.encodedRoute = value;
    });
  }

  final _$routeDrawnAtom = Atom(name: '_DemoMapViewModel.routeDrawn');

  @override
  bool get routeDrawn {
    _$routeDrawnAtom.reportRead();
    return super.routeDrawn;
  }

  @override
  set routeDrawn(bool value) {
    _$routeDrawnAtom.reportWrite(value, super.routeDrawn, () {
      super.routeDrawn = value;
    });
  }

  final _$isCurveRouteAtom = Atom(name: '_DemoMapViewModel.isCurveRoute');

  @override
  bool get isCurveRoute {
    _$isCurveRouteAtom.reportRead();
    return super.isCurveRoute;
  }

  @override
  set isCurveRoute(bool value) {
    _$isCurveRouteAtom.reportWrite(value, super.isCurveRoute, () {
      super.isCurveRoute = value;
    });
  }

  final _$isDottedRouteAtom = Atom(name: '_DemoMapViewModel.isDottedRoute');

  @override
  bool get isDottedRoute {
    _$isDottedRouteAtom.reportRead();
    return super.isDottedRoute;
  }

  @override
  set isDottedRoute(bool value) {
    _$isDottedRouteAtom.reportWrite(value, super.isDottedRoute, () {
      super.isDottedRoute = value;
    });
  }

  final _$getRouteStateAtom = Atom(name: '_DemoMapViewModel.getRouteState');

  @override
  GetRouteState get getRouteState {
    _$getRouteStateAtom.reportRead();
    return super.getRouteState;
  }

  @override
  set getRouteState(GetRouteState value) {
    _$getRouteStateAtom.reportWrite(value, super.getRouteState, () {
      super.getRouteState = value;
    });
  }

  final _$locationStateAtom = Atom(name: '_DemoMapViewModel.locationState');

  @override
  LocationState get locationState {
    _$locationStateAtom.reportRead();
    return super.locationState;
  }

  @override
  set locationState(LocationState value) {
    _$locationStateAtom.reportWrite(value, super.locationState, () {
      super.locationState = value;
    });
  }

  final _$routePointsAtom = Atom(name: '_DemoMapViewModel.routePoints');

  @override
  ObservableList<LatLng> get routePoints {
    _$routePointsAtom.reportRead();
    return super.routePoints;
  }

  @override
  set routePoints(ObservableList<LatLng> value) {
    _$routePointsAtom.reportWrite(value, super.routePoints, () {
      super.routePoints = value;
    });
  }

  final _$pinLocationsAtom = Atom(name: '_DemoMapViewModel.pinLocations');

  @override
  ObservableList<LatLng> get pinLocations {
    _$pinLocationsAtom.reportRead();
    return super.pinLocations;
  }

  @override
  set pinLocations(ObservableList<LatLng> value) {
    _$pinLocationsAtom.reportWrite(value, super.pinLocations, () {
      super.pinLocations = value;
    });
  }

  final _$_DemoMapViewModelActionController =
      ActionController(name: '_DemoMapViewModel');

  @override
  void fetchSuggestedRoutes(
      {Location origin, Location destination, int timeType}) {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.fetchSuggestedRoutes');
    try {
      return super.fetchSuggestedRoutes(
          origin: origin, destination: destination, timeType: timeType);
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchItineraryDetails(String itineraryId) {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.fetchItineraryDetails');
    try {
      return super.fetchItineraryDetails(itineraryId);
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void findRoutePolyline() {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.findRoutePolyline');
    try {
      return super.findRoutePolyline();
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchLocation() {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.fetchLocation');
    try {
      return super.fetchLocation();
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPinLocation(double latitude, double longitude) {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.addPinLocation');
    try {
      return super.addPinLocation(latitude, longitude);
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCenterLocation(double latitude, double longitude) {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.updateCenterLocation');
    try {
      return super.updateCenterLocation(latitude, longitude);
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearRoute() {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.clearRoute');
    try {
      return super.clearRoute();
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurveRoute(bool curveRoute) {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.setCurveRoute');
    try {
      return super.setCurveRoute(curveRoute);
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDottedRoute(bool dottedRoute) {
    final _$actionInfo = _$_DemoMapViewModelActionController.startAction(
        name: '_DemoMapViewModel.setDottedRoute');
    try {
      return super.setDottedRoute(dottedRoute);
    } finally {
      _$_DemoMapViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentLat: ${currentLat},
currentLng: ${currentLng},
centerLat: ${centerLat},
centerLng: ${centerLng},
encodedRoute: ${encodedRoute},
routeDrawn: ${routeDrawn},
isCurveRoute: ${isCurveRoute},
isDottedRoute: ${isDottedRoute},
getRouteState: ${getRouteState},
locationState: ${locationState},
routePoints: ${routePoints},
pinLocations: ${pinLocations}
    ''';
  }
}
