import 'dart:math';

extension DoubleExtensions on double {
  double roundToDecimals({int decimals = 6}) {
    final num fac = pow(10, decimals);
    final double result = ((this * fac).toInt()) / fac;
    return result;
  }

  double toFixed(int fraction) {
    return double.parse(toStringAsFixed(fraction));
  }
}
