import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/utils/data_validation.dart';

class SingleTextFieldFormView extends StatefulWidget {
  const SingleTextFieldFormView(
      {Key key,
      @required this.formKey,
      @required this.tc,
      @required this.label,
      this.textCapitalization = TextCapitalization.sentences,
      this.onSubmit,
      this.showCounter = false,
      this.maxLength,
      this.bigTextForm = false})
      : super(key: key);
  final String label;
  final GlobalKey<FormState> formKey;
  final TextEditingController tc;
  final TextCapitalization textCapitalization;
  final VoidCallback onSubmit;

  final bool showCounter;
  final int maxLength;
  final bool bigTextForm;
  @override
  _SingleTextFieldFormViewState createState() =>
      _SingleTextFieldFormViewState();
}

class _SingleTextFieldFormViewState extends State<SingleTextFieldFormView> {
  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        child: TextFormField(
          controller: widget.tc,
          textCapitalization: widget.textCapitalization,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (String s) => widget.onSubmit(),
          validator: (String s) =>
              _validator(controller: widget.tc, text: widget.tc.text),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: widget.maxLength,
          maxLines: widget.bigTextForm ? 5 : 1,
          decoration: InputDecoration(
              labelText: widget.label,
              counterText: widget.showCounter ? null : ''),
        ),
      ),
    );
  }

  String _validator({TextEditingController controller, String text}) {
    if (controller == widget.tc) {
      return DataValidation.basicLengthIsValid(text, tag: widget.label);
    } else {
      return null;
    }
  }
}
