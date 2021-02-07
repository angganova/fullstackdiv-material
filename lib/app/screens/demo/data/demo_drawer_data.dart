import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/vertical_drawer/vertical_drawer.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

final List<ListCategory> categoryDrawerList = <ListCategory>[
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
      ListItemModel(
        title: 'Flutter',
        detail: 'S0',
        image: placeholderAssetImage,
        value: '20',
      ),
      ListItemModel(
        title: 'Flutter',
        detail: 'S0',
        image: placeholderAssetImage,
        value: '20',
      ),
      ListItemModel(
        title: 'Flutter',
        detail: 'S0',
        image: placeholderAssetImage,
        value: '20',
      ),
      ListItemModel(
        title: 'Flutter',
        detail: 'S0',
        image: placeholderAssetImage,
        value: '20',
      ),
    ],
    listType: ListType.min,
  ),
];
