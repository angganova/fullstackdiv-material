import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fullstackdiv_material/app/components/chip/icon_star_text_choice_chip.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoIconStarChipsPage extends StatefulWidget {
  @override
  State createState() => DemoIconStarChipsPageState();
}

class DemoIconStarChipsPageState extends State<DemoIconStarChipsPage> {
  int _filters = 0;
  List<int> stars = <int>[1, 2, 3, 4, 5];

  Iterable<Widget> get categoryWidgets sync* {
    for (final int star in stars) {
      yield Padding(
        padding: kSpacer.edgeInsets.all.xxs,
        child: IconStarTextChoiceChip(
          // avatar: Icons.user,
          selected: _filters == star,
          numberStar: star,
          iconSize: kSmallIconSize,
          iconColor: kAppRatingStarColor,
          iconSelectedColor: kAppRatingStarColor,
          shadowStrokeType: ShadowStrokeType.stroke2px,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters = star == _filters ? 0 : star;
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
              title: 'Icon Star Chips',
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
          ],
        ),
      ),
    );
  }
}
