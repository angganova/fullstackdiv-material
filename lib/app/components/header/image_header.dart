import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

enum ImageHeaderType {
  normal,
  colorful,
}

/// this is the [ImageHeader] class
/// this is one of the Header used in the app
/// this class contains Text & Image Widget
class ImageHeader extends StatelessWidget {
  const ImageHeader({
    @required this.title,
    @required this.assetImage,
    this.backgroundColor = kAppWhite,
    this.titleColor,
    this.imageHeaderType = ImageHeaderType.normal,
    this.topPadding,
  });

  /// required
  final String title;
  final String assetImage;

  /// optional
  final Color backgroundColor;
  final Color titleColor;
  final ImageHeaderType imageHeaderType;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      margin: EdgeInsets.only(
        bottom: imageHeaderType == ImageHeaderType.normal
            ? kSpacer.none
            : kSpacer.sm,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: topPadding ??
                (imageHeaderType == ImageHeaderType.normal
                    ? kSpacer.none
                    : kSpacer.lg),
          ),
          Stack(
            children: <Widget>[
              Container(
                padding: kSpacer.edgeInsets.left.standard,
                child: Row(
                  children: <Widget>[
                    Expanded(child: buildText(context)),
                    Container(
                      width: 0.5 * AppQuery(context).width,
                      child: AspectRatio(
                        aspectRatio: 2.1,
                        child: Image.asset(
                          assetImage,
                          fit: BoxFit.cover,
                          color: kAppClearWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (imageHeaderType == ImageHeaderType.colorful)
                Positioned.fill(
                  child: SizedBox(
                    width: AppQuery(context).width,
                    child: Image.asset(
                      assetImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              else if (imageHeaderType == ImageHeaderType.normal)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 0.62 * AppQuery(context).width,
                    child: AspectRatio(
                      aspectRatio: 2.4,
                      child: Image.asset(
                        assetImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints size) {
      final TextSpan span = TextSpan(
          text: title,
          style: AppTextStyle(color: titleColor, context: context).primaryH2);
      final TextPainter tp = TextPainter(
          text: span, maxLines: 1, textDirection: TextDirection.ltr);
      tp.layout(maxWidth: size.maxWidth);

      final TextStyle style = AppTextStyle(
        color: titleColor,
        context: context,
      ).primaryH2;
      return Text(
        title,
        style: style,
      );
    });
  }
}
