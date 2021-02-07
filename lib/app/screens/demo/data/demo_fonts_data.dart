import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/demo/components/demo_text_tile.dart';

/// this is the list of all the fonts

List<Widget> allFonts() {
  return <Widget>[
    DemoTextItem(name: 'Poppins Regular'),
    DemoTextItem(name: 'Poppins-Italic', fontStyle: FontStyle.italic),
    DemoTextItem(name: 'Poppins-Light', fontWeight: FontWeight.w300),
    DemoTextItem(name: 'Poppins-Medium', fontWeight: FontWeight.w500),
    DemoTextItem(name: 'Poppins-Semibold', fontWeight: FontWeight.w600),
    DemoTextItem(name: 'Poppins-Bold', fontWeight: FontWeight.w700),
  ];
}
