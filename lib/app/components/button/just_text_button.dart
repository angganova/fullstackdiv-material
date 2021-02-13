import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class JustTextButton extends StatelessWidget {
  /// this is the [JustTextButton] type class
  /// [title] is required

  const JustTextButton({
    @required this.title,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    this.textColor = kAppPrimaryElectricBlue,
    this.selectedTextColor = kAppBlack,
    this.disableTextColor = kAppGreyC,
    this.textStyle,
  });

  /// required
  final String title;

  /// recommended
  final EdgeInsets padding;

  /// optional
  final VoidCallback onPressed;
  final Color textColor;
  final Color selectedTextColor;
  final Color disableTextColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      title: title,
      onPressed: onPressed,
      shadowStrokeType: ShadowStrokeType.none,
      widgetTheme: WidgetTheme.clearPrimary,
      padding: padding,
      textStyle: textStyle ??
          AppTextStyle(context: context, color: textColor).primaryB2,
      radius: 0.0,
    );
  }
}
