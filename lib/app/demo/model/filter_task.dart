import 'package:flutter/material.dart';

/// this is the object that used for [FilterExpansionPanel] widget
class FilterTask {
  FilterTask({
    @required this.title,
    this.selected = false,
    this.svg,
  });

  String title;
  bool selected;
  String svg;
}
