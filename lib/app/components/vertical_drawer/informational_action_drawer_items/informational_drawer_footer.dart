import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/large_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class InfoDrawerFooter extends StatelessWidget {
  const InfoDrawerFooter({
    this.confirmButtonTitle,
    this.cancelButtonTitle,
    this.onConfirmTap,
    this.onCancelTap,
  });

  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final VoidCallback onConfirmTap;
  final VoidCallback onCancelTap;

  @override
  Widget build(BuildContext context) {
    if (confirmButtonTitle != null && cancelButtonTitle != null)
      return FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          children: <Widget>[
            LargeButton(
              title: confirmButtonTitle,
              widgetTheme: WidgetTheme.whiteBlue,
              onPressed: onConfirmTap,
            ),
            SizedBox(
              width: kSpacer.xs,
            ),
            LargeButton(
              title: cancelButtonTitle,
              widgetTheme: WidgetTheme.whiteRed,
              onPressed: onCancelTap,
            )
          ],
        ),
      );
    else if (confirmButtonTitle != null)
      return LargeButton(
        title: confirmButtonTitle,
        widgetTheme: WidgetTheme.whiteBlue,
        onPressed: onConfirmTap,
      );
    else if (cancelButtonTitle != null)
      return LargeButton(
        title: cancelButtonTitle,
        widgetTheme: WidgetTheme.whiteRed,
        onPressed: onCancelTap,
      );
    else
      return Container();
  }
}
