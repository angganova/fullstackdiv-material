import 'package:flutter/material.dart';

/// this is the class to support the Main Menu in the [demo.dart]

class Controller {
  Controller({this.title, this.subtitle, @required this.child});

  String title;
  String subtitle;
  String child;
}
