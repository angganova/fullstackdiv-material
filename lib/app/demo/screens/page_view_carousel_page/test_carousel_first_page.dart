import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/text_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is just a [TestPage] to support [DemoPageCarousel]
class TestPage extends StatelessWidget {
  const TestPage({
    @required this.color,
    @required this.title,
    @required this.content,
  });

  /// required
  /// NOTE : the color used in the parent
  final Color color;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppClearWhite,
      body: Column(
        children: <Widget>[
          TextHeader(title: title),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment(0, .7),
                    image: AssetImage('assets/demo/intro.png'),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                kDefaultMargin, kSpacer.xxs, kDefaultMargin, kDefaultMargin),
            padding: EdgeInsets.symmetric(
                vertical: kSpacer.sm, horizontal: kSpacer.md),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: AppTextStyle(color: kAppBlack).primaryPL,
            ),
          ),
        ],
      ),
    );
  }
}
