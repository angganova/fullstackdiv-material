import 'package:flutter/material.dart';

/// this is the object that used for [Option] widget
class OptionTask {
  OptionTask({
    @required this.title,
    this.subtitle,
    this.selected = false,
    this.trailingText,
  });

  String title;
  String subtitle;
  bool selected;
  String trailingText;
}
