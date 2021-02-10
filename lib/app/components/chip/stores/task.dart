import 'package:flutter/material.dart';

class Task {
  Task({this.name, this.icon, this.isSelected = false});

  final String name;
  final IconData icon;
  bool isSelected;
}
