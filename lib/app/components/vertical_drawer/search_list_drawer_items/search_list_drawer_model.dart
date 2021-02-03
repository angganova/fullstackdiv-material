import 'package:flutter/material.dart';

/// this it the item type which define which type of tile you want to use
enum ListType {
  km,
  min,
  taxi,
}

/// this is the List Category Class
/// to build the ListView with Category
class ListCategory {
  ListCategory({
    @required this.name,
    @required this.list,
    @required this.listType,
  });

  ///required
  String name;
  List<ListItemModel> list;
  ListType listType;
}

/// this is the List Category Item Class
class ListItemModel {
  ListItemModel({
    @required this.title,
    this.image,
    this.icon,
    this.detail,
    this.description,
    this.value,
    this.valueDescription,
    this.trailingButtonIcon,
  });

  ///required
  String title;

  ///optional
  ///
  /// if both not null, image will be chosen
  String image;
  IconData icon;

  /// the text below the title
  String detail;
  String description;

  /// the value & it's required
  String value;

  /// the car type value & it's required when you choose [ListType.taxi]
  String valueDescription;
  IconData trailingButtonIcon;
}
