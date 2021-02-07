import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [TextHeader] class
/// this is one of the Header used in the app
/// this class only contains Text Widget
class TextHeader extends StatelessWidget {
  const TextHeader({
    @required this.title,
    this.titleStyle,
    this.maxLines = 100,
    this.minLines = 1,
    this.titleColor = kAppBlack,
    this.top,
  });

  /// required
  final String title;

  ///optional
  final Color titleColor;
  final int maxLines;
  final TextStyle titleStyle;

  /// If you want to force text to n lines use this min line
  final int minLines;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? AppSpacer(context: context).xxl,
        left: kDefaultMargin,
        right: kDefaultMargin,
        bottom: AppSpacer(context: context).standard,
      ),
      child: buildText(context),
    );
  }

  Widget buildText(BuildContext context) {
    String customTitle = title;

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints size) {
      final TextSpan span = TextSpan(
          text: customTitle,
          style: AppTextStyle(color: titleColor, context: context).primaryH1);
      final TextPainter tp = TextPainter(
          text: span, maxLines: maxLines, textDirection: TextDirection.ltr);
      tp.layout(maxWidth: size.maxWidth);

      /// Calculate how many lines will be generated
      final List<LineMetrics> lines = tp.computeLineMetrics();
      final int numberOfLines = lines.length;

      /// Append new line to match min line
      if (numberOfLines < minLines) {
        for (int i = 0; i < minLines - numberOfLines; i++) {
          customTitle += '\n';
        }
      }

      TextStyle style = AppTextStyle(
        color: titleColor,
        context: context,
      ).primaryH1;
      if (tp.didExceedMaxLines) {
        style = AppTextStyle(
          color: titleColor,
          context: context,
        ).primaryH2;
      }
      return Text(
        customTitle,
        style: titleStyle ?? style,
      );
    });
  }
}
