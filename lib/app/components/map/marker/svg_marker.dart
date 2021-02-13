import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class SvgMarker extends StatelessWidget {
  const SvgMarker({Key key, this.image, this.theme, this.highlighted = false})
      : super(key: key);

  final String image;
  final WidgetTheme theme;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kSpacer.edgeInsets.all.none,
      child: Container(
        width: kPinSize,
        height: kPinSize,
        child: Stack(
          key: const Key('pin'),
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: kPinSize - (highlighted ? 10 : 0),
                height: kPinSize,
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 18),
                child: SvgPicture.asset(image))
          ],
        ),
      ),
    );
  }
}
