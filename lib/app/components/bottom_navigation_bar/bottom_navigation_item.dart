import 'package:flutter/material.dart';

/// this is the class of [CustomBottomNavigationItem]
/// which used inside [CustomBottomNavigationBar]
class CustomBottomNavigationItem {
  CustomBottomNavigationItem({
    @required this.icon,
    this.title,
    this.customWidget = const SizedBox(),
    this.route,
    this.arguments,
    this.iconSize,
  });

  final String title;
  final IconData icon;
  final Widget customWidget;
  final String route;
  final Object arguments;
  final double iconSize;
}
