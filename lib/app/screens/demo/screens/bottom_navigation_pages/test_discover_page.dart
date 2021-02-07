import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoDiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Discover Page',
          textAlign: TextAlign.center,
          style: AppTextStyle(color: kAppPrimaryRed).primaryH2,
        ),
      ),
    );
  }
}
