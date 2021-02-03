import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view.dart';
import 'package:fullstackdiv_material/app/demo/data/demo_fonts_data.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoFontPage extends StatelessWidget {
  /// this is the page where we show all fonts
  /// used inside the app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Fonts',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(
                padding: kSpacer.edgeInsets.x.sm,
                child: BasicListView(
                  children: allFonts(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
