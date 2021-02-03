import 'package:flutter/material.dart';

class TextColorAnimation extends StatelessWidget {
  const TextColorAnimation({
    @required this.text,
    @required this.textStyle,
    @required this.animation,
  });

  final String text;
  final TextStyle textStyle;
  final Animation<Color> animation;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle.copyWith(color: animation.value),
    );
  }
}
