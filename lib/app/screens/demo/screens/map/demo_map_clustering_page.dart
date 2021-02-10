import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/data/model/mapbox/location.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/app/components/map/zmap.dart';
import 'package:fullstackdiv_material/app/components/map/zmap_controller.dart';
import 'package:fullstackdiv_material/app/components/map/marker/zmarker.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_variables.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoMapClusteringPage extends StatefulWidget {
  @override
  _DemoMapClusteringPageState createState() => _DemoMapClusteringPageState();
}

class _DemoMapClusteringPageState extends State<DemoMapClusteringPage> {
  final List<Location> cluster1points = <Location>[
    Location(1.3283494, 103.7732125),
    Location(1.3248313, 103.7515403),
    Location(1.3633009, 103.7457999),
    Location(1.4368245, 103.7613784),
    Location(1.4192604, 103.7075338),
    Location(1.3101426, 103.6671981),
  ];

  final List<Location> cluster2points = <Location>[
    Location(1.305224, 103.784585),
    Location(1.3248313, 103.7515403),
    Location(1.316974, 103.775903),
    Location(1.308111, 103.770749),
  ];

  String get mapBoxUrl =>
      '$mapBoxUrlTemplate?access_token=${getIt<Environments>().getMapBoxToken}';

  List<List<ZMarker>> get _markers {
    return <List<ZMarker>>[
      cluster1points
          .map((Location e) => ZMarker(
                e,
                markerType: MarkerType.restaurant,
              ))
          .toList(),
      cluster2points
          .map((Location e) => ZMarker(e,
              markerType: MarkerType.bus, theme: WidgetTheme.blueWhite))
          .toList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Clustering Example',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Stack(
                children: <Widget>[_map],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _map {
    return ZMap(
      mapController: ZMapController(),
      initialPosition: cluster1points.first,
      initialZoom: 10,
      marketplaceMarkers: _markers,
      maxClusterRadius: kMaxClusterRadius,
      disableClusteringAtZoom: kDisableClusteringZoomLevel,
    );
  }
}
