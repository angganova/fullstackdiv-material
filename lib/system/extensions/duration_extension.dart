extension DurationExtension on Duration {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isZero => inMilliseconds == 0;
  bool get isNullOrZero => this == null || inMilliseconds == 0;
  bool get isNoNullOrNoZero => this != null || inMilliseconds != 0;
  bool get isLessThanZero => inMilliseconds < 0;
  bool get isMoreThanZero => inMilliseconds > 0;
  bool isEqual(Duration i) => inMilliseconds == i.inMilliseconds;
  bool isMoreThan(Duration i) => this > i;
  bool isLessThan(Duration i) => this < i;
  bool isMoreOrEqualTo(Duration i) => this >= i;
  bool isLessOrEqualTo(Duration i) => this <= i;
}
