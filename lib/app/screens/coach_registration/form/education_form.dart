import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/utils/data_validation.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';

class EducationFormView extends StatefulWidget {
  const EducationFormView(
      {Key key,
      @required this.formKey,
      @required this.universityTC,
      @required this.programTC,
      @required this.titleTC})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController universityTC;
  final TextEditingController programTC;
  final TextEditingController titleTC;
  @override
  _EducationFormViewState createState() => _EducationFormViewState();
}

class _EducationFormViewState extends State<EducationFormView> {
  final FocusNode universityFN = FocusNode();
  final FocusNode programFN = FocusNode();
  final FocusNode titleFN = FocusNode();

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  @override
  void dispose() {
    universityFN.dispose();
    programFN.dispose();
    titleFN.dispose();
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
          bindFormField(widget.universityTC, universityFN,
              labelText: 'University',
              maxLength: 15,
              textInputType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (String s) => _validator(
                  controller: widget.universityTC,
                  text: widget.universityTC.text),
              onFieldSubmitted: (_) => _requestFocus(programFN)),
          bindFormField(widget.programTC, programFN,
              labelText: 'Program / Degrees',
              maxLength: 15,
              textInputType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (String s) => _validator(
                  controller: widget.programTC, text: widget.programTC.text),
              onFieldSubmitted: (_) => _requestFocus(titleFN)),
          bindFormField(widget.titleTC, titleFN,
              labelText: 'Title',
              maxLength: 15,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (String s) => _validator(
                  controller: widget.titleTC, text: widget.titleTC.text),
              onFieldSubmitted: (_) => _resetFocus()),
          _appSpacer.vHsm,
        ],
      ),
    );
  }

  Widget bindFormField(TextEditingController tc, FocusNode fn,
      {Widget prefix,
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
    if (controller == widget.universityTC) {
      return DataValidation.basicLengthIsValid(text,
          tag: 'University', minLength: 3);
    } else if (controller == widget.programTC) {
      return DataValidation.basicLengthIsValid(text,
          tag: 'Program', minLength: 3);
    } else if (controller == widget.titleTC) {
      return DataValidation.basicLengthIsValid(text, tag: 'Title');
    }
    return null;
  }
}

class EducationFormData {
  EducationFormData({this.university, this.program, this.title});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController universityTC = TextEditingController();
  final TextEditingController programTC = TextEditingController();
  final TextEditingController titleTC = TextEditingController();

  String university;
  String program;
  String title;

  bool editData = false;

  bool get isPopulated =>
      university.isNotNullOrEmpty &&
      program.isNotNullOrEmpty &&
      title.isNotNullOrEmpty;

  void setDataFromTC() {
    editData = false;
    university = universityTC.text;
    program = programTC.text;
    title = titleTC.text;
  }

  void deleteData() {
    university = null;
    program = null;
    title = null;
  }
}
