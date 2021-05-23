import 'package:flutter/foundation.dart';
import 'package:fullstackdiv_material/system/extensions/extensions_variable.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNullOrEmpty => this == null || trim().isEmpty;
  bool get isNotNullOrEmpty {
    if (isNull) {
      return false;
    } else {
      return trim().isNotEmpty;
    }
  }

  bool get isNumber {
    try {
      num.parse(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool get isBool => ignoreCase('true') || ignoreCase('false');

  bool get toBool => ignoreCase('true');

  int get toInt {
    if (isNumber) {
      return int.tryParse(this) ?? 0;
    } else {
      return 0;
    }
  }

  double get toDouble {
    if (isNumber) {
      return double.tryParse(this) ?? 0;
    } else {
      return 0;
    }
  }

  DateTime get toDate {
    return getUTCDateTimeFromString;
  }

  bool containIgnoreCase(String s2) {
    if (this == null) {
      return this == s2;
    } else {
      return toLowerCase().contains((s2 ?? '').toLowerCase()) &&
          toUpperCase().contains((s2 ?? '').toUpperCase());
    }
  }

  bool ignoreCase(String s2) {
    if (this == null) {
      return this == s2;
    } else {
      return toLowerCase() == (s2 ?? '').toLowerCase() &&
          toUpperCase() == (s2 ?? '').toUpperCase();
    }
  }

  bool ignoreCaseIgnoreSpace(String s2) {
    if (this == null) {
      return this == s2;
    } else {
      s2 ??= '';
      return removeSpace.toLowerCase() == s2.removeSpace.toLowerCase() &&
          removeSpace.toUpperCase() == s2.removeSpace.toUpperCase();
    }
  }

  String get removeSpace => replaceAll(' ', '');

  bool get isDate {
    try {
      return DateTime.parse(this) != null;
    } catch (e) {
      return false;
    }
  }

  String get capsWord => isNotNullOrEmpty
      ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
      : '';

  String get capsWords {
    try {
      return split(' ')
          .map((String word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');
    } catch (_) {
      return this;
    }
  }

  String get capsSentence => isNotNullOrEmpty
      ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
      : '';

  String get capsSentences {
    try {
      return split('. ')
          .map((String sentence) =>
      sentence[0].toUpperCase() + sentence.substring(1))
          .join('. ');
    } catch (_) {
      return this;
    }
  }

  T toEnum<T>(List<T> values) {
    for (final T item in values) {
      final String enumString = describeEnum(item);
      if (enumString == this) {
        return item;
      }
    }
    return null;
  }

  List<String> splitWithSeparator(String separator, {int max = 0}) {
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

  String formatDateFromUTC(String format) {
    const String emptyString = '';
    if (isNullOrEmpty) {
      return emptyString;
    } else if (!isDate) {
      return emptyString;
    }

    DateTime newDate;

    try {
      newDate = getUTCDateTimeFromString;
    } catch (e) {
      e.printStackTrace();
      return emptyString;
    }

    if (newDate != null) {
      final DateFormat formatter = DateFormat(format);
      return formatter.format(newDate);
    }

    return emptyString;
  }

  String formatDateFromYYYYMMDD(String format) {
    const String emptyString = '';
    if (isNullOrEmpty) {
      return emptyString;
    } else if (!isDate) {
      return emptyString;
    }

    DateTime newDate;

    try {
      newDate = getDateTimeFromYYYYMMDD;
    } catch (e) {
      e.printStackTrace();
      return emptyString;
    }

    if (newDate != null) {
      final DateFormat formatter = DateFormat(format);
      return formatter.format(newDate);
    }

    return emptyString;
  }

  DateTime get getDateTimeFromYYYYMMDD {
    try {
      final DateTime dateTime =
      DateFormat(ExtensionsVariable.dateFormatYYYYMMDD).parseUTC(this);
      return dateTime;
    } catch (e) {
      return null;
    }
  }

  DateTime get getUTCDateTimeFromString {
    try {
      final DateTime dateTime =
      DateFormat(ExtensionsVariable.dateFormatYYYYMMDDTHHMMSSZ)
          .parseUTC(this);
      return dateTime;
    } catch (e) {
      return null;
    }
  }
}
