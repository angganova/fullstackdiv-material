import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/app/components/checkbox/checkboxes.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoCheckboxPage extends StatefulWidget {
  @override
  _DemoCheckboxPageState createState() => _DemoCheckboxPageState();
}

class _DemoCheckboxPageState extends State<DemoCheckboxPage> {
  /// this is the page where we show checkbox
  /// with multiple selection
  /// that used inside the app

  final List<CheckTask> _tasks = <CheckTask>[
    CheckTask(title: 'title 1', subtitle: 'sub'),
    CheckTask(title: 'title 2'),
    CheckTask(title: 'title 3', subtitle: 'sub'),
    CheckTask(title: 'title 4'),
    CheckTask(title: 'title 5', subtitle: 'sub'),
  ];
  final List<String> _filterTaskTitle = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppWhite,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Checkbox',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: kSpacer.edgeInsets.top.xs,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: kSpacer.edgeInsets.x.standard,
                      child: Checkboxes(
                        list: _tasks,
                        onTap: (int index) {
                          setState(() {
                            _tasks[index].selected = !_tasks[index].selected;
                            if (_tasks[index].selected)
                              _filterTaskTitle.add(_tasks[index].title);
                            else
                              _filterTaskTitle.remove(_tasks[index].title);
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: kSpacer.edgeInsets.only(
                          right: 'sm',
                          bottom: 'sm',
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CustomIconButton(
                              widgetTheme: WidgetTheme.blueWhite,
                              shadowStrokeType: ShadowStrokeType.lowShadow,
                              icon: Icons.brightness_1_outlined,
                              onPressed: () {
                                showPublicToast(
                                  msg: (_filterTaskTitle.isNotEmpty)
                                      ? _filterTaskTitle.join(', ')
                                      : 'No Task Selected',
                                  fontSize: AppTextStyle(color: kAppWhite)
                                      .primaryP
                                      .fontSize,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
