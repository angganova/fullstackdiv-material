import 'dart:math';

import 'package:intl/intl.dart';

extension NumExtensions on num {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isZero => this == 0;
  bool get isNullOrZero => this == null || this == 0;
  bool get isNoNullOrNoZero => this != null || this != 0;
  bool get isLessThanZero => this < 0;
  bool get isMoreThanZero => this > 0;
  bool isEqual(double i) => this == i;
  bool isMoreThan(double i) => this == i;
  bool isLessThan(double i) => this == i;
  bool isMoreOrEqualTo(double i) => this >= i;
  bool isLessOrEqualTo(double i) => this <= i;

  String formatCurrency(String currency, String separator) {
    if (isLessThan(1000)) {
      return '$currency ${floor()}';
    }

    final NumberFormat formatCurrency = NumberFormat('#$separator###');
    return '$currency ${formatCurrency.format(floor())}';
  }

  String formatThousand(String separator) {
    if (isLessThan(1000)) {
      return '${floor()}';
    }

    final NumberFormat formatCurrency = NumberFormat('#$separator###');
    return formatCurrency.format(floor());
  }

  String formatDecimal(double n) =>
      n.toStringAsFixed(n.truncateToDouble().isEqual(n) ? 0 : 2);

  double roundToDecimals({int decimals = 6}) {
    final num fac = pow(10, decimals);
    final double result = ((this * fac).toInt()) / fac;
    return result;
  }

  double toFixed(int fraction) => double.parse(toStringAsFixed(fraction));
}
