import 'package:flutter/services.dart';

class InputWhitelist{
  /// Text form field input only char
  List<TextInputFormatter> get getCharOnlyInput =>
      <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))];

  /// Text form field input only number
  List<TextInputFormatter> get getNumberOnlyInput =>
      <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))];

  /// Text form field input only safe char
  List<TextInputFormatter> get getCharNumberOnly =>
      <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 ]'))];

  /// Text form field input only safe char
  List<TextInputFormatter> get getSafeInput =>
      <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 !?.,=-]'))];

  /// Text form field input only safe char
  List<TextInputFormatter> get getMenuNotesSafeInput =>
      <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 :+&()%!?.,=-]'))];

}