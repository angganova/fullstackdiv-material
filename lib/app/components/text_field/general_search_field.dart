import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/text_field/text_field.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [GeneralSearchField] class
/// this is one of the Text Field used in the app
class GeneralSearchField extends StatefulWidget {
  const GeneralSearchField({
    @required this.textFieldController,
    @required this.textFieldFocusNode,
    this.onTextFieldChanged,
    this.onTextFieldFocusChanged,
    this.onTextPinTap,
    this.onFieldSubmitted,
    this.hint = '',
    this.labelHint,
    this.showKeyboardDoneButton = false,
    this.showKeyboardArrows = false,
  });

  /// required
  final TextEditingController textFieldController;
  final FocusNode textFieldFocusNode;

  /// optional
  final ValueChanged<String> onTextFieldChanged;
  final ValueChanged<bool> onTextFieldFocusChanged;
  final VoidCallback onTextPinTap;
  final Function(String) onFieldSubmitted;
  final String hint;
  final String labelHint;
  final bool showKeyboardDoneButton;
  final bool showKeyboardArrows;

  @override
  _GeneralSearchFieldState createState() => _GeneralSearchFieldState();
}

class _GeneralSearchFieldState extends State<GeneralSearchField> {
  final EdgeInsets _textFieldContentPadding = AppTextField.defaultContentPadding
      .copyWith(right: kSpacer.xs + kMedTappableArea);

  bool _textFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: kSpacer.edgeInsets.x.standard,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (widget.labelHint != null)
                        Padding(
                          padding: EdgeInsets.only(
                            right: kSpacer.xxs,
                            bottom: 2.0,
                          ),
                          child: Text(
                            widget.labelHint,
                            style: AppTextStyle(color: kAppGreyB).primaryPL,
                          ),
                        ),
                      Expanded(
                        child: AppTextField(
                          showKeyboardDoneButton: widget.showKeyboardDoneButton,
                          showKeyboardArrows: widget.showKeyboardArrows,
                          hideBottomLine: true,
                          textFieldType: TextFieldType.journeyInput,
                          controller: widget.textFieldController,
                          focusNode: widget.textFieldFocusNode,
                          hint: widget.labelHint != null ? '' : widget.hint,
                          enableValidation: false,
                          textStyle: AppTextStyle(color: kAppBlack).primaryPL,
                          hintTextStyle:
                              AppTextStyle(color: kAppGreyB).primaryPL,
                          contentPadding: _textFieldContentPadding,
                          maxLines: 1,
                          onChanged: (String text) {
                            if (widget.onTextFieldChanged != null) {
                              widget.onTextFieldChanged(text);
                            }
                          },
                          onFocusChanged: (bool focused) {
                            if (widget.onTextFieldFocusChanged != null) {
                              widget.onTextFieldFocusChanged(focused);
                            }
                            setState(() {
                              _textFieldFocused = focused;
                            });
                          },
                          onFieldSubmitted: (String text) {
                            if (widget.onFieldSubmitted != null) {
                              final String _text =
                                  widget.textFieldController.text;
                              widget.onFieldSubmitted(_text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 2.0,
                    width: double.infinity,
                    color:
                        _textFieldFocused ? kAppPrimaryElectricBlue : kAppGreyC,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _getPickLocationIcon(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build pin location icon button
  Widget _getPickLocationIcon() {
    if (widget.onTextPinTap != null && _textFieldFocused) {
      return GestureDetector(
        onTap: widget.onTextPinTap,
        child: Container(
          width: kMedTappableArea,
          height: kMedTappableArea,
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.location_on,
            color: kAppPrimaryElectricBlue,
            size: kSmallIconSize,
          ),
        ),
      );
    } else if (_textFieldFocused) {
      return GestureDetector(
        onTap: () {
          widget.textFieldController.clear();
        },
        child: Container(
          width: kMedTappableArea,
          height: kMedTappableArea,
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.close,
            color: kAppPrimaryElectricBlue,
            size: kSmallIconSize,
          ),
        ),
      );
    } else {
      return Container(
        width: kMedTappableArea,
        height: kMedTappableArea,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.search,
          color: _textFieldFocused ? kAppPrimaryElectricBlue : kAppGreyB,
          size: kSmallIconSize,
        ),
      );
    }
  }
}
