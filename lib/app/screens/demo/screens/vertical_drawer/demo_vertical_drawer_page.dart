import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fullstackdiv_material/app/screens/demo/screens/bottom_navigation_pages/test_discover_page.dart';
import 'package:fullstackdiv_material/app/screens/demo/screens/bottom_navigation_pages/test_profile_page.dart';
import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/bottom_navigation_item.dart';
import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/stores/bottom_nav_store.dart';
import 'package:fullstackdiv_material/app/components/button/small_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_item/status_bar_list_item.dart';
import 'package:fullstackdiv_material/app/components/overlay_box/overlay_box.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DemoVerticalDrawerPage extends StatefulWidget {
  @override
  _DemoVerticalDrawerPageState createState() => _DemoVerticalDrawerPageState();
}

class _DemoVerticalDrawerPageState extends State<DemoVerticalDrawerPage>
    with SingleTickerProviderStateMixin {
  /// this is the page where we show the example of [VerticalDrawer]
  /// with [CustomBottomNavigationBar]

  int _currentIndex = 0;

  /// this is the list of the navigation bar items
  final List<CustomBottomNavigationItem> navBarItems =
      <CustomBottomNavigationItem>[
    CustomBottomNavigationItem(
      icon: Icons.brightness_1_rounded,
      title: 'Travel',
    ),
    CustomBottomNavigationItem(
      icon: Icons.brightness_2,
      title: 'Discover',
    ),
    CustomBottomNavigationItem(
      icon: Icons.brightness_1_outlined,
      title: 'Profile',
    ),
  ];

  /// this is the list of the [PageView] controllers
  List<Widget> childPages;

  /// this is the page controller
  PageController _pageController;

  /// this is the animation controller
  AnimationController _animationController;
  Animation<Offset> _animation;

  /// this to determine whether the status bar hide or show
  bool _showStatusBar = true;
  bool _showStatusBarButton = true;

  @override
  void initState() {
    /// set the animation to animate hide/show
    /// Bottom Navigation Bar
    _animationController = AnimationController(
      vsync: this,
      duration: kDuration300,
    );
    _animation = Tween<Offset>(
      begin: kStartOffsetY,
      end: kEndOffsetY,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: kEaseOut,
      reverseCurve: kEaseIn,
    ));
    _animationController.forward();

    super.initState();

    /// initiate Page Controller
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
    ///
    /// add Provider in here to handle the Bottom Navigation state
    /// through its children
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<BottomNavStore>(
          create: (_) => BottomNavStore(),
        )
      ],

      ///
      ///
      /// wrap this in Observer so this widget can change state through its child
      child: Observer(builder: (BuildContext context) {
        ///
        ///
        /// set the child pages for Page View
        setChildPages(context);

        ///
        ///
        /// check if we should hide or show the bottom navigation
        checkBottomNavigationStatus(context);

        return Scaffold(
          body: Column(
            children: <Widget>[
              if (_currentIndex > 0)
                SafeArea(
                  child: BasicHeader(
                    title: navBarItems[_currentIndex].title,
                    onBackButtonTapped: () {
                      ExtendedNavigator.of(context).pop();
                    },
                  ),
                ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    PageView(
                      controller: _pageController,
                      children: childPages,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentIndex = page;
                        });
                      },
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    Visibility(
                      visible: _showStatusBarButton,
                      child: SafeArea(
                        child: Align(
                          alignment: _currentIndex > 0
                              ? Alignment.topCenter
                              : Alignment.topRight,
                          child: Padding(
                            padding: _currentIndex > 0
                                ? kSpacer.edgeInsets.all.none
                                : AppSpacer(context: context).edgeInsets.only(
                                      right: 'xs',
                                      top: 'sm',
                                    ),
                            child: SmallButton(
                              shadowStrokeType: ShadowStrokeType.lowShadow,
                              title: 'Hide/Show Status Bar',
                              onPressed: () {
                                setState(() {
                                  _showStatusBar = !_showStatusBar;
                                });

                                if (_showStatusBar) {
                                  context
                                      .read<BottomNavStore>()
                                      .showStatusBar();
                                } else {
                                  context
                                      .read<BottomNavStore>()
                                      .hideStatusBar();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animation,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            if (_showStatusBar)
                              const Positioned.fill(
                                child: OverlayBox(
                                  height: double.infinity,
                                  endAlignment: Alignment(0.0, -0.3),
                                ),
                              ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (_showStatusBar)
                                  ShadowStrokeStyles(
                                    shadowStrokeType:
                                        ShadowStrokeType.medShadow,
                                    radius: kSpacer.none,
                                    padding: kSpacer.edgeInsets.all.none,
                                    child: SingleChildScroll(
                                      scrollDirection: Axis.horizontal,
                                      padding: kSpacer.edgeInsets.all.none,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: AppSpacer(context: context)
                                                .standard,
                                          ),
                                          Padding(
                                            padding:
                                                kSpacer.edgeInsets.right.xs,
                                            child: const StatusBarListItem(
                                              image:
                                                  'assets/icons/taxi/taxi_car.png',
                                              title: 'CDG Taxi',
                                              subtitle: 'RIDE IN PROGRESS',
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                kSpacer.edgeInsets.right.xs,
                                            child: const StatusBarListItem(
                                              image:
                                                  'assets/icons/taxi/taxi_car.png',
                                              title: 'CDG Taxi',
                                              subtitle: 'RIDE IN PROGRESS',
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                kSpacer.edgeInsets.right.xs,
                                            child: const StatusBarListItem(
                                              image:
                                                  'assets/icons/taxi/taxi_car.png',
                                              title: 'CDG Taxi',
                                              subtitle: 'RIDE IN PROGRESS',
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                kSpacer.edgeInsets.right.xs,
                                            child: const StatusBarListItem(
                                              image:
                                                  'assets/icons/taxi/taxi_car.png',
                                              title: 'CDG Taxi',
                                              subtitle: 'RIDE IN PROGRESS',
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                kSpacer.edgeInsets.right.xs,
                                            child: const StatusBarListItem(
                                              image:
                                                  'assets/icons/taxi/taxi_car.png',
                                              title: 'CDG Taxi',
                                              subtitle: 'RIDE IN PROGRESS',
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                AppSpacer(context: context).sm,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                CustomBottomNavigationBar(
                                  onTap: (int index) {
                                    ///returns tab id which is user tapped
                                    setState(() {
                                      _currentIndex = index;
                                    });

                                    /// the reason why we use [jumpToPage] in here
                                    /// is because if we use [animateToPage]
                                    /// the navigation will have a weird behavior
                                    /// when jumping from for example 0 to 2 or 3 to 1
                                    /// you can uncomment this if you want to try :
                                    /// pageController.animateToPage(index, duration: kDuration100, curve: Curves.easeIn);

                                    _pageController.jumpToPage(index);
                                  },
                                  currentIndex: _currentIndex,
                                  items: navBarItems,
                                  useGradientBox: !_showStatusBar,
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
            ],
          ),
        );
      }),
    );
  }

  void setChildPages(BuildContext context) {
    childPages = <Widget>[
      DemoProfilePage(),
      DemoDiscoverPage(),
      DemoProfilePage(),
    ];
  }

  void checkBottomNavigationStatus(BuildContext context) {
    if (context.watch<BottomNavStore>().bottomNavHidden) {
      _animationController.reverse();
      _showStatusBarButton = false;
    } else {
      _animationController.forward();
      _showStatusBarButton = true;
    }
  }
}
