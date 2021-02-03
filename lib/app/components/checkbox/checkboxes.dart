import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view_builder.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import 'check_task.dart';
import 'checkbox_tile.dart';

export 'check_task.dart';

/// This is the custom [Checkbox] class
class Checkboxes extends StatelessWidget {
  const Checkboxes({
    @required this.list,
    @required this.onTap,
    this.widgetTheme = WidgetTheme.whiteBlue,
    this.selected = false,
    this.titleColor,
    this.subtitleColor,
    this.padding,
  });

  /// required
  final List<CheckTask> list;
  final Function(int) onTap;

  /// recommended
  final WidgetTheme widgetTheme;

  /// optional
  final bool selected;
  final Color titleColor;
  final Color subtitleColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return BasicListViewBuilder(
      padding: padding,
      itemBuilder: (BuildContext context, int index) {
        final CheckTask item = list[index];
        return CheckboxItem(
          title: item.title,
          subtitle: item.subtitle,
          onItemTap: () {
            onTap(index);
          },
          widgetTheme: widgetTheme,
          selected: item.selected,
          titleColor: titleColor ?? kAppBlack,
          subtitleColor: subtitleColor ?? kAppBlack,
        );
      },
      itemCount: list.length,
    );
  }
}
