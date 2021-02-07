import 'package:flutter/widgets.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
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

    return Builder(builder: (BuildContext _context) {
      _widgetBuildContext ??= _context;
      return Container(
        alignment: Alignment.center,
        width: _appQuery.width,
        child: _contentView,
      );
    });
  }

  Widget get _contentView => Column(
        children: const <Widget>[
          WideButton(
            title: 'Open Demo',
            widgetTheme: WidgetTheme.whiteBlue,
          ),
          WideButton(
            title: 'Open Notification Tester',
            widgetTheme: WidgetTheme.blueWhite,
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
