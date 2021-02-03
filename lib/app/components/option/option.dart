import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view_builder.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'option_task.dart';
import 'option_tile.dart';

/// This is the [Option] class
class Option extends StatelessWidget {
  const Option({
    @required this.list,
    @required this.onTap,
    this.widgetTheme = WidgetTheme.tealWhite,
    this.selected = false,
    this.titleColor = kAppBlack,
    this.subtitleColor = kAppGreyB,
    this.padding = const EdgeInsets.symmetric(horizontal: kDefaultSmallMargin),
    this.radioButtonType = OptionSize.big,
    this.separatorColor,
    this.scrollPhysics,
    this.shrinkWrap = false,
    this.icon,
  });

  /// required
  final List<OptionTask> list;
  final Function(int) onTap;

  /// recommended
  final WidgetTheme widgetTheme;

  /// optional
  final bool selected;
  final Color titleColor;
  final Color subtitleColor;
  final EdgeInsets padding;
  final OptionSize radioButtonType;
  final Color separatorColor;
  final ScrollPhysics scrollPhysics;
  final bool shrinkWrap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BasicListViewBuilder(
      physics: scrollPhysics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemBuilder: (BuildContext context, int index) {
        final OptionTask item = list[index];
        return Column(
          children: <Widget>[
            OptionTile(
              title: item.title,
              subtitle: item.subtitle,
              trailingText: item.trailingText,
              onItemTap: () {
                onTap(index);
              },
              widgetTheme: widgetTheme,
              selected: item.selected,
              titleColor: titleColor,
              subtitleColor: subtitleColor,
              optionSize: radioButtonType,
              useSeparator: separatorColor != null,
              icon: icon,
            ),
            if (separatorColor != null && index < list.length - 1)
              Container(
                color: separatorColor,
                height: 2.0,
              ),
          ],
        );
      },
      itemCount: list.length,
    );
  }
}
