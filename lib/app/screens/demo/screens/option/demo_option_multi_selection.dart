import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/option/option.dart';
import 'package:fullstackdiv_material/app/components/option/option_task.dart';
import 'package:fullstackdiv_material/app/components/option/option_tile.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoOptionMultiSelection extends StatefulWidget {
  @override
  _DemoOptionMultiSelectionState createState() =>
      _DemoOptionMultiSelectionState();
}

class _DemoOptionMultiSelectionState extends State<DemoOptionMultiSelection> {
  /// this is the page where we show checkbox
  /// with multi selection
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
                          _tasks[index].selected = !_tasks[index].selected;
                        });
                      },
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      icon: Icons.check,
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
                          _tasks[index].selected = !_tasks[index].selected;
                        });
                      },
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      radioButtonType: OptionSize.small,
                      icon: Icons.check,
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
                          _tasks[index].selected = !_tasks[index].selected;
                        });
                      },
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      radioButtonType: OptionSize.small,
                      separatorColor: kAppGreyD,
                      icon: Icons.check,
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
