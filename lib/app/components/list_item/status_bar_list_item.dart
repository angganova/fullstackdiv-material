import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class StatusBarListItem extends StatelessWidget {
  /// this is the [StatusBarListItem]
  /// with [Image], [Title], [Subtitle]
  const StatusBarListItem({
    @required this.title,
    @required this.subtitle,
    @required this.image,
    this.imageFit = BoxFit.contain,
    this.backgroundColor = kAppWhite,
    this.onTap,
  });

  /// required
  final String title;
  final String subtitle;
  final String image;

  /// optional
  final BoxFit imageFit;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppSpacer _zigSpacer = AppSpacer(context: context);
    return Padding(
      padding: _zigSpacer.edgeInsets.y.xs,
      child: GestureDetector(
        onTap: onTap,
        child: ShadowStrokeStyles(
          radius: AppQuery(context).radius,
          color: backgroundColor,
          shadowStrokeType: ShadowStrokeType.lowShadow,
          padding: EdgeInsets.fromLTRB(
            kSpacer.xs,
            _zigSpacer.xs,
            _zigSpacer.xxl,
            _zigSpacer.xs,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (image.contains('assets'))
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Image.asset(
                    image,
                    fit: imageFit,
                    width: _zigSpacer.md,
                    height: _zigSpacer.md,
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Image.network(
                    image,
                    fit: imageFit,
                    width: _zigSpacer.md,
                    height: _zigSpacer.md,
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subtitle,
                    style: AppTextStyle(
                      color: kAppBlack.withOpacity(kExtentZeroPoint5),
                    ).primaryLabel3,
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    title,
                    style: AppTextStyle(color: kAppBlack).primaryLabel2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
