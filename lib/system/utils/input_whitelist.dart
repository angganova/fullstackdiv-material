import 'package:flutter/services.dart';

class InputWhitelist{
  /// Text form field input only char
  List<TextInputFormatter> get getCharOnlyInput =>
      [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))];

  /// Text form field input only number
  List<TextInputFormatter> get getNumberOnlyInput =>
      [FilteringTextInputFormatter.allow(RegExp("[0-9]"))];

  /// Text form field input only safe char
  List<TextInputFormatter> get getCharNumberOnly =>
      [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]"))];

  /// Text form field input only safe char
  List<TextInputFormatter> get getSafeInput =>
      [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 !?.,=-]"))];

  /// Text form field input only safe char
  List<TextInputFormatter> get getMenuNotesSafeInput =>
      [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 :+&()%!?.,=-]"))];

}