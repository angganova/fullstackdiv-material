import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoSavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Saved Page',
          textAlign: TextAlign.center,
          style: AppTextStyle(color: kAppSecondaryPink).primaryH2,
        ),
      ),
    );
  }
}
