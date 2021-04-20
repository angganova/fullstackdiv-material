import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool isEqual(DateTime i) => this == i;

  String formatDate(String format) {
    try {
      final DateFormat formatter = DateFormat(format);
      return formatter.format(this);
    } catch (_) {
      return '';
    }
  }
}
