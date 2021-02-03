import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/app/components/chip/basic_choice_chip.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/app/demo/data/demo_chips_data.dart';
import 'package:fullstackdiv_material/app/demo/model/demo_category.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoChipsPage extends StatefulWidget {
  @override
  State createState() => DemoChipsPageState();
}

class DemoChipsPageState extends State<DemoChipsPage> {
  final List<String> _filters = <String>[];

  Iterable<Widget> get categoryWidgets sync* {
    for (final CategoriesEntry category in categoryList) {
      yield Padding(
        padding: kSpacer.edgeInsets.all.xxs,
        child: BasicChoiceChip(
          name: category.name,
          // avatar: Icons.user,
          selected: _filters.contains(category.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(category.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == category.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BasicHeader(
              title: 'Chips',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: kSpacer.edgeInsets.symmetric(x: 'sm'),
                child: Wrap(
                  children: categoryWidgets.toList(),
                ),
              ),
            ),
            Padding(
              padding: kSpacer.edgeInsets.right.sm,
              child: Container(
                margin: kSpacer.edgeInsets.bottom.xs,
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomIconButton(
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        showPublicToast(
                          msg: (_filters.isNotEmpty)
                              ? _filters.join(', ')
                              : 'No Chip Selected',
                          fontSize:
                              AppTextStyle(color: kAppWhite).primaryP.fontSize,
                        );
                      },
                      widgetTheme: WidgetTheme.blueWhite,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
