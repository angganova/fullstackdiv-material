import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/utils/data_validation.dart';

class CoachConfirmationFormView extends StatefulWidget {
  const CoachConfirmationFormView({
    Key key,
    @required this.formKey,
    @required this.titleTC,
    @required this.urlTC,
    @required this.categoryTC,
    @required this.descriptionTC,
    this.showCategory = false,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController titleTC;
  final TextEditingController urlTC;
  final TextEditingController categoryTC;
  final TextEditingController descriptionTC;
  final bool showCategory;
  @override
  _CoachConfirmationFormViewState createState() =>
      _CoachConfirmationFormViewState();
}

class _CoachConfirmationFormViewState extends State<CoachConfirmationFormView> {
  final FocusNode urlFN = FocusNode();
  final FocusNode categoryFN = FocusNode();
  final FocusNode descriptionFN = FocusNode();

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  @override
  void dispose() {
    urlFN.dispose();
    descriptionFN.dispose();
    categoryFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context);
    return _formField;
  }

  Widget get _formField {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          bindFormField(widget.titleTC,
              labelText: 'Title',
              textInputType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (String s) => _validator(
                  controller: widget.titleTC, text: widget.titleTC.text),
              onFieldSubmitted: (_) => _requestFocus(urlFN)),
          bindFormField(widget.urlTC,
              fn: urlFN,
              labelText: 'URL',
              validator: (String s) =>
                  _validator(controller: widget.urlTC, text: widget.urlTC.text),
              onFieldSubmitted: (_) => _requestFocus(
                  widget.showCategory ? categoryFN : descriptionFN)),
          if (widget.showCategory)
            bindFormField(widget.categoryTC,
                fn: categoryFN,
                labelText: 'Category',
                textInputType: TextInputType.text,
                validator: (String s) => _validator(
                    controller: widget.categoryTC,
                    text: widget.categoryTC.text),
                onFieldSubmitted: (_) => _requestFocus(descriptionFN)),
          bindFormField(widget.descriptionTC,
              fn: descriptionFN,
              labelText: 'Description',
              textInputType: TextInputType.text,
              validator: (String s) => _validator(
                  controller: widget.descriptionTC,
                  text: widget.descriptionTC.text),
              onFieldSubmitted: (_) => _resetFocus()),
          _appSpacer.vHsm,
        ],
      ),
    );
  }

  Widget bindFormField(TextEditingController tc,
      {FocusNode fn,
      Widget prefix,
      Widget suffix,
      String labelText,
      String hintText,
      int maxLength = 45,
      TextCapitalization textCapitalization = TextCapitalization.none,
      TextInputAction textInputAction = TextInputAction.next,
      TextInputType textInputType = TextInputType.text,
      FormFieldValidator<String> validator,
      Function(String) onFieldSubmitted}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: TextFormField(
        controller: tc,
        focusNode: fn,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLength: maxLength,
        onFieldSubmitted: (String s) => onFieldSubmitted(s),
        validator: validator,
        autovalidateMode: validator == null
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefix: prefix,
            suffix: suffix,
            counterText: ''),
      ),
    );
  }

  void _requestFocus(FocusNode fn) => FocusScope.of(context).requestFocus(fn);

  void _resetFocus() => FocusScope.of(context).requestFocus(FocusNode());

  String _validator({TextEditingController controller, String text}) {
    if (controller == widget.urlTC) {
      return DataValidation.basicLengthIsValid(text, tag: 'URL');
    } else if (controller == widget.descriptionTC) {
      return DataValidation.basicLengthIsValid(text, tag: 'Description');
    } else if (controller == widget.titleTC) {
      return DataValidation.basicLengthIsValid(text, tag: 'Title');
    } else if (controller == widget.categoryTC) {
      return DataValidation.basicLengthIsValid(text, tag: 'Category');
    }
    return null;
  }
}
