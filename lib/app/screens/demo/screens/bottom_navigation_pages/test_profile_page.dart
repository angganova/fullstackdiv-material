import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile Page',
          textAlign: TextAlign.center,
          style: AppTextStyle(color: kAppPrimaryElectricBlue).primaryH2,
        ),
      ),
    );
  }
}
