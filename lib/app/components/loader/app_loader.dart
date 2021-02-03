import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    this.stopLoad = false,
    this.color,
    this.backdropColor,
    this.bottomPadding = 0.0,
    this.iconSize = 80,
  });

  final bool stopLoad;
  final Color color;
  final Color backdropColor;
  final double bottomPadding;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: AppQuery(context).width,
            height: AppQuery(context).height - bottomPadding,
            color: backdropColor ?? kAppWhite.withOpacity(0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
