import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/map/marker_helper.dart';
import 'package:fullstackdiv_material/app/components/map/marker/marker_type.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class MapLoadingIndicator extends StatefulWidget {
  @override
  _MapLoadingIndicatorState createState() => _MapLoadingIndicatorState();
}

class _MapLoadingIndicatorState extends State<MapLoadingIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;

  final double _circleSize = 252;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: kDuration200, vsync: this);
    animation =
        Tween<double>(begin: 0, end: _circleSize).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _circleSize + kPinSize,
      height: _circleSize + kPinSize,
      child: Container(
        width: animation.value,
        height: animation.value,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: animation.value > 2 ? animation.value - 2 : 0,
              height: animation.value > 2 ? animation.value - 2 : 0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kAppMapRadarColor.withOpacity(0.17),
              ),
            ),
            SizedBox(
              height: animation.value,
              width: animation.value,
              child: const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(kAppPrimaryElectricBlue),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: createImageMarker(MarkerType.origin.image),
            ),
          ],
        ),
      ),
    );
  }
}
