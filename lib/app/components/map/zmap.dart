import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:latlong/latlong.dart';
import 'package:mobx/mobx.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker_stop.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker_taxi.dart';
import 'package:fullstackdiv_material/app/components/map/marker_helper.dart';
import 'package:fullstackdiv_material/app/components/map/polygon/circle_region.dart';
import 'package:fullstackdiv_material/app/components/map/polyline/zpolyline.dart';
import 'package:fullstackdiv_material/app/components/map/zmap_controller.dart';
import 'package:fullstackdiv_material/app/components/map/zmap_vm.dart';
import 'package:fullstackdiv_material/app/components/snackbar/basic_snack_bar.dart';
import 'package:fullstackdiv_material/system/copy/copy.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/map/map_utils.dart';

typedef LocationBoundsCallback = void Function(List<Location> locations);

/// A fullstackdiv_material Map Component
class ZMap extends StatefulWidget {
  const ZMap({
    Key key,
    @required this.mapController,
    this.context,
    this.userConfirmedLocationMarkers = const <ZMarker>[],
    this.taxiMarkers = const <ZMarkerTaxi>[],
    this.stopMarkers = const <ZMarkerStop>[],
    this.marketplaceMarkers = const <List<ZMarker>>[],
    this.initialPosition,
    this.showUserLocation = true,
    this.mapWidth,
    this.mapHeight,
    this.hideAllMarkers = false,
    this.polyline = const <ZPolyline>[],
    this.onLocationUpdate,
    this.onMapPositionChange,
    this.interactive = true,
    this.child,
    this.locationBounds = const <Location>[],
    this.onLocationBoundsChange,
    this.onMapReady,
    this.initialZoom,
    this.maxZoom,
    this.minZoom,
    this.moveToCurrentLocationOnLoad = true,
    this.centerVerticalOffset,
    this.disableClusteringAtZoom,
    this.maxClusterRadius,
    this.circleRegions = const <CircleRegion>[],
    this.updateMapLocationOnPositionChange = false,
    this.bottomPadding,
    this.locationOffscreenListener,
    this.onMapTapped,
  }) : super(key: key);

  // required
  final ZMapController mapController;

  // optional
  // TODO(Ikhsan): make this context argument as required
  final BuildContext context;
  final List<List<ZMarker>> marketplaceMarkers;
  final List<ZMarker> userConfirmedLocationMarkers;
  final List<ZMarkerTaxi> taxiMarkers;
  final List<ZMarkerStop> stopMarkers;
  final List<CircleRegion> circleRegions;
  final Location initialPosition;
  final bool showUserLocation;
  final bool moveToCurrentLocationOnLoad;
  final double mapHeight;
  final double mapWidth;
  final double initialZoom;
  final double maxZoom;
  final double minZoom;
  final int disableClusteringAtZoom;
  final int maxClusterRadius;
  final bool hideAllMarkers;
  final List<ZPolyline> polyline;
  final List<Location> locationBounds;
  final Function(Location) onLocationUpdate;
  final PositionCallback onMapPositionChange;
  final LocationBoundsCallback onLocationBoundsChange;
  final VoidCallback onMapReady;
  final double centerVerticalOffset;
  final Function(Location) onMapTapped;
  final double bottomPadding;
  final bool updateMapLocationOnPositionChange;
  final Function(bool) locationOffscreenListener;
  final Widget child;

  /// Default to true. Set false make map not draggable & not zoomable
  final bool interactive;

  @override
  _ZMapState createState() => _ZMapState();
}

