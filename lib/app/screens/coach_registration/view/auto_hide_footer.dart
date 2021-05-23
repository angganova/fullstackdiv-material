import 'package:flutter/material.dart';

class AppAutoHideFooter extends StatefulWidget {
  const AppAutoHideFooter({
    Key key,
    @required this.parentContext,
    @required this.child,
  }) : super(key: key);
  final BuildContext parentContext;
  final Widget child;
  @override
  _AppAutoHideFooterState createState() => _AppAutoHideFooterState();
}

class _AppAutoHideFooterState extends State<AppAutoHideFooter> {
  @override
  Widget build(BuildContext context) {
    bool shouldShow;
    if (widget.parentContext == null) {
      shouldShow = false;
    } else {
      shouldShow =
          (MediaQuery.of(widget.parentContext).viewInsets.bottom == 0) ?? false;
    }
    return Visibility(
      visible: shouldShow,
      maintainState: true,
      maintainSize: false,
      maintainAnimation: true,
      child: widget.child,
    );
  }
}

class AppAutoHide2Button extends StatelessWidget {
  final BuildContext parentContext;
  final Widget firstButton;
  final Widget secondButton;
  final bool expanded;
  final EdgeInsets padding;

  const AppAutoHide2Button(
      {Key key,
      this.firstButton,
      this.secondButton,
      this.expanded,
      this.parentContext,
      this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppAutoHideFooter(
      parentContext: parentContext,
      child: Container(
        color: Colors.white,
        padding: padding ?? const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (expanded ?? true)
                  Expanded(child: firstButton)
                else
                  firstButton,
                Container(
                  height: 24,
                ),
                if (expanded ?? true)
                  Expanded(child: secondButton)
                else
                  secondButton,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppAutoHideFooterSpace extends StatelessWidget {
  const AppAutoHideFooterSpace({Key key, this.parentContext}) : super(key: key);
  final BuildContext parentContext;
  @override
  Widget build(BuildContext context) {
    return AppAutoHideFooter(
      parentContext: parentContext,
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
      ),
    );
  }
}
