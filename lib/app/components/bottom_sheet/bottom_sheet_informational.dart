import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/large_button.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the example of [BottomSheet] for Type : Informational
/// with Title, Description, & Action Buttons
class BottomSheetInformational extends StatelessWidget {
  const BottomSheetInformational({
    @required this.title,
    @required this.description,
    this.confirmButtonTitle,
    this.cancelButtonTitle,
    this.confirmCallback,
    this.cancelCallback,
    this.confirmWidgetTheme = WidgetTheme.blueWhite,
    this.cancelWidgetTheme = WidgetTheme.whiteBlue,
    this.titleColor = kAppBlack,
    this.descriptionColor = kAppBlack,
  });

  /// required
  final String title;
  final String description;

  /// recommended
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final VoidCallback confirmCallback;
  final VoidCallback cancelCallback;
  final WidgetTheme confirmWidgetTheme;
  final WidgetTheme cancelWidgetTheme;

  /// optional
  final Color titleColor;
  final Color descriptionColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kDefaultMargin),
        child: SingleChildScroll(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTextStyle(
                  color: titleColor,
                  context: context,
                ).primaryH3,
              ),
              SizedBox(
                height: kSpacer.sm,
              ),
              Text(
                description,
                style: AppTextStyle(
                  color: descriptionColor,
                  context: context,
                ).primaryP1,
              ),
              const SizedBox(
                height: kDefaultMargin * 2,
              ),
              if (confirmButtonTitle != null && cancelButtonTitle != null)
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: <Widget>[
                      LargeButton(
                        title: confirmButtonTitle,
                        widgetTheme: WidgetTheme.blueWhite,
                        onPressed: confirmCallback,
                      ),
                      SizedBox(
                        width: kSpacer.xs,
                      ),
                      LargeButton(
                        title: cancelButtonTitle,
                        onPressed: cancelCallback,
                      )
                    ],
                  ),
                )
              else if (confirmButtonTitle != null)
                LargeButton(
                  title: confirmButtonTitle,
                  widgetTheme: WidgetTheme.blueWhite,
                  onPressed: confirmCallback,
                )
              else if (cancelButtonTitle != null)
                LargeButton(
                  title: cancelButtonTitle,
                  onPressed: cancelCallback,
                ),
            ],
          ),
        ));
  }
}
