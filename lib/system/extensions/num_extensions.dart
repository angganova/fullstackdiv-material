import 'dart:math';

import 'package:intl/intl.dart';

extension NumExtensions on num {
  bool get isZero => this == 0;
  bool get isLessThanZero => this < 0;
  bool get isLessOrEqualToZero => this <= 0;
  bool get isMoreThanZero => this > 0;
  bool get isMoreOrEqualToZero => this >= 0;
  bool isEqual(double i) => this == i;

  String formatCurrency(String currency, String separator) {
    if (this < 1000) return "$currency ${this.floor()}";

    final formatCurrency = NumberFormat("#$separator###");
    return "$currency ${formatCurrency.format(this.floor())}";
  }

  String formatThousand(String separator) {
    if (this < 1000) return "${this.floor()}";

    final formatCurrency = NumberFormat("#$separator###");
    return "${formatCurrency.format(this.floor())}";
  }

  String formatDecimal(double n) =>
      n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);

  double roundToDecimals({int decimals = 6}) {
    final num fac = pow(10, decimals);
    final double result = ((this * fac).toInt()) / fac;
    return result;
  }

  double toFixed(int fraction) {
    return double.parse(toStringAsFixed(fraction));
  }
}
