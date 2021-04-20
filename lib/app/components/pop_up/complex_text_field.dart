import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/app/components/text_field/text_input_formatter.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/utils/data_utils.dart';

enum ComplexTextInputType {
  none,
  number,
  name,
  cardNumber,
  securityCodeNumber,
  expirationDate,
  withSpecialChar,
}

///
///
/// Text Field Component built using Flutter [TextField]
class ComplexTextInput extends StatefulWidget {
  const ComplexTextInput({
    Key key,
    @required this.focusNode,
    this.placeholder,
    this.labelPlaceholder,
    this.controller,
    this.isEnabled = true,
    this.textColor = kAppBlack,
    this.maxLength = 0,
    this.minLength = 0,
    this.errorMessage,
    this.icon,
    this.onSubmitted,
    this.onIconTap,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.isRTL = false,
    this.textInputAction = TextInputAction.next,
    this.textStyle,
    this.textAlignment,
    this.singleBorder = false,
    this.onChanged,
    this.borderInactiveColor = kAppGreyD,
    this.inputType,
    this.widgetTheme = WidgetTheme.whitePrimary,
    this.maskType,
  }) : super(key: key);

  /// required
  final FocusNode focusNode;
  final ComplexTextInputType maskType;
  final WidgetTheme widgetTheme;

  /// optional
  final String placeholder;
  final String labelPlaceholder;
  final TextEditingController controller;
  final bool isEnabled;
  final bool readOnly;
  final Color textColor;
  final int maxLength;
  final int minLength;
  final String errorMessage;
  final IconData icon;
  final VoidCallback onIconTap;
  final VoidCallback onTap;
  final bool isRTL;
  final TextInputAction textInputAction;
  final TextStyle textStyle;
  final TextAlign textAlignment;
  final bool singleBorder;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final TextCapitalization textCapitalization;
  final Color borderInactiveColor;
  final TextInputType inputType;
  @override
  _ComplexTextInputState createState() => _ComplexTextInputState();
}

class _ComplexTextInputState extends State<ComplexTextInput> {
  Color get _backgroundColor {
    return widget.isEnabled ? kAppWhite : kAppGreyD;
  }

  Color get _borderColor {
    if (widget.readOnly) {
      return kAppGreyD;
    } else if (!widget.isEnabled) {
      return widget.borderInactiveColor;
    } else if (widget.errorMessage.isNotNullOrEmpty) {
      return kAppFriendlyRed;
    } else if (widget.focusNode.hasFocus) {
      return widget.widgetTheme.textColor;
    } else {
      return widget.borderInactiveColor;
    }
  }

  Color get _placeholderColor {
    if (widget.readOnly) {
      return kAppGreyC;
    } else if (!widget.isEnabled) {
      return kAppGreyA;
    } else if (widget.errorMessage.isNotNullOrEmpty) {
      return kAppFriendlyRed;
    } else if (widget.focusNode.hasFocus) {
      return widget.widgetTheme.textColor;
    } else {
      return kAppGreyC;
    }
  }

