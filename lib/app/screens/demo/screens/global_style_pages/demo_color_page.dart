import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view.dart';
import 'package:fullstackdiv_material/app/screens/demo/data/demo_color_data.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoColorPage extends StatelessWidget {
  /// this is the page where we show all colors
  /// that used inside the app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppWhite,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Colors',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: BasicListView(
                children: allColors(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
