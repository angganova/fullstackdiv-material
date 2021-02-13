import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/styles/radius.dart';

class AppRectangleBorderTextField extends StatefulWidget {
  const AppRectangleBorderTextField(
      {Key key,
      this.textEditingController,
      this.focusNode,
      this.onFieldSubmitted,
      this.textInputAction,
      this.obscureText,
      this.leadingIcon,
      this.trailingIcon,
      this.label})
      : super(key: key);
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget leadingIcon;
  final Widget trailingIcon;
  final String label;

  @override
  _AppRectangleBorderTextFieldState createState() =>
      _AppRectangleBorderTextFieldState();
}

class _AppRectangleBorderTextFieldState
    extends State<AppRectangleBorderTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.leadingIcon,
          suffixIcon: widget.trailingIcon,
          fillColor: kAppGreyC,
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.createCircularRadius(16),
            borderSide: BorderSide(
              color: kAppPrimaryColor,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.createCircularRadius(16),
            borderSide: BorderSide(
              color: kAppGreyA,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.createCircularRadius(16),
            borderSide: BorderSide(
              color: kAppFriendlyRed,
              width: 2.0,
            ),
          )),
    );
  }
}
