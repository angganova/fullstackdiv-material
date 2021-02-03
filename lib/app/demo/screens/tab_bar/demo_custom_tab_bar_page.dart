import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/custom_switch/custom_switch.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/tab_bar/custom_tab_bar.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoCustomTabBarPage extends StatefulWidget {
  @override
  _DemoCustomTabBarPageState createState() => _DemoCustomTabBarPageState();
}

class _DemoCustomTabBarPageState extends State<DemoCustomTabBarPage>
    with TickerProviderStateMixin {
  /// this is the page to show [CustomSwitch]
  /// inside the app

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BasicHeader(
              title: 'Custom Tab Bar',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            CustomTabBar(
              controller: _tabController,
              tabs: const <Tab>[
                Tab(
                  text: 'First',
                ),
                Tab(
                  text: 'Second',
                ),
                Tab(
                  text: 'Third',
                ),
                Tab(
                  text: 'Fourth',
                ),
                Tab(
                  text: 'Five',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
