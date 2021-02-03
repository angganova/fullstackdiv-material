// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RatingStore on _RatingStore, Store {
  Computed<int> _$ratingComputed;

  @override
  int get rating => (_$ratingComputed ??=
          Computed<int>(() => super.rating, name: '_RatingStore.rating'))
      .value;
  Computed<int> _$ratingCountComputed;

  @override
  int get ratingCount =>
      (_$ratingCountComputed ??= Computed<int>(() => super.ratingCount,
              name: '_RatingStore.ratingCount'))
          .value;
  Computed<bool> _$enabledComputed;

  @override
  bool get enabled => (_$enabledComputed ??=
          Computed<bool>(() => super.enabled, name: '_RatingStore.enabled'))
      .value;

  final _$_ratingAtom = Atom(name: '_RatingStore._rating');

  @override
  int get _rating {
    _$_ratingAtom.reportRead();
    return super._rating;
  }

  @override
  set _rating(int value) {
    _$_ratingAtom.reportWrite(value, super._rating, () {
      super._rating = value;
    });
  }

  final _$_ratingCountAtom = Atom(name: '_RatingStore._ratingCount');

  @override
  int get _ratingCount {
    _$_ratingCountAtom.reportRead();
    return super._ratingCount;
  }

  @override
  set _ratingCount(int value) {
    _$_ratingCountAtom.reportWrite(value, super._ratingCount, () {
      super._ratingCount = value;
    });
  }

  final _$_enabledAtom = Atom(name: '_RatingStore._enabled');

  @override
  bool get _enabled {
    _$_enabledAtom.reportRead();
    return super._enabled;
  }

  @override
  set _enabled(bool value) {
    _$_enabledAtom.reportWrite(value, super._enabled, () {
      super._enabled = value;
    });
  }

  @override
  String toString() {
    return '''
rating: ${rating},
ratingCount: ${ratingCount},
enabled: ${enabled}
    ''';
  }
}
