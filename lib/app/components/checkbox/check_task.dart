import 'package:flutter/material.dart';

/// this is the object that used for Checkbox
class CheckTask {
  CheckTask({
    @required this.title,
    this.subtitle,
    this.selected = false,
  });

  String title;
  String subtitle;
  bool selected;
}
