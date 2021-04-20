import 'package:flutter/cupertino.dart';

class AppRadius {
  static BorderRadius createCircularRadius(double radius) =>
      BorderRadius.all(Radius.circular(radius));
  static BorderRadius createTopCircularRadius(double radius) =>
      BorderRadius.only(
          topLeft: Radius.circular(radius), topRight: Radius.circular(radius));
  static BorderRadius createLeftCircularRadius(double radius) =>
      BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius));
  static BorderRadius createRightCircularRadius(double radius) =>
      BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius));
  static BorderRadius createBotCircularRadius(double radius) =>
      BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius));
  static BorderRadius createExceptBotLeftRadius(
          double radius, double exceptRadius) =>
      BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(exceptRadius));
}