  Color get _iconColor {
    if (widget.readOnly) {
      return kAppGreyB;
    } else if (!widget.isEnabled) {
      return kAppGreyA;
    } else if (widget.errorMessage.isNotNullOrEmpty) {
      return kAppFriendlyRed;
    } else if (widget.focusNode.hasFocus) {
      return widget.widgetTheme.textColor;
    } else {
      return kAppGreyA;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _contentView;
  }

  Widget get _contentView {
    return Column(
      children: <Widget>[
        if (widget.icon != null)
          Padding(
            padding: kSpacer.edgeInsets.left.xs,
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: kSmallIconSize,
                  color: _iconColor,
                ),
                GestureDetector(
                  onTap: widget.onIconTap,
                  child: Container(
                    width: kSpacer.lg,
                    height: kSpacer.lg,
                    color: kAppClearWhite,
                  ),
                ),
              ],
            ),
          ),

        Container(
          padding: widget.singleBorder
              ? kSpacer.edgeInsets.all.none
              : kSpacer.edgeInsets.x.sm,
          margin: widget.singleBorder
              ? kSpacer.edgeInsets.all.none
              : (widget.errorMessage != null && widget.errorMessage.isNotEmpty)
                  ? kSpacer.edgeInsets.bottom.xs
                  : kSpacer.edgeInsets.all.none,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ///
              ///
              /// Text Field
              Expanded(
                child: TextField(
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  style: widget.textStyle ?? AppTextStyle().primaryLabel1,
                  enabled: widget.isEnabled,
                  keyboardType: widget.inputType,
                  textInputAction: widget.textInputAction,
                  textCapitalization:
                      widget.textCapitalization ?? TextCapitalization.none,
                  textAlign: widget.textAlignment ??
                      (widget.labelPlaceholder != null
                          ? TextAlign.left
                          : TextAlign.right),
                  textDirection:
                      widget.isRTL ? TextDirection.rtl : TextDirection.ltr,
                  readOnly: widget.readOnly,
                  onTap: widget.readOnly && widget.onTap != null
                      ? widget.onTap
                      : null,
                  cursorColor: widget.widgetTheme.textColor,
                  onSubmitted: widget.onSubmitted,
                  onChanged: widget.onChanged,
                  inputFormatters: widget.maskType.getMask(
                    widget.controller?.text,
                    widget.maxLength,
                  ),
                  decoration: InputDecoration(
                    isDense: widget.singleBorder,
                    contentPadding: kSpacer.edgeInsets.all.none,
                    border: InputBorder.none,
                    hintText: widget.placeholder,
                    hintStyle: (widget.textStyle != null)
                        ? widget.textStyle.copyWith(color: _placeholderColor)
                        : AppTextStyle(color: _placeholderColor).primaryLabel1,
                  ),
                ),
              ),

              ///
              ///
              /// Label Placeholder
              if (widget.labelPlaceholder != null && widget.singleBorder)
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: GestureDetector(
                    onTap: () => widget.focusNode?.requestFocus(),
                    child: Text(
                      widget.labelPlaceholder,
                      style: (widget.textStyle != null)
                          ? widget.textStyle.copyWith(color: kAppGreyB)
                          : AppTextStyle(color: kAppGreyB).primaryLabel1,
                    ),
                  ),
                )
              else if (widget.labelPlaceholder != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: AppSpacer(context: context).sm,
                    bottom: 1.0,
                  ),
                  child: GestureDetector(
                    onTap: () => widget.focusNode?.requestFocus(),
                    child: Text(
                      widget.labelPlaceholder,
                      style: (widget.textStyle != null)
                          ? widget.textStyle.copyWith(color: kAppGreyB)
                          : AppTextStyle(color: kAppGreyB).primaryLabel1,
                    ),
                  ),
                ),
            ],
          ),

          ///
          ///
          /// Setting up Border & Shadow
          decoration: BoxDecoration(
            border: widget.singleBorder
                ? Border.all(color: kAppClearWhite, width: 0.0)
                : Border.all(color: _borderColor, width: 2.0),
            color: _backgroundColor,
            borderRadius: widget.singleBorder
                ? BorderRadius.zero
                : BorderRadius.circular(kBorderRadiusExtraSmall),
            boxShadow: widget.singleBorder
                ? <BoxShadow>[]
                : <BoxShadow>[
                    BoxShadow(
                      color: kAppBlack.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 3,
                    ),
                  ],
          ),
        ),

        if (widget.singleBorder)
          Container(
            height: 2.0,
            color: _borderColor,
            width: double.infinity,
            margin: kSpacer.edgeInsets.top.xs,
          ),

        /// Error Message
        if (widget.errorMessage != null)
          Container(
            margin: widget.singleBorder
                ? kSpacer.edgeInsets.only(left: 'xxs', top: 'xs')
                : kSpacer.edgeInsets.left.xxs,
            alignment: Alignment.centerLeft,
            child: Text(
              widget.errorMessage,
              style: AppTextStyle(color: kAppFriendlyRed).primaryLabel3,
            ),
          )
      ],
    );
  }
}

///
///
/// Extension of [ComplexTextField] returning Input Formatter & Keyboard Type
extension ComplexTextInputTypeExt on ComplexTextInputType {
  List<TextInputFormatter> getMask(String text, int maxLength) {
    switch (this) {
      case ComplexTextInputType.cardNumber:
        return <TextInputFormatter>[
          TextInputMask(mask: '9999 9999 9999 999?9?'),
          if (maxLength > 0) LengthLimitingTextInputFormatterNormal(maxLength),
        ];
      case ComplexTextInputType.securityCodeNumber:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(DataUtils.numberPattern.toString()),
          ),
          if (maxLength > 0)
            LengthLimitingTextInputFormatterNormal(maxLength)
          else
            LengthLimitingTextInputFormatterNormal(4),
        ];
      case ComplexTextInputType.number:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(DataUtils.numberPattern.toString()),
          ),
          if (maxLength > 0)
            LengthLimitingTextInputFormatterNormal(maxLength)
          else
            LengthLimitingTextInputFormatterNormal(11),
        ];
      case ComplexTextInputType.expirationDate:
        return <TextInputFormatter>[
          TextInputMask(mask: '99/9999'),
          if (maxLength > 0) LengthLimitingTextInputFormatterNormal(maxLength),
        ];
      case ComplexTextInputType.name:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(r'[\p{L}\s]', unicode: true),
          ),
          if (maxLength > 0) LengthLimitingTextInputFormatterNormal(maxLength),
        ];
      case ComplexTextInputType.withSpecialChar:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(r"[0-9-a-zA-Z\ \']"),
          ),
          if (maxLength > 0) LengthLimitingTextInputFormatterNormal(maxLength),
        ];
      default:
        if (maxLength > 0) {
          return <TextInputFormatter>[
            LengthLimitingTextInputFormatterNormal(maxLength),
          ];
        } else {
          return null;
        }
    }
  }
}
