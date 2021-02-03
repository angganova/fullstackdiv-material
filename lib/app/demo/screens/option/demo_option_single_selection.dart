import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/option/option.dart';
import 'package:fullstackdiv_material/app/components/option/option_task.dart';
import 'package:fullstackdiv_material/app/components/option/option_tile.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoOptionSingleSelection extends StatefulWidget {
  @override
  _DemoOptionSingleSelectionState createState() =>
      _DemoOptionSingleSelectionState();
}

class _DemoOptionSingleSelectionState extends State<DemoOptionSingleSelection> {
  /// this is the page where we show checkbox
  /// with single selection
  /// that used inside the app

  final List<OptionTask> _tasks = <OptionTask>[
    OptionTask(title: 'Option', subtitle: 'Description'),
    OptionTask(title: 'Option', trailingText: '\$1.50'),
    OptionTask(
        title: 'Option', subtitle: 'Description', trailingText: '\$1.50'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppWhite,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Option',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScroll(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: kSpacer.edgeInsets.all.xs,
                      color: kAppBlack,
                      child: Text(
                        'Big Option :',
                        style: AppTextStyle(color: kAppWhite).primaryLabel1,
                      ),
                    ),
                    Option(
                      list: _tasks,
                      onTap: (int index) {
                        setState(() {
                          for (final OptionTask t in _tasks) {
                            t.selected = false;
                          }
                          _tasks[index].selected = true;
                        });
                      },
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                    Container(
                      padding: kSpacer.edgeInsets.all.xs,
                      color: kAppBlack,
                      child: Text(
                        'Small Option :',
                        style: AppTextStyle(color: kAppWhite).primaryLabel1,
                      ),
                    ),
                    Option(
                      list: _tasks,
                      onTap: (int index) {
                        setState(() {
                          for (final OptionTask t in _tasks) {
                            t.selected = false;
                          }
                          _tasks[index].selected = true;
                        });
                      },
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      radioButtonType: OptionSize.small,
                    ),
                    Container(
                      padding: kSpacer.edgeInsets.all.xs,
                      color: kAppBlack,
                      child: Text(
                        'Small Option With Separator :',
                        style: AppTextStyle(color: kAppWhite).primaryLabel1,
                      ),
                    ),
                    Option(
                      list: _tasks,
                      onTap: (int index) {
                        setState(() {
                          for (final OptionTask t in _tasks) {
                            t.selected = false;
                          }
                          _tasks[index].selected = true;
                        });
                      },
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      radioButtonType: OptionSize.small,
                      separatorColor: kAppGreyD,
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
