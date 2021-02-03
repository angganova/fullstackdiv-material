import 'package:flutter/material.dart';

/// this is the class model to support action_sheet
class ActionChild {
  ActionChild({@required this.title, this.icon, this.onChildTap});

  String title;
  IconData icon;
  VoidCallback onChildTap;
}
