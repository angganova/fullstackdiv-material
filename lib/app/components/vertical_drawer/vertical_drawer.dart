import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/divider/divider.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

import 'helpers/panel.dart';

export 'helpers/panel.dart';
export 'informational_action_drawer_items/informational_drawer_footer.dart';
export 'informational_action_drawer_items/informational_drawer_header.dart';
export 'search_list_drawer_items/search_list_drawer_builder.dart';
export 'search_list_drawer_items/search_list_drawer_header.dart';
export 'search_list_drawer_items/search_list_drawer_listview.dart';
export 'search_list_drawer_items/search_list_drawer_model.dart';

enum AnimationDirection {
  up,
  down,
  middle,
  fullscreen,
}

/// this is the Main Class for [VerticalDrawer]
/// to do the Vertical Slide Up Drawer/Panel
class VerticalDrawer extends StatelessWidget {
  const VerticalDrawer({
    this.header,
    this.panel,
    this.panelBuilder,
    this.footer,
    this.shadowStrokeType = ShadowStrokeType.drawer,
    this.backgroundColor = kAppWhite,

    /// real value or in percentage
    this.minHeight = kDefaultMinHeight,

    /// in percentage
    this.snapPoint,

    /// real value or in percentage
    this.maxHeight = kExtentZeroPoint93,

    /// panel recognition
    this.onPanelSlide,
    this.onFinishSliding,
    this.onPanelClosed,
    this.onPanelMiddle,
    this.onPanelOpened,
    this.panelController,
    this.defaultPanelState,
    this.fullScreen = false,
    this.draggable = true,
    this.removeLine = false,
    this.footerUseSafeArea = true,
    this.backdropEnabled = false,
    this.onBackdropTap,
    this.backdropOpacityFollowSlide = false,
    this.backdropSlideUpEnabled = false,
    this.parallaxEnabled = false,
    this.backdropColor = kAppBlack,
    this.backdropOpacity = kExtentZeroPoint1,
  });

  /// recommended
  final Widget header;
  final Widget panel;
  final Widget Function(ScrollController) panelBuilder;
  final Widget footer;
  final ShadowStrokeType shadowStrokeType;

  /// optional
  final Color backgroundColor;
  final double minHeight;
  final double snapPoint;
  final double maxHeight;
  final Function(double, double) onPanelSlide;
  final Function(double) onFinishSliding;
  final VoidCallback onPanelClosed;
  final VoidCallback onPanelMiddle;
  final VoidCallback onPanelOpened;
  final PanelController panelController;
  final PanelState defaultPanelState;
  final bool fullScreen;
  final bool draggable;
  final bool removeLine;
  final bool footerUseSafeArea;
  final bool backdropEnabled;
  final VoidCallback onBackdropTap;
  final bool backdropOpacityFollowSlide;
  final bool backdropSlideUpEnabled;
  final bool parallaxEnabled;
  final Color backdropColor;
  final double backdropOpacity;

  @override
  Widget build(BuildContext context) {
    final double _snapPoint = (snapPoint != null)
        ? (AppQuery(context).isSmallDevice ? snapPoint * 0.55 : snapPoint)
        : null;

    final double _minHeight = AppQuery(context).isSmallDevice
        ? (minHeight > kDefaultMinHeight ? minHeight * 0.7 : minHeight)
        : minHeight;

    return SlidingUpPanel(
      color: backgroundColor,
      minHeight: minHeight < kExtentPoint1
          ? AppQuery(context).height * minHeight
          : _minHeight,
      snapPoint: _snapPoint,
      maxHeight: maxHeight <= kExtentPoint1
          ? AppQuery(context).height * maxHeight
          : maxHeight,
      padding: kSpacer.edgeInsets.all.none,
      controller: panelController,
      parallaxEnabled: parallaxEnabled,
      backdropSlideUpEnabled: backdropSlideUpEnabled,

      ///
      /// this is the main body of the drawer
      /// if both panel & panel builder not null, panel will be chose
      panel: panel,
      panelBuilder: (panelBuilder != null)
          ? (ScrollController scrollController) =>
              panelBuilder(scrollController)
          : (ScrollController scrollController) => Container(),

      /// this is the header of the drawer
      header: fullScreen
          ? ((header != null) ? SafeArea(child: header) : Container())
          : (backgroundColor == kAppClearWhite || removeLine)
              ? header ?? Container()
              : SingleChildScroll(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppQuery(context).width * 0.45,
                          vertical: 12.0,
                        ),
                        child: const AppHDivider(
                        ),
                      ),
                      header ?? Container(),
                    ],
                  ),
                ),

      footer: footerUseSafeArea
          ? SafeArea(child: footer ?? Container())
          : footer ?? Container(),

      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(kBorderRadiusMed),
      ),
      boxShadow: fullScreen ? <BoxShadow>[] : <BoxShadow>[_boxShadow],
      onPanelSlide: onPanelSlide,
      onFinishSliding: onFinishSliding,
      onPanelClosed: onPanelClosed,
      onPanelMiddle: onPanelMiddle,
      onPanelOpened: onPanelOpened,
      // ignore: avoid_bool_literals_in_conditional_expressions
      isDraggable: fullScreen ? false : draggable,
      defaultPanelState: defaultPanelState ??
          (fullScreen ? PanelState.OPEN : PanelState.MIDDLE),

      /// backdrop setting
      backdropEnabled: backdropEnabled,
      backdropColor: backdropColor,
      backdropOpacity: backdropOpacity,
      onBackdropTap: onBackdropTap,
      backdropOpacityFollowSlide: backdropOpacityFollowSlide,
    );
  }

  BoxShadow get _boxShadow {
    switch (shadowStrokeType) {
      case ShadowStrokeType.highShadow:
        return BoxShadow(
          color: kAppPrimaryDarkShadowHigh.withOpacity(0.16),
          blurRadius: 80,
        );
        break;
      case ShadowStrokeType.medShadow:
        return BoxShadow(
          color: kAppPrimaryDarkShadowMed.withOpacity(0.09),
          blurRadius: 40,
          offset: const Offset(4, 8),
        );
        break;
      case ShadowStrokeType.lowShadow:
        return BoxShadow(
          color: kAppPrimaryDarkShadowLow.withOpacity(0.16),
          blurRadius: 4,
          offset: const Offset(0, 2),
        );
        break;
      case ShadowStrokeType.subtle:
        return BoxShadow(
          color: kAppPrimaryDarkShadowLow.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 0),
        );
        break;
      case ShadowStrokeType.minimum:
        return BoxShadow(
          color: kAppPrimaryDarkShadowLow.withOpacity(0.16),
          blurRadius: 2,
          spreadRadius: -4,
          offset: const Offset(0, 1),
        );
        break;
      case ShadowStrokeType.drawer:
        return BoxShadow(
          color: kAppPrimaryDarkShadowHigh.withOpacity(0.2),
          blurRadius: 64,
          offset: const Offset(0, 0),
        );
        break;
      default:
        return const BoxShadow(color: kAppClearWhite);
        break;
    }
  }
}
