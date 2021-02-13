import 'package:flutter/widgets.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// This function replaces the interpolated text with custom TextSpan(s)
/// You can put the variable name (without {curly brackets}) as a [spanCallback] key
/// Then you can put the TextSpan as the span that will replace the {curly_brackets} words inside the text
RichText buildInterpolatedCopyWidget(
  BuildContext context,
  String text, {
  Map<String, TextSpan> spanCallback,
  TextStyle defaultStyle,
  TextAlign textAlign,
}) {
  // Currently not using LIFO logic, assumed no nested brackets
  // Also assumed no empty brackets
  // Also assumed no unfinished brackets
  final TextStyle usedStyle =
      defaultStyle ?? AppTextStyle(context: context, color: kAppBlack).primaryP;
  final List<TextSpan> spans = <TextSpan>[];
  final StringBuffer runningBuffer = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    if (text[i] == '{') {
      if (runningBuffer.isNotEmpty) {
        final TextSpan currentSpan =
            TextSpan(text: runningBuffer.toString(), style: usedStyle);
        spans.add(currentSpan);
      }
      runningBuffer.clear();
    } else if (text[i] == '}') {
      final String currentVar = runningBuffer.toString();
      runningBuffer.clear();
      if (spanCallback.containsKey(currentVar)) {
        final TextSpan currentSpan = spanCallback[currentVar];
        spans.add(currentSpan);
      }
    } else {
      runningBuffer.write(text[i]);
    }
  }

  if (runningBuffer.isNotEmpty) {
    final TextSpan currentSpan =
        TextSpan(text: runningBuffer.toString(), style: usedStyle);
    spans.add(currentSpan);
    runningBuffer.clear();
  }

  return RichText(
    text: TextSpan(style: usedStyle, children: spans),
    textAlign: textAlign ?? TextAlign.start,
  );
}

/// Returning string, in case if you only wanted to replace {var}
/// This function's logic should be the same as [buildInterpolatedCopyWidget]
/// [callback] should be the combination of text inside brackets and output
String buildInterpolatedCopy(
  String text, {
  Map<String, String> callback,
}) {
  // Currently not using LIFO logic, assumed no nested brackets
  // Also assumed no empty brackets
  // Also assumed no unfinished brackets
  final StringBuffer runningBuffer = StringBuffer();
  final StringBuffer returnedBuffer = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    if (text[i] == '{') {
      if (runningBuffer.isNotEmpty) {
        returnedBuffer.write(runningBuffer.toString());
      }
      runningBuffer.clear();
    } else if (text[i] == '}') {
      final String currentVar = runningBuffer.toString();
      runningBuffer.clear();
      if (callback.containsKey(currentVar)) {
        final String currentValue = callback[currentVar];
        returnedBuffer.write(currentValue);
      }
    } else {
      runningBuffer.write(text[i]);
    }
  }

  if (runningBuffer.isNotEmpty) {
    returnedBuffer.write(runningBuffer.toString());
    runningBuffer.clear();
  }

  return returnedBuffer.toString();
}

String replaceInterpolatedCopy({
  @required String source,
  List<ReplaceStringModel> stringToReplace,
}) {
  String processedString = source;

  for (final ReplaceStringModel stringModel in stringToReplace) {
    processedString =
        processedString.replaceFirst('{${stringModel.id}}', stringModel.value);
  }

  return processedString;
}

class ReplaceStringModel {
  ReplaceStringModel({@required this.id, @required this.value});
  final String id;
  final String value;
}
