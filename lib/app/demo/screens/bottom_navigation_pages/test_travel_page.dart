import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoTravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Travel Page',
          textAlign: TextAlign.center,
          style: AppTextStyle(color: kAppGreyA).primaryH2,
        ),
      ),
    );
  }
}
