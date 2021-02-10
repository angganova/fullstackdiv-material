import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// Map Marker Widget for Transportation Stop point
class StopMarker extends StatelessWidget {
  const StopMarker({
    Key key,
    @required this.color,
    this.size = kPolylineStopPinSize,
    this.borderColor = kAppWhite,
  }) : super(key: key);

  final Color color;
  final Color borderColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(color: borderColor, width: 3),
                boxShadow: <BoxShadow>[kPinBoxShadow]),
          ),
        )
      ],
    );
  }
}
