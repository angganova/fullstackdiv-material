import 'dart:math';

import 'package:intl/intl.dart';

extension NumExtensions on num {
  bool isEqual(num i) => this == i;
  bool isMoreThan(num i) => this > i;
  bool isLessThan(num i) => this < i;
  bool isMoreOrEqualTo(num i) => this >= i;
  bool isLessOrEqualTo(num i) => this <= i;

  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isZero => this == 0;
  bool get isLessThanZero => this < 0;
  bool get isMoreThanZero => this > 0;
  bool get isNullOrZero => isNull || isZero;
  bool get isNotNullOrZero => isNotNull && isMoreThanZero;
  bool get isInteger => this is int || this == roundToDouble();

  String formatCurrency(
      {String currency = '\$', int decimalPlace = 2, String separator = ','}) {
    if (abs().isLessThan(100)) {
      return '$currency ${formatDecimal(decimalPlace)}';
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

  String formatDecimal(int n) => toStringAsFixed(n);

  double roundToDecimals({int decimals = 6}) {
    final num fac = pow(10, decimals);
    final double result = ((this * fac).toInt()) / fac;
    return result;
  }

  double toFixed(int fraction) => double.parse(toStringAsFixed(fraction));
}
