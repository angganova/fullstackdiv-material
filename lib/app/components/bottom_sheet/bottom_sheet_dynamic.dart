import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/large_button.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the example of [BottomSheet]
/// with Title & 2 Action Buttons
class BottomSheetDynamic extends StatelessWidget {
  const BottomSheetDynamic(
      {this.child,
      this.title,
      this.confirmButtonTitle,
      this.cancelButtonTitle,
      this.confirmCallback,
      this.cancelCallback,
      this.confirmWidgetTheme = WidgetTheme.blueWhite,
      this.cancelWidgetTheme = WidgetTheme.whiteBlue,
      this.titleColor = kAppBlack,
      this.descriptionColor = kAppBlack,
      this.padding});

  /// recommended
  final Widget child;
  final WidgetTheme confirmWidgetTheme;
  final WidgetTheme cancelWidgetTheme;

  /// optional
  final String title;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final VoidCallback confirmCallback;
  final VoidCallback cancelCallback;
  final Color titleColor;
  final Color descriptionColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.fromLTRB(
            kDefaultMargin,
            56.0,
            kDefaultMargin,
            kDefaultMargin,
          ),
      child: SingleChildScroll(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null)
              Text(
                title,
                style: AppTextStyle(color: titleColor).primaryH2,
              ),
            if (child != null)
              Padding(
                padding: const EdgeInsets.only(top: kDefaultMargin),
                child: child,
              )
            else
              const SizedBox(height: 6.0),
            if (confirmButtonTitle != null && cancelButtonTitle != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultMargin,
                ),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                ),
              )
            else if (confirmButtonTitle != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultMargin,
                ),
                child: LargeButton(
                  title: confirmButtonTitle,
                  widgetTheme: WidgetTheme.blueWhite,
                  onPressed: confirmCallback,
                ),
              )
            else if (confirmButtonTitle != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultMargin,
                ),
                child: LargeButton(
                  title: cancelButtonTitle,
                  onPressed: cancelCallback,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
