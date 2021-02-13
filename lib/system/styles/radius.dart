import 'package:flutter/cupertino.dart';

class AppRadius {
  static BorderRadius createCircularRadius(double radius) =>
      BorderRadius.all(Radius.circular(radius));
  static BorderRadius createBotCircularRadius(double radius) =>
      BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius));
}
