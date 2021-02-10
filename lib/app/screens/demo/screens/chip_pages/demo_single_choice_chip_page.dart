import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/chip/basic_choice_chip.dart';
import 'package:fullstackdiv_material/app/components/chip/stores/chip_store.dart';
import 'package:fullstackdiv_material/app/components/chip/stores/task.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoSingleChoiceChip extends StatefulWidget {
  @override
  _DemoSingleChoiceChipState createState() => _DemoSingleChoiceChipState();
}

class _DemoSingleChoiceChipState extends State<DemoSingleChoiceChip> {
  /// this is the page where we demonstrate the [SingleChoiceChip]
  /// using the [Chip] component

  final ChipStore taskStore = ChipStore();
  List<Task> tasks = <Task>[
    Task(name: 'Go There', isSelected: false),
    Task(name: 'Book a Table', isSelected: false),
    Task(name: 'Share', isSelected: false),
  ];

  Iterable<Widget> get taskWidgets sync* {
    for (final Task task in tasks) {
      yield Padding(
        padding: kSpacer.edgeInsets.all.xxs,
        child: BasicChoiceChip(
          name: task.name,
          // avatar: task.icon,
          selected: task.isSelected,
          onSelected: (bool value) {
            setState(() {
              taskStore.clearSelection();
              taskStore.toggleIsSelected(task);
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // ignore: prefer_foreach
    for (final Task task in tasks) {
      taskStore.addTask(task);
    }
    taskStore.toggleIsSelectedAt(0);
  }

  @override
  void dispose() {
    taskStore.clearSelection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppWhite,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Single Choice Chip',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: kSpacer.edgeInsets.top.sm,
              child: Row(
                children: taskWidgets.toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
