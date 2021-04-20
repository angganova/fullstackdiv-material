import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/divider/divider.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import 'action_child.dart';

export 'action_child.dart';

/// this is the example of [ActionSheet]
/// with Title & ListView
class ActionSheet extends StatelessWidget {
  const ActionSheet({
    @required this.title,
    @required this.children,
    this.titleColor = kAppBlack,
    this.childrenColor = kAppPrimaryElectricBlue,
  });

  /// required
  final String title;
  final List<ActionChild> children;

  /// optional
  final Color titleColor;
  final Color childrenColor;

  Iterable<Widget> get childWidgets sync* {
    for (final ActionChild child in children) {
      yield GestureDetector(
        onTap: child.onChildTap,
        child: Container(
          color: kAppClearWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: kSpacer.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (child.icon != null)
                      Padding(
                        padding: kSpacer.edgeInsets.right.sm,
                        child: Icon(
                          child.icon,
                          size: kSmallIconSize,
                          color: childrenColor,
                        ),
                      ),
                    Flexible(
                      child: Text(
                        child.title,
                        maxLines: 1,
                        style: AppTextStyle(color: childrenColor).primaryPL,
                      ),
                    ),
                  ],
                ),
              ),
              const AppHDivider(),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            kDefaultMargin, kDefaultMargin, kDefaultMargin, kSpacer.lg),
        child: SingleChildScroll(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultMargin),
                child: Text(
                  title,
                  style: AppTextStyle(color: titleColor).primaryH3,
                ),
              ),
              const AppHDivider(),
              Column(
                children: childWidgets.toList(),
              ),
            ],
          ),
        ));
  }
}
