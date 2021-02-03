// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BottomNavStore on _BottomNavStore, Store {
  Computed<bool> _$bottomNavHiddenComputed;

  @override
  bool get bottomNavHidden =>
      (_$bottomNavHiddenComputed ??= Computed<bool>(() => super.bottomNavHidden,
              name: '_BottomNavStore.bottomNavHidden'))
          .value;
  Computed<bool> _$statusBarHiddenComputed;

  @override
  bool get statusBarHidden =>
      (_$statusBarHiddenComputed ??= Computed<bool>(() => super.statusBarHidden,
              name: '_BottomNavStore.statusBarHidden'))
          .value;

  final _$_bottomNavHiddenAtom = Atom(name: '_BottomNavStore._bottomNavHidden');

  @override
  bool get _bottomNavHidden {
    _$_bottomNavHiddenAtom.reportRead();
    return super._bottomNavHidden;
  }

  @override
  set _bottomNavHidden(bool value) {
    _$_bottomNavHiddenAtom.reportWrite(value, super._bottomNavHidden, () {
      super._bottomNavHidden = value;
    });
  }

  final _$_statusBarHiddenAtom = Atom(name: '_BottomNavStore._statusBarHidden');

  @override
  bool get _statusBarHidden {
    _$_statusBarHiddenAtom.reportRead();
    return super._statusBarHidden;
  }

  @override
  set _statusBarHidden(bool value) {
    _$_statusBarHiddenAtom.reportWrite(value, super._statusBarHidden, () {
      super._statusBarHidden = value;
    });
  }

  final _$_BottomNavStoreActionController =
      ActionController(name: '_BottomNavStore');

  @override
  void hideBottomNav() {
    final _$actionInfo = _$_BottomNavStoreActionController.startAction(
        name: '_BottomNavStore.hideBottomNav');
    try {
      return super.hideBottomNav();
    } finally {
      _$_BottomNavStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showBottomNav() {
    final _$actionInfo = _$_BottomNavStoreActionController.startAction(
        name: '_BottomNavStore.showBottomNav');
    try {
      return super.showBottomNav();
    } finally {
      _$_BottomNavStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hideStatusBar() {
    final _$actionInfo = _$_BottomNavStoreActionController.startAction(
        name: '_BottomNavStore.hideStatusBar');
    try {
      return super.hideStatusBar();
    } finally {
      _$_BottomNavStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showStatusBar() {
    final _$actionInfo = _$_BottomNavStoreActionController.startAction(
        name: '_BottomNavStore.showStatusBar');
    try {
      return super.showStatusBar();
    } finally {
      _$_BottomNavStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bottomNavHidden: ${bottomNavHidden},
statusBarHidden: ${statusBarHidden}
    ''';
  }
}
