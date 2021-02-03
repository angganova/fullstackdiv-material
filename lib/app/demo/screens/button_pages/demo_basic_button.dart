import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view.dart';
import 'package:fullstackdiv_material/app/demo/data/demo_buttons_data.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoButtonsPage extends StatelessWidget {
  /// this is the page to show all kind of buttons
  /// inside the app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BasicHeader(
              title: 'Basic Buttons',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: BasicListView(
                children: allButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
