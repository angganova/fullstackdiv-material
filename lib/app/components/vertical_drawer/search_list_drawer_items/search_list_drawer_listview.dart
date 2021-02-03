import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/list_item/basic_list_item.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view_builder.dart';
import 'package:fullstackdiv_material/app/components/vertical_drawer/search_list_drawer_items/search_list_drawer_model.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [SearchDrawerListView] which show a ListView
/// with a [Category] Name as the Header
class SearchDrawerListView extends StatelessWidget {
  const SearchDrawerListView({
    @required this.list,
    @required this.onItemTap,
  });

  /// required
  final List<ListCategory> list;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _categoryListView.toList(),
    );
  }

  List<Widget> get _categoryListView {
    final List<Widget> items = <Widget>[];
    for (final ListCategory category in list) {
      items.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 34.0),
            Text(
              category.name.toUpperCase(),
              style: AppTextStyle(color: kAppGreyB).primaryLabel1,
            ),
            const SizedBox(height: kDefaultMargin),
            BasicListViewBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: kDefaultMargin),
              itemCount: category.list.length,
              itemBuilder: (BuildContext context, int index) {
                final ListItemModel item = category.list[index];
                return GestureDetector(
                  onTap: () => onItemTap(index),
                  child: BasicListItem(
                    title: item.title,
                    subtitle: item.detail,
                    image: item.image,
                    icon: item.icon,
                    trailingTitle: item.value,
                    trailingSubtitle:
                        category.listType == ListType.km ? 'km' : 'min',
                    trailingButtonIcon: Icons.more,
                    onTrailingIconButton: () {},
                  ),
                );
              },
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      );
    }
    return items;
  }
}
