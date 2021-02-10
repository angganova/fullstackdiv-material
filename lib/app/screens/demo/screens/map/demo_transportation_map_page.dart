import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/app/components/button/large_button.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker_stop.dart';
import 'package:fullstackdiv_material/app/components/map/zmap.dart';
import 'package:fullstackdiv_material/app/components/map/zmap_controller.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
import 'package:fullstackdiv_material/app/components/map/polyline/zpolyline.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// A Demo class to display transportation route example in Map
/// All data is mock
class DemoTransportationMapPage extends StatefulWidget {
  @override
  _DemoTransportationMapPageState createState() =>
      _DemoTransportationMapPageState();
}

class _DemoTransportationMapPageState extends State<DemoTransportationMapPage> {
  ZMapController mapController = ZMapController();

  Location origin = Location(1.359073, 103.837486);
  Location destination = Location(1.3687, 103.84996);
  List<Location> stopPoints = <Location>[
    Location(1.359073, 103.837486),
    Location(1.36415, 103.84521),
    Location(1.36463, 103.85221),
    Location(1.3687, 103.84996),
  ];

  List<ZPolyline> get transportationPolyline => <ZPolyline>[
        ZPolyline.fromEncodedRoute(
            r'emhGiwwxRsDyAsCgAqEgBgAUn@oBjAyCvAeEt@cBJ[yEcAgJkBaCi@V}L',
            lineColor: WidgetTheme.blueWhite.backgroundColor),
        ZPolyline.fromEncodedRoute(
            r'}liGqgyxRbBiKrDsK|DoFxGaJ\a@iGyAcGa@wCl@gEfB',
            lineColor: WidgetTheme.redWhite.backgroundColor),
        ZPolyline.fromEncodedRoute(r'}oiGiszxRkEnBwHjDcHdD',
            lineColor: kAppBlack),
      ];

  List<ZPolyline> get walkPolyline => <ZPolyline>[
        ZPolyline.fromEncodedRoute(
          r'emhGiwwxRsDyAsCgAqEgBgAUn@oBjAyCvAeEt@cBJ[yEcAgJkBaCi@V}L',
          lineColor: kAppGreyC,
          isDotted: true,
        ),
      ];

  List<Location> restaurantPoints = <Location>[
    Location(1.3639591, 103.8435423),
    Location(1.3621786, 103.8439499),
    Location(1.3653213, 103.8473295),
    Location(1.3568479, 103.8484024),
    Location(1.3555608, 103.8492178),
  ];

  bool isWalking = false;
  bool exploreMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  _map,
                  _backButton,
                  _exploreButton,
                  _switchButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _map {
    return ZMap(
      mapController: mapController,
      showUserLocation: true,
      mapHeight: _mapHeight,
      userConfirmedLocationMarkers: _userConfirmedLocationMarkers,
      marketplaceMarkers: <List<ZMarker>>[_marketplaceMarkers],
      stopMarkers: _stopMarkers,
      polyline: isWalking ? walkPolyline : transportationPolyline,
      onLocationUpdate: (Location loc) {},
    );
  }

  double get _mapHeight => AppQuery(context).height;

  Widget get _backButton => Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultMargin),
          child: CustomIconButton(
            icon: Icons.arrow_back,
            widgetTheme: WidgetTheme.whiteBlack,
            shadowStrokeType: ShadowStrokeType.lowShadow,
            iconSize: kSpacer.sm,
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(kDefaultSmallMargin),
          ),
        ),
      );

  List<ZMarker> get _userConfirmedLocationMarkers {
    return <ZMarker>[
      ZMarker(origin,
          markerType: MarkerType.origin,
          edgeInsets: kSpacer.edgeInsets.bottom.xs),
      ZMarker(isWalking ? stopPoints[1] : destination,
          markerType: MarkerType.destination,
          edgeInsets: kSpacer.edgeInsets.bottom.xs),
    ];
  }

  Widget get _exploreButton => Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: kSpacer.edgeInsets.all.sm,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              LargeButton(
                title: 'Explore',
                onPressed: () {
                  setState(() {
                    exploreMode = !exploreMode;
                  });
                },
                icon: Icons.location_on,
                widgetTheme:
                    exploreMode ? WidgetTheme.blueWhite : WidgetTheme.whiteBlue,
              ),
            ],
          ),
        ),
      );

  Widget get _switchButton => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: kSpacer.edgeInsets.all.sm,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LargeButton(
                title: 'Transportation',
                onPressed: () {
                  setState(() {
                    isWalking = false;
                  });

                  /// Fit bounds to transportation points
                  final List<Location> allTransportationPoints = <Location>[];
                  for (final ZPolyline polyline in transportationPolyline) {
                    allTransportationPoints.addAll(polyline.points);
                  }
                  _fitBounds(allTransportationPoints);
                },
                icon: Icons.train,
                widgetTheme:
                    isWalking ? WidgetTheme.whiteBlue : WidgetTheme.blueWhite,
              ),
              LargeButton(
                title: 'Walking',
                onPressed: () {
                  setState(() {
                    isWalking = true;
                  });

                  /// Fit bounds to walking points
                  final List<Location> allWalkPoints = <Location>[];
                  for (final ZPolyline polyline in walkPolyline) {
                    allWalkPoints.addAll(polyline.points);
                  }
                  _fitBounds(allWalkPoints);
                },
                icon: Icons.local_taxi,
                widgetTheme:
                    isWalking ? WidgetTheme.blueWhite : WidgetTheme.whiteBlue,
              ),
            ],
          ),
        ),
      );

  List<ZMarker> get _marketplaceMarkers {
    if (exploreMode) {
      return restaurantPoints
          .map((Location e) => ZMarker(e, markerType: MarkerType.restaurant))
          .toList();
    } else {
      return <ZMarker>[];
    }
  }

  List<ZMarkerStop> get _stopMarkers {
    if (isWalking) {
      return <ZMarkerStop>[
        ZMarkerStop(stopPoints[0], color: kAppGreyC),
        ZMarkerStop(stopPoints[1], color: kAppGreyC),
      ];
    } else {
      return <ZMarkerStop>[
        ZMarkerStop(
          stopPoints[0],
          color: WidgetTheme.blueWhite.backgroundColor,
        ),
        ZMarkerStop(
          stopPoints[1],
          color: WidgetTheme.redWhite.backgroundColor,
        ),
        ZMarkerStop(
          stopPoints[2],
          color: WidgetTheme.yellowBlack.backgroundColor,
        ),
        ZMarkerStop(
          stopPoints[3],
          color: kAppBlack,
        )
      ];
    }
  }

  void _fitBounds(List<Location> locations) {
    mapController.fitBounds(
        locations: locations,
        mapHeight: _mapHeight,
        mapWidth: AppQuery(context).width);
  }
}
