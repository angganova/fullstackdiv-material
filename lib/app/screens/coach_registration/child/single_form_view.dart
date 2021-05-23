import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_vm.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/form/single_form.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/model/single_form_data.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/basic_child_view.dart';

class CoachSingleFormView extends StatefulWidget {
  const CoachSingleFormView(
      {Key key,
      @required this.viewModel,
      @required this.singleFormType,
      this.onFinished})
      : super(key: key);
  final CoachRegistrationVM viewModel;
  final SingleFormType singleFormType;
  final Function(SingleFormDataModel) onFinished;
  @override
  _CoachSingleFormViewState createState() => _CoachSingleFormViewState();
}

class _CoachSingleFormViewState extends State<CoachSingleFormView> {
  final SingleFormDataModel _dataModel = SingleFormDataModel();

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  @override
  void dispose() {
    _dataModel.singleTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context);

    return CoachBasicChildView(
      parentBuildContext: widget.viewModel.widgetScaffoldContext,
      title: title,
      child: _contentView,
      onSubmit: _ctaSubmit,
      onCancel: _ctaCancel,
    );
  }

  Widget get _contentView {
    return Column(
      children: <Widget>[
        _formView,
        _appSpacer.vHStandard,
      ],
    );
  }

  Widget get _formView {
    return Padding(
      padding: _appSpacer.edgeInsets.x.sm,
      child: SingleTextFieldFormView(
        formKey: _dataModel.formKey,
        tc: _dataModel.singleTC,
        textCapitalization: TextCapitalization.words,
        label: label,
        maxLength: 200,
        showCounter: true,
        bigTextForm: true,
      ),
    );
  }

  void _ctaSubmit() {
    if (_isValid) {
      widget.onFinished(_dataModel);
      widget.viewModel.ctaNext();
    }
  }

  void _ctaCancel() {
    widget.viewModel.ctaBack();
  }

  bool get _isValid {
    if (!_dataModel.isPopulated) {
      /// Show snackbar / toast
      return false;
    }

    return true;
  }

  String get title {
    switch (widget.singleFormType) {
      case SingleFormType.biography:
        return 'Biography';
      case SingleFormType.additionalInformation:
        return 'Additional Information'
            '\n\n'
            'Is there any other information that you would you like us to consider?';
      default:
        return '';
    }
  }

  String get label {
    switch (widget.singleFormType) {
      case SingleFormType.biography:
        return 'Biography';
      case SingleFormType.additionalInformation:
        return null;
      default:
        return '';
    }
  }
}

enum SingleFormType { biography, additionalInformation }
