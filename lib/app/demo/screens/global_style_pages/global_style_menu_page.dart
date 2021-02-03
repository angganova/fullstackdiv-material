import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/card/basic_card.dart';
import 'package:fullstackdiv_material/app/components/grid_view/basic_grid_view_count.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/demo/data/demo_controller_data.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class GlobalStyleMenu extends StatelessWidget {
  /// this is the main menu of the global styles

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Global Styles',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: BasicGridViewCount(
                childAspectRatio: 1 / 1.1,
                crossAxisCount: 2,
                children: List<Widget>.generate(globalStyleControllers.length,
                    (int index) {
                  return BasicWideCard(
                    image: placeholderAssetImage,
                    title: globalStyleControllers[index].title,
                    subtitle: globalStyleControllers[index].subtitle,
                    onCardTap: () => ExtendedNavigator.of(context)
                        .push(globalStyleControllers[index].child),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
