import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_vm.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/form/education_form.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/basic_child_view.dart';

class CoachEducationView extends StatefulWidget {
  const CoachEducationView({Key key, this.viewModel}) : super(key: key);
  final CoachRegistrationVM viewModel;
  @override
  _CoachEducationViewState createState() => _CoachEducationViewState();
}

class _CoachEducationViewState extends State<CoachEducationView> {
  List<EducationFormData> educationList = <EducationFormData>[
    EducationFormData()
  ];

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  File selectedFile;
  String selectedImagePath;

  @override
  void dispose() {
    for (final EducationFormData element in educationList) {
      element.universityTC.dispose();
      element.programTC.dispose();
      element.titleTC.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context);

    return CoachBasicChildView(
      parentBuildContext: widget.viewModel.widgetScaffoldContext,
      title: 'Education',
      child: _contentView,
      onSubmit: _ctaSubmit,
      onCancel: _ctaCancel,
    );
  }

  Widget get _contentView {
    return Padding(
      padding: _appSpacer.edgeInsets.x.sm,
      child: Column(
        children: <Widget>[
          _educationListView,
          _appSpacer.vHStandard,
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(180)),
              child: Container(
                padding: _appSpacer.edgeInsets.all.xs,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.indigo),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              onTap: _ctaAddNewEducationForm,
            ),
          ),
          _appSpacer.vHStandard,
        ],
      ),
    );
  }

  Widget get _educationListView {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: educationList.length,
        padding: _appSpacer.edgeInsets.all.none,
        itemBuilder: (_, int index) => bindEducation(index));
  }

  Widget bindEducation(int index) {
    final EducationFormData item = educationList[index];

    if (item.editData) {
      return bindEducationForm(index);
    } else if (item.isPopulated) {
      return bindEducationCard(index);
    } else {
      return bindEducationForm(index);
    }
  }

  Widget bindEducationForm(int index) {
    final EducationFormData item = educationList[index];
    return Column(
      children: <Widget>[
        EducationFormView(
            formKey: item.formKey,
            universityTC: item.universityTC,
            programTC: item.programTC,
            titleTC: item.titleTC),
        Row(
          children: <Widget>[
            if (index != 0)
              Expanded(
                child: FlatButton(
                    onPressed: () => _ctaDeleteEducation(index),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: _appQuery.width / 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    )),
              ),
            if (index != 0) _appSpacer.vWsm,
            Expanded(
              child: FlatButton(
                  onPressed: () => _ctaSetEducation(index),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: _appQuery.width / 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  )),
            )
          ],
        )
      ],
    );
  }

  Widget bindEducationCard(int index) {
    final EducationFormData item = educationList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _appSpacer.vWsm,
              Expanded(
                  child: Text(
                'Education ${index + 1}',
                style: TextStyle(
                    fontSize: _appQuery.width / 26,
                    fontWeight: FontWeight.w700),
              )),
              _appSpacer.vWsm,
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _ctaDeleteEducation(index)),
            ],
          ),
          _bindTitleSubtitle('University', item.university),
          _bindTitleSubtitle('Programs / Degrees', item.program),
          _bindTitleSubtitle('Title', item.title),
          _appSpacer.vHsm,
          Container(
            width: _appQuery.width / 3,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: _appSpacer.edgeInsets.x.standard,
              onPressed: () => _ctaEditEducation(index),
              color: Colors.indigo,
              child: Text(
                'Edit',
                style: TextStyle(
                    fontSize: _appQuery.width / 26, color: Colors.white),
              ),
            ),
          ),
          _appSpacer.vHsm,
        ],
      ),
    );
  }

  Widget _bindTitleSubtitle(String title, String subtitle) {
    return Container(
      width: _appQuery.width,
      padding: _appSpacer.edgeInsets.symmetric(x: 'sm', y: 'xs'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style:
                TextStyle(fontSize: _appQuery.width / 30, color: Colors.indigo),
          ),
          _appSpacer.vHxs,
          Text(
            subtitle,
            style:
                TextStyle(fontSize: _appQuery.width / 26, color: Colors.grey),
          )
        ],
      ),
    );
  }

  void _ctaDeleteEducation(int index) {
    if (educationList.length > 1) {
      setState(() {
        educationList.removeAt(index);
      });
    }
  }

  void _ctaEditEducation(int index) {
    final EducationFormData item = educationList[index];
    setState(() {
      item.editData = true;
    });
  }

  void _ctaSetEducation(int index) {
    final EducationFormData item = educationList[index];
    final bool isFormValid = item.formKey.currentState.validate();
    if (isFormValid) {
      setState(() {
        item.setDataFromTC();
      });
    }
  }

  void _ctaAddNewEducationForm() {
    educationList ??= <EducationFormData>[];

    if (educationList.isNotEmpty) {
      final EducationFormData lastEducationFormData = educationList.last;
      if (lastEducationFormData.isPopulated) {
        setState(() {
          educationList.add(EducationFormData());
        });
      }
    } else {
      setState(() {
        educationList.add(EducationFormData());
      });
    }
  }

  void _ctaSubmit() {
    if (_isValid) {
      widget.viewModel.ctaNext();
    }
  }

  void _ctaCancel() {
    widget.viewModel.ctaBack();
  }

  bool get _isValid {
    bool valid = true;

    for (final EducationFormData item in educationList) {
      if (!item.isPopulated) {
        valid = false;
      }
    }

    if (!valid) {
      /// Show snackbar / toast
    }

    return valid;
  }
}
