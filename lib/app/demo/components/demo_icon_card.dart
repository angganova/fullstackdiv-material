import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoIconCard extends StatelessWidget {
  /// this is the component to help build the UI to show all the icons

  const DemoIconCard({
    @required this.name,
    this.icon,
  });

  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final TextStyle _defaultStyle =
        AppTextStyle(color: kAppPrimaryElectricBlue).primaryLabel3;

    return Container(
      padding: kSpacer.edgeInsets.y.xs,
      width: AppQuery(context).width * 0.22,
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 16,
          ),
          SizedBox(
            height: kSpacer.xxs,
          ),
          Text(
            name,
            style: _defaultStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kSpacer.xxs,
          ),
        ],
      ),
    );
  }
}
