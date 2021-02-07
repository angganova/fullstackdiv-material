import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// A text field component built from [TextFormField]
enum TextFieldType { standard, journeyInput, largeField }

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key key,
    this.textFieldType = TextFieldType.standard,
    this.controller,
    this.focusNode,
    this.hint,
    this.labelHint,
    this.error = false,
    this.autoValidate = AutovalidateMode.always,
    this.textStyle,
    this.hintTextStyle,
    this.errorTextStyle,
    this.inputType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.inputFormatters,
    this.contentPadding,
    this.enableValidation = true,
    this.onFocusChanged,
    this.maxLines,
    this.minLines,
    this.enabled = true,
    this.readonly = false,
    this.maxLength,
    this.hideBottomLine = false,
    this.showKeyboardDoneButton = false,
    this.showKeyboardArrows = false,
    this.showValidIcon = true,
    this.lineColor = kAppBlack,
    this.warningLabel,
  }) : super(key: key);

  final bool enabled;
  final bool readonly;
  final TextFieldType textFieldType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final String labelHint;
  final bool error;
  final AutovalidateMode autoValidate;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final TextStyle errorTextStyle;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;
  final EdgeInsets contentPadding;
  final bool enableValidation;
  final Function(bool) onFocusChanged;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final bool hideBottomLine;
  final bool showKeyboardDoneButton;
  final bool showKeyboardArrows;
  final bool showValidIcon;
  final Color lineColor;
  final String warningLabel;

  /// Default border width based on Zest Design System
  static const double _borderWidth = 2;

  // size of suffix icon (green check icon)
  static const double _suffixIconSize = 20;

  static EdgeInsets defaultContentPadding = kSpacer.edgeInsets.y.xs;

  /// Path for ZTextField correct icon
  // TODO(Ikhsan): Will replace suffix icon with Animation or Svg
  static const String _correctIcon = 'assets/icons/ic_text_field_confirmed.png';

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode focusNode;
  bool hasFocused = false;

  void updateStateOnFocusChanged() {
    setState(() {
      hasFocused = focusNode.hasFocus;

      /// focus change callback to use outside this widget
      /// usage example:
      /// In [JourneyInputTextField] when state = focused it show pin icon
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged(hasFocused);
      }
    });
  }

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(updateStateOnFocusChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _contentView;
  }

  Widget get _contentView {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: <Widget>[
            if (widget.labelHint != null)
              Padding(
                padding: EdgeInsets.only(
                  right: kSpacer.xxs,
                ),
                child: Text(
                  widget.labelHint,
                  style: widget.hintTextStyle ??
                      AppTextStyle(color: kAppGreyB).primaryPL,
                ),
              ),
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                enabled: widget.enabled,
                readOnly: widget.readonly,
                controller: widget.controller,
                focusNode: focusNode,
                decoration: inputDecoration,
                style: textStyle,
                validator: widget.validator,
                keyboardType: widget.inputType,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                autovalidateMode: widget.autoValidate,
                inputFormatters: widget.inputFormatters,
                autocorrect: false,
                onChanged: widget.onChanged,
                maxLength: widget.maxLength,
                minLines: (widget.textFieldType == TextFieldType.largeField)
                    ? 4
                    : widget.minLines,
                maxLines: (widget.textFieldType == TextFieldType.largeField)
                    ? 8
                    : widget.maxLines,
                onFieldSubmitted: widget.onFieldSubmitted,
              ),
            ),
          ],
        ),
        if (widget.labelHint != null)
          Container(
            height: 2.0,
            width: double.infinity,
            color: widget.controller.text.isNotEmpty && !widget.error
                ? widget.lineColor
                : kAppGreyC,
          ),
        if (widget.warningLabel != null)
          Padding(
            padding: kSpacer.edgeInsets.top.xxs,
            child: Text(
              widget.warningLabel,
              style: errorStyle,
            ),
          ),
      ],
    );
  }

  /// Get text style based on text field type
  TextStyle get textStyle {
    if (widget.textFieldType == TextFieldType.journeyInput) {
      /// Text color:
      /// kAppBlack (normal), kAppPrimaryElectricBlue (focus)
      return AppTextStyle(
              color: hasFocused ? kAppPrimaryElectricBlue : kAppBlack)
          .primaryPL;
    } else if (widget.textFieldType == TextFieldType.largeField) {
      return widget.textStyle ??
          AppTextStyle(color: widget.error ? kAppFriendlyRed : kAppBlack)
              .primaryLabel1;
    } else {
      /// Text color:
      /// kAppBlack (normal), kAppPrimaryElectricBlue (focus) and red (error)
      return widget.textStyle ??
          AppTextStyle(
                  color: widget.error
                      ? kAppFriendlyRed
                      : hasFocused
                          ? kAppPrimaryElectricBlue
                          : kAppBlack)
              .primaryForm;
    }
  }

  /// Get hint style based on text field type
  TextStyle get hintStyle {
    if (widget.textFieldType == TextFieldType.journeyInput) {
      return AppTextStyle(
        color: hasFocused
            ? kAppPrimaryElectricBlue
            : (widget.hintTextStyle != null
                ? widget.hintTextStyle.color
                : kAppBlack),
      ).primaryPL;
    } else if (widget.textFieldType == TextFieldType.largeField) {
      return widget.hintTextStyle ??
          AppTextStyle(color: kAppGreyB).primaryLabel1;
    } else {
      /// Default hint style
      return widget.hintTextStyle ?? AppTextStyle(color: kAppGreyC).primaryForm;
    }
  }

  /// Get error style
  TextStyle get errorStyle {
    return widget.errorTextStyle ??
        AppTextStyle(color: kAppFriendlyRed).primaryLabel3;
  }

  InputDecoration get inputDecoration {
    /// Check mark icon when form validated
    final Widget checkIcon = Container(
        child: const Image(
      image: AssetImage(
        AppTextField._correctIcon,
      ),
      height: AppTextField._suffixIconSize,
      width: AppTextField._suffixIconSize,
    ));

    // Customized decoration based on Zest Design System
    Color enabledBorderColor;
    if (widget.labelHint != null) {
      enabledBorderColor = kAppClearWhite;
    } else if (widget.textFieldType == TextFieldType.journeyInput) {
      enabledBorderColor = kAppGreyD;
    } else {
      enabledBorderColor = widget.controller.text.isNotEmpty && !widget.error
          ? widget.lineColor
          : kAppGreyC;
    }

    InputDecoration decoration;
    if (widget.textFieldType == TextFieldType.largeField) {
      decoration = InputDecoration(
        hintText: widget.hint,
        hintStyle: hintStyle,
        counterText: '',
        errorStyle: widget.enableValidation ? errorStyle : null,
        contentPadding: widget.contentPadding ?? kSpacer.edgeInsets.y.xs,
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedErrorBorder:
            const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      );
    } else {
      decoration = InputDecoration(
        hintText: widget.hint,
        hintStyle: hintStyle,
        errorStyle: widget.enableValidation ? errorStyle : null,
        isDense: true,
        suffixIconConstraints: const BoxConstraints(
          minWidth: AppTextField._suffixIconSize,
        ),
        // set constraint to make suffix icon close to the right side
        contentPadding: widget.contentPadding ?? kSpacer.edgeInsets.y.xs,
        enabledBorder: widget.hideBottomLine
            ? const OutlineInputBorder(borderSide: BorderSide.none)
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor,
                  width: AppTextField._borderWidth,
                ),
              ),
        focusedBorder: widget.hideBottomLine
            ? const OutlineInputBorder(borderSide: BorderSide.none)
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.labelHint != null
                      ? kAppClearWhite
                      : kAppPrimaryElectricBlue,
                  width: AppTextField._borderWidth,
                ),
              ),
        errorBorder: widget.hideBottomLine
            ? const OutlineInputBorder(borderSide: BorderSide.none)
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.labelHint != null
                      ? kAppClearWhite
                      : kAppFriendlyRed,
                  width: AppTextField._borderWidth,
                ),
              ),
        disabledBorder: widget.hideBottomLine
            ? const OutlineInputBorder(borderSide: BorderSide.none)
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.labelHint != null ? kAppClearWhite : kAppGreyC,
                  width: AppTextField._borderWidth,
                ),
              ),
        suffixIcon: widget.enableValidation
            ? ((widget.controller.text.isNotEmpty && !widget.error)
                ? (widget.showValidIcon ? checkIcon : null)
                : null)
            : null,
      );
    }

    return decoration;
  }

  @override
  void dispose() {
    focusNode.removeListener(updateStateOnFocusChanged);
    super.dispose();
  }
}
