import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/screens/demo/data/demo_cards_data.dart';

class DemoCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Cards',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                children: allCards(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
