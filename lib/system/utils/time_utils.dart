import 'package:fullstackdiv_material/system/global_extensions.dart';

class TimeUtils {
  String get currentTimeInString {
    final int hour = DateTime.now().hour;
    if (hour.isMoreThanZero && hour.isLessOrEqualTo(12)) {
      return 'Good Morning!';
    } else if (hour.isMoreThan(12) && hour.isLessOrEqualTo(18)) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }
}
