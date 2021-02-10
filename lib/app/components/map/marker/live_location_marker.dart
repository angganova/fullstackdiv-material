import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class LiveLocationMarker extends StatefulWidget {
  const LiveLocationMarker({Key key, this.radius, this.inactive = false})
      : super(key: key);

  final double radius;
  final bool inactive;

  @override
  _LiveLocationMarkerState createState() => _LiveLocationMarkerState();
}

class _LiveLocationMarkerState extends State<LiveLocationMarker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// glowing radius
        Container(
          decoration: BoxDecoration(
            color: widget.inactive
                ? kAppGreyA.withOpacity(0.16)
                : kAppPrimaryElectricBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),

        /// compass direction
        if (!widget.inactive)
          StreamBuilder<CompassEvent>(
            stream: FlutterCompass.events,
            builder:
                (BuildContext context, AsyncSnapshot<CompassEvent> snapshot) {
              if (snapshot.hasData) {
                final int direction = snapshot.data.heading.toInt();
                if (direction == null) {
                  print('No sensor available');
                  return Container();
                }
                return RotationTransition(
                  turns: AlwaysStoppedAnimation<double>(direction / 360),
                  child: _compassWidget,
                );
              } else
                return Container();
            },
          ),

        /// blue dot user location point
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.inactive ? kAppGreyA : kAppPrimaryElectricBlue,
                border: Border.all(color: kAppWhite, width: 3),
                boxShadow: <BoxShadow>[kPinBoxShadow]),
          ),
        )
      ],
    );
  }

  Widget get _compassWidget {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 0.15 * widget.radius),
              child: ClipPath(
                child: Container(
                  width: widget.radius,
                  height: 0.8 * widget.radius,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                        kAppMapRadiusColor.withOpacity(0.62),
                        kAppMapRadiusColor.withOpacity(0.0)
                      ])),
                ),
                clipper: CompassClipPath(),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CompassClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
