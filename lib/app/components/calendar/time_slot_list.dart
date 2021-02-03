import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/chip/basic_choice_chip.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:jiffy/jiffy.dart';

class TimeSlotList extends StatefulWidget {
  const TimeSlotList({this.list, this.selectedIndex, this.onChange});

  final List<DateTime> list;
  final int selectedIndex;
  final Function(DateTime, int) onChange;

  @override
  _TimeSlotListState createState() => _TimeSlotListState();
}

class _TimeSlotListState extends State<TimeSlotList>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _listButton = List<Widget>.generate(
      widget.list.length,
      (int index) {
        final String time = Jiffy(widget.list[index]).jm.toLowerCase();
        final bool selected = widget.selectedIndex == index;
        return Padding(
          padding: kSpacer.edgeInsets.left.xxs,
          child: BasicChoiceChip(
            padding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: kSpacer.sm,
            ),
            textStyle: AppTextStyle(color: kAppBlack).primaryLabel2,
            widgetTheme: WidgetTheme.whiteBlack,
            selectedWidgetTheme: WidgetTheme.blueWhite,
            shadowStrokeType: ShadowStrokeType.stroke2px,
            name: time,
            selected: selected,
            onSelected: (bool onSelected) {
              widget.onChange(widget.list[index], index);
            },
          ),
        );
      },
    );

    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(-kSpacer.xxs, kSpacer.none),
          child: SingleChildScroll(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: kSpacer.edgeInsets.x.standard,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ..._listButton,
                  SizedBox(
                    width: kSpacer.sm,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
