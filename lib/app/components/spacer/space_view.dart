import 'package:flutter/widgets.dart';

class SpaceView extends StatelessWidget {
  const SpaceView({Key key, this.width, this.height}) : super(key: key);

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 0,
      height: height ?? 0,
    );
  }
}
