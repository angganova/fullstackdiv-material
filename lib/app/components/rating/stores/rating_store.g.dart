// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RatingStore on _RatingStore, Store {
  final _$ratingAtom = Atom(name: '_RatingStore.rating');

  @override
  int get rating {
    _$ratingAtom.reportRead();
    return super.rating;
  }

  @override
  set rating(int value) {
    _$ratingAtom.reportWrite(value, super.rating, () {
      super.rating = value;
    });
  }

  final _$ratingCountAtom = Atom(name: '_RatingStore.ratingCount');

  @override
  int get ratingCount {
    _$ratingCountAtom.reportRead();
    return super.ratingCount;
  }

  @override
  set ratingCount(int value) {
    _$ratingCountAtom.reportWrite(value, super.ratingCount, () {
      super.ratingCount = value;
    });
  }

  final _$enabledAtom = Atom(name: '_RatingStore.enabled');

  @override
  bool get enabled {
    _$enabledAtom.reportRead();
    return super.enabled;
  }

  @override
  set enabled(bool value) {
    _$enabledAtom.reportWrite(value, super.enabled, () {
      super.enabled = value;
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
