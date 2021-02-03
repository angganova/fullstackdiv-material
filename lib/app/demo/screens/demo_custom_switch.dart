import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/custom_switch/custom_switch.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoCustomSwitch extends StatefulWidget {
  @override
  _DemoCustomSwitchState createState() => _DemoCustomSwitchState();
}

class _DemoCustomSwitchState extends State<DemoCustomSwitch> {
  /// this is the page to show [CustomSwitch]
  /// inside the app

  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BasicHeader(
              title: 'Custom Switch',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: CustomSwitch(
                inactiveIcon: Icons.close,
                activeIcon: Icons.brightness_1_outlined,
                onTap: (bool active) {
                  setState(() {
                    _isActive = active;
                  });
                },
                active: _isActive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
