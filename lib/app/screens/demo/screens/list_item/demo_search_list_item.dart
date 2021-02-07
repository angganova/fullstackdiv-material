import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/vertical_drawer/vertical_drawer.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoSearchListItem extends StatelessWidget {
  /// this is the example of page with [SearchListItem]

  final List<ListCategory> _list = <ListCategory>[
    ListCategory(
      name: 'Frequently Visited',
      list: <ListItemModel>[
        ListItemModel(
          title: 'Flutter',
          detail: 'S0',
          image: placeholderAssetImage,
          value: '20',
        ),
        ListItemModel(
          title: 'Flutter',
          detail: 'S0',
          icon: Icons.home,
          value: '20',
        ),
        ListItemModel(
          title: 'Flutter',
          detail: 'S0',
          icon: Icons.location_on,
          value: '20',
        ),
      ],
      listType: ListType.min,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Search List Item',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultMargin),
              child: SearchDrawerListView(
                list: _list,
                onItemTap: (int index) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
