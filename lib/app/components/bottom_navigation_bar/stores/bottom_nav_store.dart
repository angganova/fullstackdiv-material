import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'bottom_nav_store.g.dart';

class BottomNavStore = _BottomNavStore with _$BottomNavStore;

/// this is the [Store] class to help setting up the [CustomBottomNavigationBar] component
// TODO(Andre): check this
abstract class _BottomNavStore with Store {
  @observable
  bool _bottomNavHidden = false;

  @observable
  bool _statusBarHidden = false;

  /// This navigator state will be used to navigate different pages
  final GlobalKey<NavigatorState> drawerNavigatorKey =
      GlobalKey<NavigatorState>();

  @computed
  bool get bottomNavHidden {
    return _bottomNavHidden;
  }

  @computed
  bool get statusBarHidden {
    return _statusBarHidden;
  }

  @action
  void hideBottomNav() {
    _bottomNavHidden = true;
  }

  @action
  void showBottomNav() {
    _bottomNavHidden = false;
  }

  @action
  void hideStatusBar() {
    _statusBarHidden = true;
  }

  @action
  void showStatusBar() {
    _statusBarHidden = false;
  }
}
