import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import 'search_list_drawer_listview.dart';
import 'search_list_drawer_model.dart';

class SearchListBuilder extends StatelessWidget {
  const SearchListBuilder({
    @required this.list,
    this.scrollController,
    this.onItemTap,
  });

  /// required
  final List<ListCategory> list;

  /// optional
  final ScrollController scrollController;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    if (scrollController != null)
      return SingleChildScroll(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultMargin),
          child: SearchDrawerListView(
            list: list,
            onItemTap: onItemTap ?? (int index) {},
          ),
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultMargin),
        child: SearchDrawerListView(
          list: list,
          onItemTap: onItemTap ?? (int index) {},
        ),
      );
  }
}
