import 'package:fullstackdiv_material/system/global_extensions.dart';

class DataUtils {
  static const Pattern validPasswordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const Pattern emailPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  static const Pattern numberPattern = r'[0-9]';
  static const Pattern charPattern = r'[a-zA-Z]';
  static const Pattern specialCharPattern = r'[^\w\s]';

  static const Pattern ccVisaPattern = r'^4[0-9]{6,}$';
  static const Pattern ccMasterCardPattern =
      r'^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$';
  static const Pattern ccAmexPattern = r'^3[47][0-9]{13}$';
  static const Pattern ccDinersClubPattern =
      r'^3(?:0[0-5]|[68][0-9])[0-9]{11}$';
  static const Pattern ccDiscoverPattern =
      r'^65[4-9][0-9]{13}|64[4-9][0-9]{13}|6011[0-9]{12}|(622(?:12[6-9]|1[3-9][0-9]|[2-8][0-9][0-9]|9[01][0-9]|92[0-5])[0-9]{10})$';
  static const Pattern ccJCBPattern = r'^(?:2131|1800|35\d{3})\d{11}$';

  static bool isValidPassword(String s) {
    final RegExp regExp = RegExp(validPasswordPattern.toString());
    return regExp.hasMatch(s);
  }

  static bool isValidCharOnly(String s) {
    final RegExp charRegex = RegExp(charPattern.toString());
    final RegExp numberRegex = RegExp(numberPattern.toString());
    final RegExp specialCharRegex = RegExp(specialCharPattern.toString());
    return charRegex.hasMatch(s.trim()) &&
        !numberRegex.hasMatch(s.trim()) &&
        !specialCharRegex.hasMatch(s.trim());
  }

  static bool isEmail(String s) {
    final RegExp regex = RegExp(emailPattern.toString());
    return regex.hasMatch(s.trim());
  }

  static bool isPhone(String s) {
    final RegExp regex = RegExp(numberPattern.toString());
    return regex.hasMatch(s.trim());
  }

  static String addNanpaPrefixPhone(String phone) {
    return '+1$phone';
  }

  static String removeNanpaPrefixPhone(String phone) {
    if (phone.isNotNullOrEmpty) {
      if (phone.startsWith('+1') && phone.length.isMoreOrEqualTo(11)) {
        return phone.substring(2, phone.length);
      } else {
        return phone;
      }
    }
    return phone;
  }
}
