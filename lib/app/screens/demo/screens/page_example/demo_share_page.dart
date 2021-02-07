import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:fullstackdiv_material/app/components/button/just_text_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/vertical_drawer/vertical_drawer.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoSharePage extends StatefulWidget {
  @override
  _DemoSharePageState createState() => _DemoSharePageState();
}

class _DemoSharePageState extends State<DemoSharePage>
    with TickerProviderStateMixin {
  /// this is the example of page with [VerticalDrawer]
  /// & [Share] feature

  AnimationController _animationController;
  Animation<double> _animation;
  Tween<double> _tween;
  bool _firstLoad = true;
  static const double _minHeight = 200;

  /// screenshot widget to be shared
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    _tween = Tween<double>(begin: 0.0, end: _minHeight);

    /// animate drawer when first time load the page
    _animationController =
        AnimationController(vsync: this, duration: kDuration300);
    _animation = _tween.animate(_animationController);
    _animationController.forward();
    _animationController.addListener(
      () => setState(
        () {
          if (_animation.isCompleted) {
            _firstLoad = false;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                BasicHeader(
                  title: 'Share Page',
                  onBackButtonTapped: () {
                    ExtendedNavigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Screenshot<dynamic>(
            controller: screenshotController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Capture this String',
                  style: AppTextStyle(color: kAppBlack).primaryPL,
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultMargin),
                  child: Image.asset(placeholderAssetImage),
                ),
              ],
            ),
          ),
          VerticalDrawer(
            minHeight: _firstLoad ? _animation.value : _minHeight,
            maxHeight: _firstLoad ? _animation.value : _minHeight,
            panel: Padding(
              padding: kSpacer.edgeInsets.all.xs,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    JustTextButton(
                      title: 'Share',
                      onPressed: () {
                        screenshotController
                            .capture(delay: kDuration10)
                            .then((File image) async {
                          if (image != null) {
                            try {
                              Share.shareFile(image, text: 'Great picture');
                            } on PlatformException catch (e) {
                              print('Exception while taking screenshot:' +
                                  e.toString());
                            }
                          } else {
                            print('image result is null');
                          }
                        }).catchError((dynamic onError) {
                          print(onError);
                        });
                      },
                      textStyle: AppTextStyle(color: kAppPrimaryElectricBlue)
                          .primaryH2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
