import 'package:flutter/foundation.dart';

extension StringExtension on String {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNullOrEmpty => this == null || isEmpty;
  bool get isNotNullOrEmpty => this != null || isNotEmpty;

  //first letter only
  String get capsWord =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  //all letter in string
  String get allCaps => toUpperCase();

  //first letter for each word in a string
  String get titleCase => split(' ')
      .map((String word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  T toEnum<T>(List<T> values) {
    for (final T item in values) {
      final String enumString = describeEnum(item);
      if (enumString == this) {
        return item;
      }
    }
    return null;
  }

  bool ignoreCase(String s2) {
    if (this == null) {
      return this == s2;
    } else {
      return toLowerCase() == (s2 ?? '').toLowerCase() &&
          toUpperCase() == (s2 ?? '').toUpperCase();
    }
  }

  List<String> splitWith(String separator, {int max = 0}) {
    final List<String> result = <String>[];
    String string = this;

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      final int index = string.indexOf(separator);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = substring(index + separator.length);
    }

    return result;
  }
}
