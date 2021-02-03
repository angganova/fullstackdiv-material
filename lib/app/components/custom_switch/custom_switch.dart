import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [CustomSwitch]
class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    @required this.inactiveIcon,
    @required this.activeIcon,
    @required this.onTap,
    this.inactiveColor = kAppGreyB,
    this.activeColor = kAppPrimaryElectricBlue,
    this.inactiveBackground = kAppGreyD,
    this.activeBackground = kAppPrimaryElectricBlue,
    this.active = false,
  });

  /// required
  final IconData inactiveIcon;
  final IconData activeIcon;
  final Function(bool) onTap;

  /// optional
  final Color inactiveColor;
  final Color activeColor;
  final Color inactiveBackground;
  final Color activeBackground;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!active),
      onPanUpdate: (DragUpdateDetails details) {
        if (details.delta.dx > 0 && !active ||
            details.delta.dx <= 0 && active) {
          onTap(!active);
        }
      },
      child: Container(
        width: 68.0,
        decoration: BoxDecoration(
          color: active ? activeBackground : inactiveBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(AppQuery(context).radius),
          ),
        ),
        child: AnimatedAlign(
          alignment: active ? Alignment.centerRight : Alignment.centerLeft,
          curve: kZestEaseOut,
          duration: kDuration300,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(AppQuery(context).radius),
            child: ShadowStrokeStyles(
              padding: kSpacer.edgeInsets.all.xxs,
              shadowStrokeType: ShadowStrokeType.medShadow,
              child: SizedBox(
                width: kSpacer.md,
                height: kSpacer.md,
                child: Container(
                  decoration: BoxDecoration(
                    color: kAppWhite,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppQuery(context).radius),
                    ),
                  ),
                  child: Icon(
                    active ? activeIcon : inactiveIcon,
                    size: kSmallIconSize,
                    color: active ? activeColor : inactiveColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
