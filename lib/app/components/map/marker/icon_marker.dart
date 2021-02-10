import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class IconMarker extends StatelessWidget {
  const IconMarker(
      {Key key, this.icon, this.color, this.theme, this.edgeInsets})
      : super(key: key);

  final IconData icon;
  final Color color;
  final WidgetTheme theme;
  final EdgeInsets edgeInsets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ?? kSpacer.edgeInsets.all.none,
      child: Container(
        width: kPinSize,
        height: kPinSize,
        child: Stack(
          key: const Key('pin'),
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: kPinSize,
                height: kPinSize,
                child: FittedBox(
                  child: Image.asset(
                    theme.pinImage,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: kSpacer.edgeInsets.top.sm,
              child: Icon(
                icon,
                color: color ?? theme.pinForegroundColor,
                size: kPinIconSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
