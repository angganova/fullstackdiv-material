import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/app/components/text_field/text_field.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ZLargeTextField extends StatefulWidget {
  const ZLargeTextField({
    Key key,
    @required this.controller,
    this.focusNode,
    this.hint,
    this.onChanged,
    this.onFocusChanged,
    this.onFieldSubmitted,
    this.validator,
    this.inputType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLength,
    this.shadowStrokeType = ShadowStrokeType.medShadow,
    this.showKeyboardDoneButton = false,
    this.showKeyboardArrows = false,
    this.hintTextStyle,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onFocusChanged;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldValidator<String> validator;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final int maxLength;
  final ShadowStrokeType shadowStrokeType;
  final List<TextInputFormatter> inputFormatters;
  final bool showKeyboardDoneButton;
  final bool showKeyboardArrows;
  final TextStyle hintTextStyle;

  @override
  _ZLargeTextFieldState createState() => _ZLargeTextFieldState();
}

class _ZLargeTextFieldState extends State<ZLargeTextField> {
  int currentLength = 0;

  @override
  void initState() {
    super.initState();

    /// Count number of emoji int the text
    int numEmoji = 0;
    for (final int rune in widget.controller.text.runes) {
      final String character = String.fromCharCode(rune);
      if (isEmoji(character)) {
        numEmoji++;
      }
    }
    currentLength = widget.controller.text.length - numEmoji;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ShadowStrokeStyles(
          shadowStrokeType: widget.shadowStrokeType,
          radius: kBorderRadiusSmall,
          color: kAppWhite,
          padding: kSpacer.edgeInsets.all.none,
          child: AppTextField(
            textFieldType: TextFieldType.largeField,
            focusNode: widget.focusNode,
            controller: widget.controller,
            hint: widget.hint,
            contentPadding: const EdgeInsets.all(20),
            onFocusChanged: widget.onFocusChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputType: widget.inputType,
            hintTextStyle: widget.hintTextStyle,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            inputFormatters: _inputFormatter,
            maxLength: widget.maxLength,
            onChanged: (String text) {
              if (widget.onChanged != null) {
                widget.onChanged(text);
              }
              setState(() {
                /// Count number of emoji int the text
                int numEmoji = 0;
                for (final int rune in text.runes) {
                  final String character = String.fromCharCode(rune);
                  if (isEmoji(character)) {
                    numEmoji++;
                  }
                }

                /// Known flutter issue: https://api.flutter.dev/flutter/material/TextField/maxLength.html
                ///
                /// One Emoji is counted as two character, so need to subtract
                /// text length with number of emoji in the text
                currentLength = text.length - numEmoji;
              });
            },
            showKeyboardDoneButton: widget.showKeyboardDoneButton,
            showKeyboardArrows: widget.showKeyboardArrows,
          ),
        ),
        if (widget.maxLength != null)
          Padding(
            padding: kSpacer.edgeInsets.all.xs,
            child: Text(
              '$currentLength/${widget.maxLength}',
              style: AppTextStyle(color: kAppGreyC).primaryLabel1,
            ),
          ),
      ],
    );
  }

  List<TextInputFormatter> get _inputFormatter {
    return widget.inputFormatters;
  }

  bool isEmoji(String char) {
    final RegExp regExp = RegExp(
        r'(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])');
    return char.contains(regExp);
  }
}
