import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ImageMarker extends StatelessWidget {
  const ImageMarker({Key key, this.image, this.angle, this.edgeInsets}) : super(key: key);

  final String image;
  final EdgeInsets edgeInsets;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (angle ?? 0.0) * pi / 180,
      child: Container(
        padding: edgeInsets ?? kSpacer.edgeInsets.all.none,
        key: const Key('pin'),
        height: kPinSize,
        width: kPinSize,
        child: FittedBox(
          child: Image.asset(
            image,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
