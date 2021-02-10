import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// GroupMarker is marker that represent collection of items
/// This marker is different from [ClusterMarker]
class GroupMarker extends StatelessWidget {
  const GroupMarker(
      {Key key, this.markerCount, this.edgeInsets, this.highlighted = false})
      : super(key: key);

  final String markerCount;
  final EdgeInsets edgeInsets;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ?? kSpacer.edgeInsets.all.none,
      child: Container(
        width: kCusterPinWidth,
        height: kPinSize,
        child: Stack(
          key: const Key('pin'),
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: kPinSize - (highlighted ? 10 : 0),
                height: kPinSize,
                child: FittedBox(
                  child: Image.asset(
                    highlighted
                        ? 'assets/icons/pins/pin_shape_blue.png'
                        : 'assets/icons/pins/pin_shape_white.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: kSpacer.edgeInsets.top.sm,
              child: Icon(
                Icons.card_giftcard,
                color: highlighted
                    ? kAppWhite
                    : kAppPrimaryElectricBlue.withOpacity(0.6),
                size: kPinIconSize,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: kCusterPinBadgeSize,
                height: kCusterPinBadgeSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kAppWhite,
                    boxShadow: <BoxShadow>[kPinBoxShadow]),
                child: Text(
                  markerCount,
                  style: AppTextStyle(color: kAppBlack).primaryH4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
