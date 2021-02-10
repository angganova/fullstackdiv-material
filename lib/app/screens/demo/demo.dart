import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/card/basic_card.dart';
import 'package:fullstackdiv_material/app/components/grid_view/basic_grid_view_count.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import 'data/demo_page_data.dart';

class DemoHomeView extends StatelessWidget {
  /// this is the main menu of the demo page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Component Gallery',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: BasicGridViewCount(
                childAspectRatio: 1 / 1.1,
                crossAxisCount: 2,
                children: mainDemoCardList
                    .map((PageCard pageCard) => BasicWideCard(
                          image: placeholderAssetImage,
                          title: pageCard.title,
                          subtitle: pageCard.subtitle,
                          onCardTap: () => ExtendedNavigator.of(context)
                              .push(pageCard.route),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
