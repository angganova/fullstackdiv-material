import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/small_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ContainerShimmerPage extends StatelessWidget {
  /// this is the example of page with [ShimmerView]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Container Shimmer',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ShimmerView(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: AppQuery(context).width / 1.5,
                            height: kSpacer.md,
                            color: kAppBlack,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultMargin,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: ShimmerView(
                            child: SmallButton(
                              title: 'App There',
                              widgetTheme: WidgetTheme.darkGreyWhite,
                              icon: Icons.brightness_1_rounded,
                              iconSize: kSmallIconSize,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultMargin,
                        ),
                        Flexible(
                          child: ShimmerView(
                            child: SmallButton(
                              title: 'Book Table',
                              widgetTheme: WidgetTheme.darkGreyWhite,
                              icon: Icons.brightness_1_rounded,
                              iconSize: kSmallIconSize,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
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
