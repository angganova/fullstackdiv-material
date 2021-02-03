import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/text_field/general_search_field.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [TextFieldHeader] class
/// this is one of the Header used in the app
class TextFieldHeader extends StatefulWidget {
  const TextFieldHeader({
    @required this.onBackButtonTapped,
    @required this.textFieldController,
    @required this.textFieldFocusNode,
    this.onTextFieldChanged,
    this.onTextFieldFocusChanged,
    this.onTextPinTap,
    this.onFieldSubmitted,
    this.hint = '',
    this.labelHint,
  });

  /// required
  final VoidCallback onBackButtonTapped;
  final TextEditingController textFieldController;
  final FocusNode textFieldFocusNode;

  /// optional
  final ValueChanged<String> onTextFieldChanged;
  final ValueChanged<bool> onTextFieldFocusChanged;
  final VoidCallback onTextPinTap;
  final Function(String) onFieldSubmitted;
  final String hint;
  final String labelHint;

  @override
  _TextFieldHeaderState createState() => _TextFieldHeaderState();
}

class _TextFieldHeaderState extends State<TextFieldHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: kDefaultMargin,
        bottom: AppSpacer(context: context).standard,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: kSpacer.edgeInsets.x.standard,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    color: kAppClearWhite,
                    width: kSpacer.lg,
                    height: kSpacer.lg,
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back,
                      size: kSmallIconSize,
                      color: kAppGreyB,
                    ),
                  ),
                  onTap: widget.onBackButtonTapped,
                ),
              ],
            ),
          ),
          GeneralSearchField(
            textFieldController: widget.textFieldController,
            textFieldFocusNode: widget.textFieldFocusNode,
            onTextFieldChanged: widget.onTextFieldChanged,
            onTextFieldFocusChanged: widget.onTextFieldFocusChanged,
            onTextPinTap: widget.onTextPinTap,
            onFieldSubmitted: widget.onFieldSubmitted,
            hint: widget.hint,
            labelHint: widget.labelHint,
          ),
        ],
      ),
    );
  }
}
