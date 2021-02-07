import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/demo/components/demo_text_tile.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the list of all the text style

List<Widget> allTextStyle() {
  final AppTextStyle textStyle = AppTextStyle(color: kAppBlack);
  return <Widget>[
    DemoTextItem(name: 'Header 1', style: textStyle.primaryH1),
    DemoTextItem(name: 'Header 2', style: textStyle.primaryH2),
    DemoTextItem(name: 'Header 3', style: textStyle.primaryH3),
    DemoTextItem(name: 'Header 3 Secondary', style: textStyle.secondaryH3),
    DemoTextItem(name: 'Header 4', style: textStyle.primaryH4),
    DemoTextItem(name: 'Paragraph', style: textStyle.primaryP),
    DemoTextItem(name: 'Label 1', style: textStyle.primaryLabel1),
    DemoTextItem(name: 'Label 2', style: textStyle.primaryLabel2),
    DemoTextItem(name: 'Label 3', style: textStyle.primaryLabel3),
    DemoTextItem(name: 'Label 4', style: textStyle.primaryLabel4),
    DemoTextItem(name: 'Label 5', style: textStyle.primaryLabel5),
    DemoTextItem(name: 'Paragraph Large', style: textStyle.primaryPL),
    DemoTextItem(name: 'Paragraph 1', style: textStyle.primaryP1),
    DemoTextItem(name: 'Paragraph 2', style: textStyle.primaryP2),
    DemoTextItem(name: 'Body 1', style: textStyle.primaryB1),
    DemoTextItem(name: 'Body 2', style: textStyle.primaryB3),
    DemoTextItem(name: 'Body 2', style: textStyle.primaryB3),
  ];
}
