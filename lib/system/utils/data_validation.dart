import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/utils/data_utils.dart';

class DataValidation {
  static String nameIsValid(String name) {
    if (name.isNullOrEmpty) {
      return 'Name can\'t be empty';
    } else if (name.length.isLessThan(3)) {
      return 'Name can\'t be less than 3 character';
    } else if (!DataUtils.isValidCharOnly(name)) {
      return 'Name can\'t contain numbers and special character';
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

  static String ssnIsValid(String ssn) {
    /// SSN number validation
    if (ssn.isNullOrEmpty) {
      return 'SSN can\'t be empty';
    } else if (!ssn.length.isEqual(9)) {
      return 'SSN can\'t be less or more than 9 digits';
    } else {
      return null;
    }
  }

  static String einIsValid(String ein) {
    /// EIN name validation
    if (ein.isNullOrEmpty) {
      return 'EIN can\'t be empty';
    } else if (!ein.length.isEqual(9)) {
      return 'EIN can\'t be less or more than 9 digits';
    } else {
      return null;
    }
  }

  static String vatIsValid(String vat) {
    /// VAT number validation
    if (vat.isNullOrEmpty) {
      return 'VAT number can\'t be empty';
    } else if (!vat.length.isEqual(9)) {
      return 'VAT can\'t be less or more than 9 digits';
    } else {
      return null;
    }
  }
}
