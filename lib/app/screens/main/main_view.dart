import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/convex_bar.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_view.dart';
import 'package:fullstackdiv_material/app/screens/home/home_view.dart';
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/app/screens/test/epub_viewer.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  final HomeViewModel _viewModel = getIt<HomeViewModel>();

  List<ConvexTabModel> _mainTabItems;
  List<ConvexTabModel> _childItems;
  TabController _mainTabController;

  BuildContext _widgetBuildContext;
  AppQuery _appQuery;
  AppSpacer _appSpacer;
  AppTextStyle _appTextStyle;

  int notificationUnreadCount = 0;

  int _currentMainTabIndex = 0;
  int _currentChildTabIndex = 0;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appQuery ??= AppQuery(context);
    _appSpacer ??= AppSpacer(context: context);
    _appTextStyle ??= AppTextStyle(context: context);

    return Scaffold(
      body: Builder(builder: (BuildContext _context) {
        _widgetBuildContext ??= _context;
        return SafeArea(
          child: Container(
            alignment: Alignment.center,
            width: _appQuery.width,
            height: _appQuery.height,
            child: _contentView,
          ),
        );
      }),
    );
  }

  Widget get _contentView => Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: _appQuery.width,
            height: _appQuery.height,
          ),
          Positioned.fill(
              child: Container(
            padding: const EdgeInsets.only(bottom: 60),
            child: tabView,
          )),
          _bottomNavigationBarView
        ],
      );

  Widget get _bottomNavigationBarView => AppConvexBar(
        mainTabItems: _mainTabItems,
        mainTabBgColor: const Color(0xFF98E3D6),
        mainTabIconActiveColor: const Color(0xFF004777),
        mainTabIconInactiveColor: const Color(0xFF004777),
        mainTabController: _mainTabController,
        onMainTabChange: (int index) {
          setState(() => _currentMainTabIndex = index);
        },
        childTabItems: _childItems,
        childTabBgColor: const Color(0xFFd8f9f5),
        childTabIconActiveColor: const Color(0xFF004777),
        childTabIconInactiveColor: const Color(0xFF004777),
        onChildTabChange: (int index) {
          setState(() => _currentChildTabIndex = index);
        },
      );

  Widget get tabView {
    final int ignoredIndex = _childItems.length ~/ 2;

    if (_currentChildTabIndex != ignoredIndex) {
      switch (_currentChildTabIndex) {
        // case 0:
        //   return HomeView();
        // case 1:
        //   return EpubViewerView();
        default:
          return Container(
            alignment: Alignment.center,
            child: Text(
              _childItems[_currentChildTabIndex].title,
              style: _appTextStyle.primaryH2,
            ),
          );
      }
    } else {
      switch (_currentMainTabIndex) {
        case 0:
          return HomeView();
        case 1:
          return EpubViewerView();
        case 4:
          return CoachRegistrationView();
        default:
          return Container(
            alignment: Alignment.center,
            child: Text(
              _mainTabItems[_currentMainTabIndex].title,
              style: _appTextStyle.primaryH2,
            ),
          );
      }
    }
  }

  void incrementNotification() {
    debugPrint('XXX incrementNotification');
    notificationUnreadCount++;
    setState(() {
      _mainTabItems
          .firstWhere((ConvexTabModel element) =>
              element.title.ignoreCase('Notification'))
          .badgeText = notificationUnreadCount.toString();
    });
  }

  void _initPlatformState() {
    _viewModel.widgetInitState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.widgetPostFrame(_widgetBuildContext);
      WidgetsBinding.instance.addObserver(_viewModel.widgetLifeCycleObserver);
    });

    _childItems = <ConvexTabModel>[
      ConvexTabModel(
          iconActive: Icons.local_play_rounded,
          iconInactive: Icons.local_play_outlined,
          title: 'Social'),
      ConvexTabModel(
        iconActive: Icons.book_rounded,
        iconInactive: Icons.book_outlined,
        title: 'Summaries',
      ),
      ConvexTabModel(
        iconActive: Icons.brightness_1,
        iconInactive: Icons.brightness_1_outlined,
        title: '',
      ),
      ConvexTabModel(
        iconActive: Icons.label_important_outlined,
        iconInactive: Icons.label_important_outline,
        title: 'Courses',
      ),
      ConvexTabModel(
        iconActive: Icons.video_collection_rounded,
        iconInactive: Icons.video_collection_outlined,
        title: 'Video',
      ),
    ];

    _mainTabItems = <ConvexTabModel>[
      ConvexTabModel(
          iconActive: Icons.home,
          iconInactive: Icons.home_outlined,
          title: 'Home'),
      ConvexTabModel(
        iconActive: Icons.favorite,
        iconInactive: Icons.favorite_border,
        title: 'Favorites',
      ),
      ConvexTabModel(
          iconActive: Icons.brightness_1,
          iconInactive: Icons.brightness_1_outlined,
          title: ''),
      ConvexTabModel(
          iconActive: Icons.notifications,
          iconInactive: Icons.notifications_none,
          title: 'Notification'),
      ConvexTabModel(
        iconActive: Icons.person,
        iconInactive: Icons.person_outline,
        title: 'Profile',
      ),
    ];

    _mainTabController = TabController(
        vsync: this,
        length: _mainTabItems.length,
        initialIndex: _mainTabItems.length ~/ 2);

    _currentChildTabIndex = _childItems.length ~/ 2;
  }
}
