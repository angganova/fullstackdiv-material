import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

export 'bottom_sheet_informational.dart';

/// this is the [Function] to show [CustomBottomSheet] with its child
///
/// NOTE : Bottom Sheet is NOT Scrollable
void showCustomBottomSheet({
  /// required
  BuildContext context,
  Widget child,

  /// optional
  bool isDismissible = true,
  Color barrierColor,
  Color backgroundColor = kAppWhite,
}) {
  showModalBottomSheet<dynamic>(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    elevation: 0.0,
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor ?? kAppGreyA.withOpacity(kExtentZeroPoint6),
    builder: (BuildContext context) => Container(
      margin: EdgeInsets.fromLTRB(
        kSpacer.standard,
        kSpacer.standard,
        kSpacer.standard,
        AppQuery(context).kDefaultBottomMargin,
      ),
      child: CustomBottomSheet(
        child: child,
        backgroundColor: backgroundColor,
      ),
    ),
  );
}

/// this is the Main Class for [BottomSheet]
class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    @required this.child,
    this.backgroundColor = kAppWhite,
  });

  /// required
  final Widget child;

  /// optional
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ShadowStrokeStyles(
      shadowStrokeType: ShadowStrokeType.highShadow,
      padding: kSpacer.edgeInsets.all.none,
      radius: kBorderRadiusSmall,
      color: backgroundColor,
      child: child,
    );
  }
}
