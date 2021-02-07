import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/demo/components/demo_color_tile.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is where we list all the colors

List<Widget> allColors() {
  return <Widget>[
    const DemoColorItem(
      name: 'App Electric Blue',
      color: kAppPrimaryElectricBlue,
      code: '#0000FE',
    ),
    const DemoColorItem(
      name: 'App Bright Blue',
      color: kAppPrimaryBrightBlue,
      code: '#70C6FF',
    ),
    const DemoColorItem(
      name: 'App Burgundy',
      color: kAppPrimaryBurgundy,
      code: '#C42375',
    ),
    const DemoColorItem(
      name: 'App Orange',
      color: kAppPrimaryOrange,
      code: '#F68237',
    ),
    const DemoColorItem(
      name: 'App Red',
      color: kAppPrimaryRed,
      code: '#FF5354',
    ),
    const DemoColorItem(
      name: 'App Teal',
      color: kAppSecondaryTeal,
      code: '#49DCDA',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App Yellow',
      color: kAppSecondaryYellow,
      code: '#FFDB3B',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App Pink',
      color: kAppSecondaryPink,
      code: '#EF8EBF',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App UI Friendly Orange',
      color: kAppFriendlyOrange,
      code: '#E05800',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App UI Friendly Red',
      color: kAppFriendlyRed,
      code: '#E31617',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App UI Friendly Teal',
      color: kAppFriendlyTeal,
      code: '#168E96',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App Black',
      color: kAppBlack,
      code: '#161616',
    ),
    const DemoColorItem(
      name: 'App Grey A',
      color: kAppGreyA,
      code: '#484848',
    ),
    const DemoColorItem(
      name: 'App Grey B',
      color: kAppGreyB,
      code: '#797979',
    ),
    const DemoColorItem(
      name: 'App Grey C',
      color: kAppGreyC,
      code: '#C7C7C7',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App Grey D',
      color: kAppGreyD,
      code: '#EEEEEE',
      textColor: kAppBlack,
    ),
    const DemoColorItem(
      name: 'App White',
      color: kAppWhite,
      code: '#FFFFFF',
      textColor: kAppBlack,
    ),
  ];
}
