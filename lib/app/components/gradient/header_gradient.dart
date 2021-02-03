import 'package:flutter/material.dart';

class HeaderGradient extends StatelessWidget {
  const HeaderGradient({this.height = 95, this.width = double.infinity});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0),
          end: const Alignment(0, 1),
          colors: <Color>[
            Colors.white,
            Colors.white.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}
