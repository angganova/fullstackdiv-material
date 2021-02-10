import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:latlong/latlong.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/map/map_utils.dart';

/// A controller for [ZMap]
class ZMapController {
  /// Default bound zoom level to 12
  double boundZoom = 12;

  MapController controller = MapController();

  /// Provide [TickerProvider] for animate map movement
  /// Will be lazily instantiated inside [ZMap] initState
  TickerProvider vsync;

  /// Get current map zoom level
  double get zoom {
    return controller.zoom;
  }

  /// Get current map center
  LatLng get center {
    return controller.center;
  }

  /// Get current map bounds value
  LatLngBounds get bound {
    return controller.bounds;
  }

  /// Function to zoom in/out
  /// [afterZoom] is optional callback to be call after map zoomed
  void zoomTo(double zoom, {bool animate = true, VoidCallback afterZoom}) {
    if (animate) {
      move(Location(center.latitude, center.longitude),
          destZoom: zoom, afterMoved: afterZoom);
    } else {
      controller.move(LatLng(center.latitude, center.longitude), zoom);
    }
  }

  /// Function to increase one level of zoom value
  void zoomIn() {
    if (zoom < kMaxMapZoom) {
      zoomTo(zoom + 1);
    }
  }

  /// Function to decrease one level of zoom value
  void zoomOut() {
    if (zoom > kMinMapZoom) {
      zoomTo(zoom - 1);
    }
  }

  /// Move map to particular location with tween animation
  /// If we don't need animation, we can just use [mapController.move()]
  void move(Location destLocation,
      {Duration duration, double destZoom, VoidCallback afterMoved}) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final Tween<double> _latTween = Tween<double>(
        begin: controller.center.latitude, end: destLocation.latitude);
    final Tween<double> _lngTween = Tween<double>(
        begin: controller.center.longitude, end: destLocation.longitude);
    Tween<double> _zoomTween;
    if (destZoom != null && controller.zoom != destZoom) {
      _zoomTween = Tween<double>(begin: controller.zoom, end: destZoom);
    }

    // Create a animation controller that has a duration and a TickerProvider.
    final AnimationController animationController =
        AnimationController(duration: duration ?? kDuration800, vsync: vsync);

    final Animation<double> animation =
        CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

    animationController.addListener(() {
      controller.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween != null ? _zoomTween.evaluate(animation) : controller.zoom);
    });

    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.dispose();
        if (afterMoved != null) {
          afterMoved();
        }
      } else if (status == AnimationStatus.dismissed) {
        animationController.dispose();
      }
    });

    animationController.forward();
  }

  /// Fit bounds all locations inside map
  Future<void> fitBounds(
      {@required List<Location> locations,
      @required double mapWidth,
      @required double mapHeight,
      double verticalPadding = 0,
      double horizontalPadding = 0,
      double destZoom,
      VoidCallback afterFitBounds}) async {
    final List<LatLng> locationList =
        locations.map((Location e) => LatLng(e.latitude, e.longitude)).toList();
    if (locationList.isNullOrEmpty) {
      return;
    }
    final LatLngBounds latLngBounds = LatLngBounds.fromPoints(locationList);

    final CustomPoint<double> mapSize =
        CustomPoint<double>(mapWidth, mapHeight);

    final CustomPoint<double> padding =
        CustomPoint<double>(horizontalPadding, verticalPadding + 160);

    /// calculate bound zoom
    final double currentZoom = zoom;
    double boundZoom = destZoom ??
        MapUtils.calculateBoundZoom(latLngBounds, currentZoom, mapSize, padding)
            .toDouble();
    final EdgeInsets edgeInsets = EdgeInsets.symmetric(
        vertical: verticalPadding, horizontal: horizontalPadding);

    /// get center point
    final LatLng newCenter =
        await MapUtils.getCenterBound(locationList, boundZoom, edgeInsets);

    final LatLng offsetCenter =
        MapUtils.latLngOffset(newCenter, 0, verticalPadding / 2, boundZoom);

    if (!boundZoom.isInfinite && !boundZoom.isNaN) {
      if (boundZoom > kMaxMapZoom) {
        boundZoom = kMaxMapZoom;
      }
      move(
        offsetCenter.toLocation(),
        destZoom: boundZoom,
        afterMoved: afterFitBounds,
      );
    }
  }

  /// move map to particular screen position
  void moveToScreenPosition(double x, double y,
      {double destZoom, VoidCallback afterMoved}) {
    destZoom ??= zoom;

    final LatLng newCenter = MapUtils.getLatLngFromScreenPosition(
        bounds: bound, posX: x, posY: y, zoom: zoom);
    move(Location(newCenter.latitude, newCenter.longitude),
        destZoom: destZoom, afterMoved: afterMoved);
  }

  /// Move marker to particular position using tween animation
  void moveMarker(ZMarker movedMarker, Location destLocation,
      {@required Function(Location) onMoveMarker,
      VoidCallback onMoveCompleted,
      Duration duration = kDuration500}) {
    final Tween<double> latTween = Tween<double>(
        begin: movedMarker.location.latitude, end: destLocation.latitude);
    final Tween<double> lngTween = Tween<double>(
        begin: movedMarker.location.longitude, end: destLocation.longitude);

    final AnimationController controller =
        AnimationController(duration: duration, vsync: vsync);

    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn);

    controller.addListener(() {
      onMoveMarker(Location(
        latTween.evaluate(animation),
        lngTween.evaluate(animation),
      ));
    });

    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (onMoveCompleted != null) {
          onMoveCompleted();
        }
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }


}
