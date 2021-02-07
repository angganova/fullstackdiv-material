import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/rating/rating.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoRating extends StatelessWidget {
  /// this is the page where we show the rating component
  /// with a customizable rating count to be used inside the app
  ///

  final int ratingCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppSecondaryYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Rating Example',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: kDefaultMargin),
                    child: Rating(
                      ratingCount: ratingCount,
                      onRated: (int rated) {
                        showPublicToast(
                          msg: 'Rating: $rated/$ratingCount',
                          fontSize:
                              AppTextStyle(color: kAppWhite).primaryP.fontSize,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
