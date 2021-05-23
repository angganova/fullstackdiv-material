import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/utils/data_utils.dart';

class DataValidation {
  static String basicLengthIsValid(String text,
      {String tag = '', int minLength = 0}) {
    if (text.isNullOrEmpty) {
      return '$tag can\'t be empty';
    } else if (!minLength.isZero && text.length.isLessThan(minLength)) {
      return '$tag can\'t be less than $minLength character';
    } else {
      return null;
    }
  }

  static String nameIsValid(String name, {String tag = '', int minLength = 3}) {
    if (name.isNullOrEmpty) {
      return '$tag can\'t be empty';
    } else if (name.length.isLessThan(minLength)) {
      return '$tag can\'t be less than $minLength character';
    } else if (!DataUtils.isValidCharOnly(name)) {
      return '$tag can\'t contain numbers and special character';
    } else {
      return null;
    }
  }

  static String emailIsValid(String email) {
    if (email.isNullOrEmpty) {
      return 'Email can\'t be empty';
    } else if (!DataUtils.isEmail(email)) {
      return 'Your email format is invalid';
    } else {
      return null;
    }
  }

  static String passwordIsValid(String password) {
    /// Password validation
    if (password.isNullOrEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length.isLessThan(8)) {
      return 'Password can\'t be less than 8 character';
    } else if (!DataUtils.isValidPassword(password)) {
      return 'Password must contain minimum of 1 uppercase, 1 lowercase, '
          '1 numeric number, and 1 special character (! @ # \$ & * ~)';
    } else {
      return null;
    }
  }

  static String phoneIsValid(String phone) {
    /// Phone validation
    if (phone.isNullOrEmpty) {
      return 'Phone number can\'t be empty';
    } else if (phone.length.isLessThan(10)) {
      return 'Phone number can\'t be less than 10 digits';
    } else {
      return null;
    }
  }
}
