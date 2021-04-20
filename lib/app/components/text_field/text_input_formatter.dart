import 'package:flutter/services.dart';

class LengthLimitingTextInputFormatterNormal extends TextInputFormatter {
  LengthLimitingTextInputFormatterNormal(this.maxLength)
      : assert(maxLength == null || maxLength == -1 || maxLength > 0);
  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    final RuneIterator iterator = RuneIterator(newValue.text);
    if (newValue.text.runes.length <= maxLength) {
      return newValue;
    }

    String ret = '';
    int s = 0;
    while (iterator.moveNext()) {
      if (s >= maxLength) {
        break;
      }
      ret += iterator.currentAsString;
      s++;
    }

    return TextEditingValue(
      text: ret,
      selection: TextSelection.fromPosition(
        TextPosition(offset: maxLength),
      ),
      composing: TextRange.empty,
    );
  }
}
