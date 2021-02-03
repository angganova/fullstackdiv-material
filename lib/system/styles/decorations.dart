import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

final BoxShadow kBoxShadow = BoxShadow(
  color: kAppPrimaryDarkShadowHigh,
  offset: Offset(kSpacer.none, 1.0), //(x,y)
  blurRadius: kSpacer.xs,
);

final BoxShadow kPinBoxShadow = BoxShadow(
  color: kAppPrimaryDarkShadowLow.withOpacity(0.16),
  blurRadius: 4,
  offset: const Offset(0, 2),
);
