import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class AppConvexBar2 extends StatefulWidget {
  const AppConvexBar2(
      {Key key,
      @required this.mainTabItems,
      this.onMainTabChange,
      this.mainTabBgColor = kAppPrimaryColor,
      this.mainTabIconActiveColor = kAppWhite,
      this.mainTabIconInactiveColor = kAppGreyD,
      @required this.childTabItems,
      this.onChildTabChange,
      this.mainTabController,
      this.childTabBgColor = kAppPrimaryColorAccent,
      this.childTabIconActiveColor = kAppWhite,
      this.childTabIconInactiveColor = kAppGreyD})
      : super(key: key);

  final List<ConvexTabModel> mainTabItems;
  final Function(int) onMainTabChange;
  final Color mainTabBgColor;
  final Color mainTabIconActiveColor;
  final Color mainTabIconInactiveColor;
  final TabController mainTabController;

  final List<ConvexTabModel> childTabItems;
  final Function(int) onChildTabChange;
  final Color childTabBgColor;
  final Color childTabIconActiveColor;
  final Color childTabIconInactiveColor;

  @override
  _AppConvexBar2State createState() => _AppConvexBar2State();
}

class _AppConvexBar2State extends State<AppConvexBar2>
    with TickerProviderStateMixin {
  final Duration _animationDuration = kDuration300;
  final double barHeight = 60;

  AnimationController _animationController;
  Animation<Offset> _offsetAnimation;

  TabController _mainTabController;
  TabController _childTabController;

  bool _isTopBarShown = false;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (widget.childTabItems.isNotNullOrEmpty) _childBarView,
        if (widget.mainTabItems.isNotNullOrEmpty)
          Positioned(bottom: 0, left: 0, right: 0, child: _mainBarView)
      ],
    );
  }

  Widget get _childBarView => SlideTransition(
        position: _offsetAnimation,
        child: AnimatedOpacity(
          duration: _animationDuration,
          opacity: _isTopBarShown ? 1 : 0,
          child: Container(
            padding: EdgeInsets.only(bottom: barHeight),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: widget.childTabBgColor,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: ConvexAppBar.builder(
                cornerRadius: 16,
                elevation: 0,
                height: barHeight,
                disableDefaultTabController: true,
                controller: _childTabController,
                count: widget.childTabItems.length,
                backgroundColor: widget.childTabBgColor,
                itemBuilder: _CustomTab(widget.childTabItems,
                    showMiddleTab: false,
                    activeIconColor: widget.childTabIconActiveColor,
                    inactiveIconColor: widget.childTabIconInactiveColor),
                onTap: (int index) => onSelectChildTab(index),
              ),
            ),
          ),
        ),
      );

  Widget get _mainBarView => Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          ConvexAppBar.builder(
            controller: _mainTabController,
            cornerRadius: 16,
            elevation: 0,
            height: barHeight,
            count: widget.mainTabItems.length,
            backgroundColor: widget.mainTabBgColor,
            itemBuilder: _CustomTab(widget.mainTabItems,
                middleTabIsActive: _isTopBarShown,
                middleTabAnimationController: _animationController,
                activeIconColor: widget.mainTabIconActiveColor,
                inactiveIconColor: widget.mainTabIconInactiveColor),
            onTap: (int index) => onSelectMainTab(index),
          ),
          GestureDetector(
            onTap: () => onSelectMainTab(widget.mainTabItems.length ~/ 2),
            child: Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 30),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: kAppWhite),
              child: RotationTransition(
                turns:
                    // ignore: always_specify_types
                    Tween(begin: 0.0, end: 0.5).animate(_animationController),
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  size: 50,
                  color: widget.mainTabIconActiveColor,
                ),
              ),
            ),
          )
        ],
      );

  void onSelectMainTab(int index) {
    if (index == widget.mainTabItems.length ~/ 2) {
      if (_isTopBarShown) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isTopBarShown = !_isTopBarShown;
    } else {
      _animationController.reverse();
      _isTopBarShown = false;

      if (widget.onMainTabChange != null) {
        widget.onMainTabChange(index);
      }
    }

    _resetTopBarSelection();
    setState(() {});
  }

  void onSelectChildTab(int index) {
    if (widget.onChildTabChange != null) {
      widget.onChildTabChange(index);
    }
  }

  void _resetTopBarSelection() {
    _childTabController = TabController(
        vsync: this,
        length: widget.childTabItems.length,
        initialIndex: widget.childTabItems.length ~/ 2);

    if (widget.onChildTabChange != null) {
      widget.onChildTabChange(widget.childTabItems.length ~/ 2);
    }
  }

  void initPlatformState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      reverseDuration: _animationDuration,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: kEndOffsetY,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    _animationController.reverse();

    _mainTabController = widget.mainTabController ??
        TabController(
            vsync: this,
            length: widget.mainTabItems.length,
            initialIndex: widget.mainTabItems.length ~/ 2);

    _childTabController = TabController(
        vsync: this,
        length: widget.childTabItems.length,
        initialIndex: widget.childTabItems.length ~/ 2);
  }
}

class _CustomTab extends DelegateBuilder {
  _CustomTab(
    this.items, {
    this.activeIconColor = kAppWhite,
    this.inactiveIconColor = kAppGreyD,
    this.tabBackgroundColor = kAppPrimaryColor,
    this.showMiddleTab = true,
    this.middleTabIsActive = false,
    this.middleTabAnimationController,
  });

  final List<ConvexTabModel> items;
  final Color tabBackgroundColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final bool showMiddleTab;
  final bool middleTabIsActive;
  final AnimationController middleTabAnimationController;

  @override
  Widget build(BuildContext context, int index, bool active) {
    final ConvexTabModel item = items[index];
    final Color _color = active ? activeIconColor : inactiveIconColor;

    if (index == items.length ~/ 2) {
      if (showMiddleTab && middleTabAnimationController != null) {
        return Container();
      } else {
        return Container();
      }
    } else {
      return Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AnimatedContainer(
              duration: kDuration200,
              padding: EdgeInsets.only(bottom: active ? 4 : 0),
              child: Stack(
                children: <Widget>[
                  Icon(
                    active ? item.iconActive : item.iconInactive,
                    color: _color,
                    size: 30,
                  ),
                  if (item.badgeText != null)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: kAppPrimaryRed, shape: BoxShape.circle),
                          child: Text(
                            item.badgeText,
                            style: const TextStyle(
                                fontSize: 10,
                                color: kAppWhite,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                ],
              ),
            ),
            Text(item.title, style: TextStyle(color: _color))
          ],
        ),
      );
    }
  }

  @override
  bool fixed() {
    return true;
  }
}

class ConvexTabModel {
  ConvexTabModel({
    @required this.iconActive,
    @required this.iconInactive,
    @required this.title,
    this.badgeText,
  });

  final IconData iconActive;
  final IconData iconInactive;
  final String title;
  String badgeText;
}
