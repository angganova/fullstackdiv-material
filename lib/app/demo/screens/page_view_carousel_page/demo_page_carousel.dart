import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/carousel_delimiter/carousel_delimiter.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import 'test_carousel_first_page.dart';

class DemoPageCarousel extends StatefulWidget {
  @override
  _DemoPageCarouselState createState() => _DemoPageCarouselState();
}

class _DemoPageCarouselState extends State<DemoPageCarousel>
    with SingleTickerProviderStateMixin {
  /// this is where we apply the [PageViewCarousel]
  /// with [CarouselDelimiter]

  int _currentIndex = 0;
  AnimationController _animationController;
  ColorTween _tween;
  Animation<Color> _animation;
  bool firstLoad = true;

  /// this is the list of the [PageView] pages
  final List<TestPage> pages = <TestPage>[
    const TestPage(
      color: kAppSecondaryYellow,
      title: 'Discover new places you love',
      content:
          'Get inspired with activities and destinations that match your preference',
    ),
    const TestPage(
      color: kAppSecondaryTeal,
      title: 'Share with your friends & family',
      content:
          'Invite people you love to hang out with and share new experiences together',
    ),
    const TestPage(
      color: kAppPrimaryBrightBlue,
      title: 'Travel better & easier with us',
      content:
          'We suggest the best way to get to your destination based on how you like to move',
    ),
  ];

  /// this is the page controller
  PageController _pageController;

  void resetTween(int page) {
    if (firstLoad) {
      firstLoad = false;
      return;
    }
    _tween.begin = _tween.end;
    _animationController.reset();
    _tween.end = pages[page].color;
  }

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: kDuration500, vsync: this);
    _tween = ColorTween(
        begin: pages[_currentIndex].color, end: pages[_currentIndex + 1].color);
    _animation = _tween.animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    children: pages,
                    onPageChanged: (int page) {
                      resetTween(page);
                      setState(() {
                        _currentIndex = page;
                        _animationController.forward();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultMargin),
                  child: CarouselDelimiter(
                    controller: _pageController,
                    itemCount: pages.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultMargin),
                  child: WideButton(
                    title: 'Go Back',
                    fullWidth: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
