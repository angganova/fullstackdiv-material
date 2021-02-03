import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_item/basic_list_item.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view_builder.dart';
import 'package:fullstackdiv_material/app/components/vertical_drawer/vertical_drawer.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoBasicListItem extends StatelessWidget {
  /// this is the example of page with [BasicListItem]

  final List<ListItemModel> _list = <ListItemModel>[
    ListItemModel(
      title: 'Flutter',
      detail: 'S0',
      image: 'https://picsum.photos/200?0',
      value: '20',
      valueDescription: 'km',
    ),
    ListItemModel(
      title: 'Flutter',
      detail: 'S0',
      icon: Icons.home,
      value: '20',
      valueDescription: 'min',
      trailingButtonIcon: Icons.more,
    ),
    ListItemModel(
      title: 'Flutter',
      detail: 'S0',
      icon: Icons.location_on,
      value: '20',
      trailingButtonIcon: Icons.more,
    ),
    ListItemModel(
      title: '10% off rides until Christmas',
      detail: 'Expires 25 Dec, 2020',
      icon: Icons.attach_money,
      description: 'Terms apply',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Basic List Item',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultMargin),
              child: BasicListViewBuilder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: kDefaultMargin),
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  final ListItemModel item = _list[index];
                  if (index == 0) {
                    return Padding(
                      padding: kSpacer.edgeInsets.bottom.xs,
                      child: GestureDetector(
                        onTap: () {},
                        child: BasicListItem(
                          title: item.title,
                          subtitle: item.detail,
                          description: item.description,
                          cachedImage: item.image,
                          icon: item.icon,
                          trailingTitle: item.value,
                          trailingSubtitle: item.valueDescription,
                          trailingButtonIcon: item.trailingButtonIcon,
                          onTrailingIconButton: () {},
                          shadowStrokeType: ShadowStrokeType.medShadow,
                          padding: AppSpacer(context: context).edgeInsets.only(
                                left: 'xs',
                                top: 'xs',
                                bottom: 'xs',
                                right: 'sm',
                              ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: kSpacer.edgeInsets.bottom.xs,
                      child: GestureDetector(
                        onTap: () {},
                        child: BasicListItem(
                          title: item.title,
                          subtitle: item.detail,
                          description: item.description,
                          image: item.image,
                          icon: item.icon,
                          trailingTitle: item.value,
                          trailingSubtitle: item.valueDescription,
                          trailingButtonIcon: item.trailingButtonIcon,
                          onTrailingIconButton: () {},
                          shadowStrokeType: ShadowStrokeType.medShadow,
                          padding: AppSpacer(context: context).edgeInsets.only(
                                left: 'xs',
                                top: 'xs',
                                bottom: 'xs',
                                right: 'sm',
                              ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
