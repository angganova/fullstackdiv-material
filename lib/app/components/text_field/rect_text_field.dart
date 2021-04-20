import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/divider/divider.dart';
import 'package:fullstackdiv_material/app/components/pop_up/complex_text_field.dart';
import 'package:fullstackdiv_material/app/components/text_field/text_field_type.dart';
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
        this.leadingWidget,
        this.trailingWidget,
        this.label,
        this.errorText,
        this.inputType,
        this.textCapitalization,
        this.bgColor,
        this.onTextChange,
        this.leadingWidgetDivider = true,
        this.enabled = true,
        this.textFieldType = TextFieldType.standard,
        this.maxLength,
        this.radius,
        this.maskType,
        this.hint})
      : super(key: key);
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onTextChange;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget leadingWidget;
  final bool leadingWidgetDivider;
  final Widget trailingWidget;
  final String label;
  final String hint;
  final String errorText;
  final Color bgColor;
  final TextInputType inputType;
  final TextCapitalization textCapitalization;
  final bool enabled;
  final TextFieldType textFieldType;
  final int maxLength;
  final BorderRadius radius;
  final ComplexTextInputType maskType;

  @override
  _AppRectangleBorderTextFieldState createState() =>
      _AppRectangleBorderTextFieldState();
}

class _AppRectangleBorderTextFieldState
    extends State<AppRectangleBorderTextField> {
  AppSpacer _appSpacer;

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor ?? kAppClearWhite,
          borderRadius: widget.radius ??
              AppRadius.createCircularRadius(kBorderRadiusExtraSmall)),
      child: TextFormField(
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        onChanged: widget.onTextChange,
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: widget.textInputAction,
        obscureText: widget.obscureText ?? false,
        keyboardType: widget.inputType,
        textCapitalization:
        widget.textCapitalization ?? TextCapitalization.none,
        style: AppTextStyle(context: context).primaryPL,
        enabled: widget.enabled,
        minLines: (widget.textFieldType == TextFieldType.largeField) ? 4 : 1,
        maxLines: (widget.textFieldType == TextFieldType.largeField) ? 8 : 1,
        maxLength: widget.maxLength,
        inputFormatters: widget.maskType == null
            ? null
            : widget.maskType.getMask(
          widget.textEditingController.text,
          widget.maxLength ?? 0,
        ),
        decoration: InputDecoration(
          counterText: '',
          errorText: widget.errorText,
          errorMaxLines: 99,
          labelText: widget.label,
          hintText: widget.hint,
          alignLabelWithHint: true,
          prefixIcon: widget.leadingWidget == null
              ? null
              : Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: widget.leadingWidgetDivider
                    ? _appSpacer.edgeInsets.x.xs
                    : _appSpacer.edgeInsets.x.sm,
                child: widget.leadingWidget,
              ),
              if (widget.leadingWidgetDivider) const AppHDivider(width: 2),
              if (widget.leadingWidgetDivider) _appSpacer.vWxs
            ],
          ),
          suffixIcon: widget.trailingWidget,
          fillColor: kAppGreyC,
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.radius ??
                AppRadius.createCircularRadius(kBorderRadiusExtraSmall),
            borderSide: const BorderSide(
              color: kAppPrimaryColor,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.radius ??
                AppRadius.createCircularRadius(kBorderRadiusExtraSmall),
            borderSide: const BorderSide(
              color: kAppGreyC,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: widget.radius ??
                AppRadius.createCircularRadius(kBorderRadiusExtraSmall),
            borderSide: const BorderSide(
              color: kAppFriendlyRed,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: widget.radius ??
                AppRadius.createCircularRadius(kBorderRadiusExtraSmall),
            borderSide: const BorderSide(
              color: kAppFriendlyRed,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.radius ??
                AppRadius.createCircularRadius(kBorderRadiusExtraSmall),
            borderSide: const BorderSide(
              color: kAppGreyC,
              width: 2.0,
            ),
          ),
          errorStyle: AppTextStyle(context: context, color: kAppFriendlyRed)
              .primaryLabel1,
        ),
      ),
    );
  }
}