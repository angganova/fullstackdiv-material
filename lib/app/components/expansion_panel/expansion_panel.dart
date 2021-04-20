import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/divider/divider.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

enum ExpansionPanelDefaultState {
  open,
  closed,
}

class CustomExpansionPanel extends StatefulWidget {
  ///
  /// This is the custom Expansion Panel
  ///
  const CustomExpansionPanel({
    @required this.title,
    @required this.body,
    this.onTap,
    this.titleColor = kAppBlack,
    this.color = kAppWhite,
    this.iconColor = kAppPrimaryElectricBlue,
    this.defaultState = ExpansionPanelDefaultState.open,
  });

  /// required
  final String title;
  final Widget body;
  final VoidCallback onTap;

  ///optional
  final Color titleColor;
  final Color color;
  final Color iconColor;
  final ExpansionPanelDefaultState defaultState;

  @override
  _CustomExpansionPanelState createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final GlobalKey _bodyKey = GlobalKey();
  double _bodyHeight = kDefaultMargin;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _bodyHeight = _bodyKey.currentContext.size.height +
              AppQuery(context).viewPadding.top +
              AppQuery(context).viewPadding.bottom;
        });
      }
    });

    /// animate panel when first time load the page
    _animationController =
        AnimationController(vsync: this, duration: kDuration300)
          ..addListener(() => setState(() {}));
    if (widget.defaultState == ExpansionPanelDefaultState.closed) {
      _animationController.reverse().whenComplete(() {
        if (mounted) {
          setState(() {
            _bodyHeight = _bodyKey.currentContext.size.height +
                AppQuery(context).viewPadding.top +
                AppQuery(context).viewPadding.bottom;
          });
        }
      });
    } else {
      _animationController.forward().whenComplete(() {
        if (mounted) {
          setState(() {
            _bodyHeight = _bodyKey.currentContext.size.height +
                AppQuery(context).viewPadding.top +
                AppQuery(context).viewPadding.bottom;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: widget.color,
        height: lerpDouble(
          kSpacer.xl,
          kSpacer.xl + _bodyHeight,
          _animationController.value,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap();
                }
                if (_animationController.isCompleted) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
              },
              child: Container(
                padding: kSpacer.edgeInsets.x.standard,
                child: Wrap(
                  children: <Widget>[
                    const AppHDivider(),
                    SizedBox(height: kSpacer.sm),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.title,
                            style: AppTextStyle(color: widget.titleColor)
                                .primaryH4,
                          ),
                        ),
                        Icon(
                          _animationController.isCompleted
                              ? Icons.remove
                              : Icons.add,
                          size: kSmallIconSize,
                          color: widget.iconColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScroll(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  key: _bodyKey,
                  margin: EdgeInsets.symmetric(
                    horizontal: kSecondaryMargin,
                    vertical: kSpacer.standard,
                  ),
                  child: widget.body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
