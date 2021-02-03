import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

/// A pin field component
///
/// ZPin is a [TextFormField] built from `pin_input_text_field` library
/// that has a customized style to fits Zest design system
/// Intended to create pin field like common OTP field
///
/// Library reference : https://pub.dev/packages/pin_input_text_field
///
class AppPin extends StatelessWidget {
  /// Creates a basic Pin input widget
  ///
  /// The [formKey] and [controller] arguments must not be null. Additionally,
  /// [formKey] is Global key intended to call save function of flutter form class
  /// [controller] is basic [TextEditingController] to control input text field
  const AppPin(
      {Key key,
      @required this.formKey,
      @required this.controller,
      this.correctPin,
      this.focused,
      this.autoFocus = false,
      this.obscureEnable = false,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.onSubmit,
      this.enable = true,
      this.error = false,
      this.pinFilled = false,
      this.inputType = TextInputType.text,
      this.textCapitalization = TextCapitalization.characters,
      this.obscureText = '●'})
      : super(key: key);

  /// Default max pin length.
  /// For now we only have 4 digit PIN
  static const int pinLength = 6;

  /// Defaults to false
  /// Must be equal to focused on Widget Creation
  final bool autoFocus;

  /// This correct pin value is optional
  /// If there's no security concern to check it on the fly
  /// we can just put the correct pin into ZPin constructor
  final String correctPin;

  final GlobalKey<FormFieldState<String>> formKey;

  /// Control the input text field.
  final TextEditingController controller;

  /// Control whether textField is enable.
  final bool enable; // = true;

  /// Indicate whether the PinInputTextFormField has error or not
  /// after being validated.
  final bool error; // = false;

  final bool pinFilled; // = false;

  /// Set true if we want field to be obscure
  final bool obscureEnable;

  /// Character for obscure text
  /// default value = `●`
  final String obscureText;

  /// Indicate that pin field on the focused state (keyboard showing)
  /// We don't use [FocusNode] as we cannot detect keyboard visibility by using it
  final bool focused;

  /// We can do like text field validation on text changed
  /// by defining this function
  final Function(String) onChanged;

  /// We can use this function to validate all field
  final ValueChanged<String> onSubmit;

  final Function(String) onSaved;

  final FormFieldValidator<String> validator;

//  final List<FormFieldValidator> validators;

  /// Refer to [TextInputType]
  final TextInputType inputType;

  /// Refer to [TextInputType]
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    /// 4 Different states of pin field that will affect underline border style and text style:
    /// - Error -> kAppFriendlyRed
    /// - Focused -> kAppPrimaryElectricBlue
    /// - Unfocused & Filled -> kAppBlack
    /// - Default State (Unfocused & Not filled) -> kAppGreyC (applied to underline only)
    final PinDecoration pinDecoration = UnderlineDecoration(
      colorBuilder: PinListenColorBuilder(
          error
              ? kAppFriendlyRed
              : (focused ? kAppPrimaryElectricBlue : kAppBlack),
          focused ? kAppPrimaryElectricBlue : kAppGreyC),
      textStyle: AppTextStyle(
              color: error
                  ? kAppFriendlyRed
                  : (focused ? kAppPrimaryElectricBlue : kAppBlack))
          .primaryForm,
      obscureStyle: ObscureStyle(
        isTextObscure: obscureEnable,
        obscureText: obscureText,
      ),
      errorTextStyle: AppTextStyle(color: kAppFriendlyRed).primaryLabel3,
    );

    return PinInputTextFormField(
        key: formKey,
        autoFocus: autoFocus,
        pinLength: pinLength,
        decoration: pinDecoration,
        controller: controller,
        textInputAction: TextInputAction.go,
        enabled: enable,
        keyboardType: inputType,
        textCapitalization: textCapitalization,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSubmit: onSubmit,
        onChanged: onChanged,
        onSaved: onSaved,
        enableInteractiveSelection: false,
        validator: validator);
  }
}