class _ZMapState extends State<ZMap>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final String mapBoxUrlTemplate =
      'https://api.mapbox.com/styles/v1/cdgzest/ckhl88zia01mo19t6lf2ilzh4/tiles/256/{z}/{x}/{y}@2x';
  final Location _initialPosition = Location(1.299187, 103.845896);
  final ZMapViewModel _viewModel = getIt<ZMapViewModel>();
  final Copy _copy = getIt<Copy>();
  final Environments _env = getIt<Environments>();

  MapController _mapController;
  List<ReactionDisposer> _disposers;
  bool firstLocationLoad = true;
  double mapWidth;
  double mapHeight;
  LatLng offsetPosition;

  String get _mapBoxUrl =>
      '$mapBoxUrlTemplate?access_token=${_env.getMapBoxToken}';

  @override
  void initState() {
    _listenForStates();

    super.initState();

    WidgetsBinding.instance.addObserver(this);
    widget.mapController.vsync = this;
    _mapController = widget.mapController.controller ?? MapController();

    /// Invoke callback after everything built
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      /// if there's an offset then update map center position based on that point
      if (widget.centerVerticalOffset != null) {
        /// convert screen position to LatLng
        final LatLng newCenterPosition = MapUtils.getLatLngFromScreenPosition(
            bounds: _mapController.bounds,
            posY: (_mapHeight / 2) + widget.centerVerticalOffset,
            posX: _mapWidth / 2,
            zoom: _mapController.zoom);

        setState(() {
          offsetPosition = newCenterPosition;
        });
      }

      if (_showUserLocationIndicator) {
        /// Current flow when map need to show user location
        /// 1. Fetch location from last known location. if it's there, use it
        ///    then continue to listen to location updates
        /// 2. Fetch current (actual) location. Once it fetched, then continue
        ///    to listen to location updates
        if (await _getLastKnownLocation() == null) {
          _getCurrentLocation();
        }
      }

      if (widget.onMapReady != null) {
        widget.onMapReady();
      }

      _viewModel.lastCenterLocation = _mapController.center.toLocation();
    });
  }

  Future<Location> _getLastKnownLocation() async {
    if (await _viewModel.isLocationServiceAvailable) {
      return await _viewModel.getLastKnownLocation();
    }
    return null;
  }

  void _getCurrentLocation() {
    _viewModel.getCurrentLocation();
  }

  /// Listen for all state changes from vm
  void _listenForStates() {
    _disposers = <ReactionDisposer>[
      reaction((_) => _viewModel.currentLocation, (Location location) {
        if (_viewModel.positionStream == null) {
          /// once get location, listen location updates
          _viewModel.listenLocationUpdates();
        }

        if (firstLocationLoad) {
          if (widget.moveToCurrentLocationOnLoad) {
            //widget.mapController.move(location, destZoom: kDefaultMapZoom);
            _mapController.move(
                location.toLatLng(), widget.initialZoom ?? kDefaultMapZoom);
            widget.mapController.fitBounds(
              locations: <Location>[_viewModel.currentLocation],
              mapWidth: _mapWidth,
              mapHeight: _mapHeight,
              destZoom: widget.initialZoom ?? kDefaultMapZoom,
              verticalPadding: widget.bottomPadding ?? 0.0,
            );
            firstLocationLoad = false;
          }
        } else {
          if (widget.updateMapLocationOnPositionChange) {
            widget.mapController.fitBounds(
              locations: <Location>[_viewModel.currentLocation],
              mapWidth: _mapWidth,
              mapHeight: _mapHeight,
              destZoom: widget.mapController.zoom,
              verticalPadding: widget.bottomPadding ?? 0.0,
            );
          }
        }

        if (widget.onLocationUpdate != null) {
          widget.onLocationUpdate(location);
        }
      }),
      reaction((_) => _viewModel.lowLocationAccuracy, (bool lowAccuracy) {
        if (lowAccuracy) {
          if (context != null) {
            showBasicSnackBar(
              context: widget.context,
              text: _copy.missing(
                  'Weak GPS signal. Your location on the map might not be accurate'),
              widgetTheme: WidgetTheme.greyAWhite,
              icon: Icons.gps_off,
              iconSize: kSmallIconSize,
            );
          }
        }
      }),
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _viewModel.onDispose();
    for (final ReactionDisposer d in _disposers) {
      d();
    }
    super.dispose();
  }

  // re-check permissions when app is resumed
  // to handle when permissions are changed in app settings outside of app
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await _viewModel.isLocationServiceAvailable) {
        _viewModel.reFetchLocation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _mapHeight,
      width: _mapWidth,
      child: Stack(
        children: <Widget>[
          _buildMap,
          if (widget.child != null) widget.child,
        ],
      ),
    );
  }

  Widget get _buildMap {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraint) {
        mapHeight = constraint.maxHeight;
        mapWidth = constraint.maxWidth;
        return Observer(builder: (BuildContext context) {
          return FlutterMap(
            mapController: _mapController,
            options: _mapOptions,
            layers: <LayerOptions>[
              _tileLayerOptions,
              _circleLayerOptions,
              _polylineLayerOptions,
              _stopMarkerLayerOption,
              _userLiveLocationLayerOptions,
              _taxiMarkerLayerOptions,
              ..._marketplaceMarkerLayerOptions,
              _userConfirmedLocationLayerOptions,
            ],
          );
        });
      },
    );
  }

  double get _mapHeight {
    return widget.mapHeight ?? mapHeight;
  }

  double get _mapWidth {
    return widget.mapWidth ?? mapWidth;
  }

  Timer marketplaceFetchTimer;

  MapOptions get _mapOptions {
    LatLng center;
    if (offsetPosition != null) {
      center = offsetPosition;
    } else if (widget.initialPosition != null) {
      center = widget.initialPosition.toLatLng();
    } else {
      if (_viewModel.currentLocation == null) {
        center = LatLng(_initialPosition.latitude, _initialPosition.longitude);
      } else {
        center = _viewModel.currentLocation.toLatLng();
      }
    }
    return MapOptions(
      center: center,
      plugins: _mapPlugins,
      zoom: widget.initialZoom ?? kDefaultMapZoom,
      maxZoom: widget.maxZoom ?? kMaxMapZoom,
      minZoom: widget.minZoom ?? kMinMapZoom,
      interactive: widget.interactive,
      onTap: (LatLng position) {
        if (widget.onMapTapped != null) {
          widget.onMapTapped(position.toLocation());
        }
      },
      onPositionChanged: (MapPosition pos, bool gesture) {
        if (widget.locationOffscreenListener != null &&
            _viewModel.currentLocation != null) {
          final bool locationOffscreen = !_mapController.bounds
              .contains(_viewModel.currentLocation.toLatLng());
          widget.locationOffscreenListener(locationOffscreen);
        }

        if (_onMapPositionChange != null) {
          _onMapPositionChange(pos, gesture);
        }
      },
    );
  }

  /// List of taxi markers
  /// Set [hideAllMarkers] to true make this markers disappear
  List<Marker> get _taxiMarkers {
    if (widget.hideAllMarkers) {
      return <Marker>[];
    } else {
      return widget.taxiMarkers
          .map((ZMarkerTaxi e) => createMarker(e))
          .toList();
    }
  }

  /// List of taxi user confirmed marker (orgin, destination)
  /// Set [hideAllMarkers] to true make this markers disappear
  List<Marker> get _userConfirmedLocationMarkers {
    if (widget.hideAllMarkers) {
      return <Marker>[];
    } else {
      return widget.userConfirmedLocationMarkers
          .map((ZMarker e) => createMarker(e))
          .toList();
    }
  }

  /// List of stop markers (stop point on transportation route)
  /// Set [hideAllMarkers] to true make this markers disappear
  List<Marker> get _stopMarkers {
    if (widget.hideAllMarkers) {
      return <Marker>[];
    } else {
      return widget.stopMarkers.map((ZMarkerStop e) => e.build()).toList();
    }
  }

  List<CircleMarker> get _circleMarkers {
    return widget.circleRegions.map((CircleRegion e) {
      return CircleMarker(
          point: LatLng(e.location.latitude, e.location.longitude),
          color: kAppGreyC.withOpacity(0.5),
          borderColor: kAppGreyC,
          borderStrokeWidth: 2,
          useRadiusInMeter: true,
          radius: e.radius);
    }).toList();
  }

  List<MapPlugin> get _mapPlugins {
    return <MapPlugin>[
      MarkerClusterPlugin(),
    ];
  }

  TileLayerOptions get _tileLayerOptions {
    return TileLayerOptions(
      urlTemplate: _mapBoxUrl,
      backgroundColor: kAppDefaultMapTilesColor,
      tileProvider: const CachedNetworkTileProvider(),
    );
  }

  CircleLayerOptions get _circleLayerOptions {
    return CircleLayerOptions(circles: _circleMarkers);
  }

  PolylineLayerOptions get _polylineLayerOptions {
    return PolylineLayerOptions(
      polylines: widget.polyline.map((ZPolyline e) {
        return Polyline(
          points: e.points
              .map((Location e) => LatLng(e.latitude, e.longitude))
              .toList(),
          strokeWidth: _polylineStrokeWidth,
          color: e.lineColor,
          isDotted: e.isDotted,
        );
      }).toList(),
    );
  }

  MarkerLayerOptions get _stopMarkerLayerOption {
    return MarkerLayerOptions(markers: _stopMarkers);
  }

  MarkerLayerOptions get _userLiveLocationLayerOptions {
    if (_viewModel.currentLocation == null || !_showUserLocationIndicator) {
      return _emptyMarkerLayerOptions;
    } else {
      return MarkerLayerOptions(markers: <Marker>[
        createLiveLocationMarker(
            ZMarker(_viewModel.currentLocation,
                markerType: MarkerType.undefined,
                angle: _viewModel.currentHeading),
            inactive: _viewModel.lowLocationAccuracy)
      ]);
    }
  }

  MarkerLayerOptions get _taxiMarkerLayerOptions {
    return MarkerLayerOptions(markers: _taxiMarkers);
  }

  MarkerLayerOptions get _userConfirmedLocationLayerOptions {
    return MarkerLayerOptions(markers: _userConfirmedLocationMarkers);
  }

  MarkerLayerOptions get _emptyMarkerLayerOptions =>
      MarkerLayerOptions(markers: <Marker>[]);

  List<MarkerClusterLayerOptions> get _marketplaceMarkerLayerOptions {
    final List<MarkerClusterLayerOptions> options =
        <MarkerClusterLayerOptions>[];
    List<List<ZMarker>> markers;
    if (widget.hideAllMarkers) {
      markers = <List<ZMarker>>[];
    } else {
      markers = widget.marketplaceMarkers;
      for (final List<ZMarker> markerItems in markers) {
        final MarkerClusterLayerOptions option = MarkerClusterLayerOptions(
          maxClusterRadius: widget.maxClusterRadius ?? kMaxClusterRadius,
          disableClusteringAtZoom:
              widget.disableClusteringAtZoom ?? kDisableClusteringZoomLevel,
          size: const Size(kCusterPinWidth, kPinSize),
          anchor: AnchorPos.align(AnchorAlign.center),
          markers: markerItems.map((ZMarker e) => e.build()).toList(),
          polygonOptions: const PolygonOptions(color: kAppClearWhite),
          zoomToBoundsOnClick: true,
          builder: (_, List<Marker> markers) {
            bool highlighted = false;
            for (final Marker marker in markers) {
              if (_highlightedMarketplaceMarker != null &&
                  marker.point
                      .toLocation()
                      .equals(_highlightedMarketplaceMarker.location)) {
                highlighted = true;
                break;
              }
            }
            return createClusterMarker(markers.length,
                highlighted: highlighted);
          },
          animationsOptions: const AnimationsOptions(spiderfy: kDuration500),
        );
        options.add(option);
      }
    }
    return options;
  }

  bool get _showUserLocationIndicator {
    return widget.showUserLocation ?? true;
  }

  PositionCallback get _onMapPositionChange {
    if (widget.onMapPositionChange != null) {
      return widget.onMapPositionChange;
    }
    return null;
  }

  double get _polylineStrokeWidth {
    return 4.0;
  }

  ZMarker get _highlightedMarketplaceMarker {
    for (final List<ZMarker> markers in widget.marketplaceMarkers) {
      for (final ZMarker marker in markers) {
        if (marker.highlighted) {
          return marker;
        }
      }
    }
    return null;
  }
}
