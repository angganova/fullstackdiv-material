import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/spacer/space_view.dart';
import 'package:fullstackdiv_material/app/screens/demo/demo.dart';
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/app/screens/notification/notification_view.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_page_transition.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = getIt<HomeViewModel>();

  BuildContext _widgetBuildContext;
  AppQuery _appQuery;
  AppSpacer _appSpacer;
  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appQuery ??= AppQuery(context);
    _appSpacer ??= AppSpacer(context: context);

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

  Widget get _contentView => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WideButton(
            title: 'Open Demo',
            widgetTheme: WidgetTheme.whiteBlue,
            onPressed: () => Navigator.of(context)
                .push<dynamic>(FadeRoute(page: DemoHomeView())),
          ),
          SpaceView(
            height: _appSpacer.standard,
          ),
          WideButton(
            title: 'Open Notification Tester',
            widgetTheme: WidgetTheme.blueWhite,
            onPressed: () => Navigator.of(context)
                .push<dynamic>(FadeRoute(page: NotificationView())),
          ),
        ],
      );

  void _initPlatformState() {
    _viewModel.widgetInitState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.widgetPostFrame(_widgetBuildContext);
      WidgetsBinding.instance.addObserver(_viewModel.widgetLifeCycleObserver);
    });
  }
}
