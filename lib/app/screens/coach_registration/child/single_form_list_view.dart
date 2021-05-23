import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_vm.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/form/single_form.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/model/single_form_data.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/basic_child_view.dart';

class CoachSingleFormListView extends StatefulWidget {
  const CoachSingleFormListView(
      {Key key,
      @required this.viewModel,
      @required this.singleFormListType,
      this.onFinished})
      : super(key: key);
  final CoachRegistrationVM viewModel;
  final SingleFormListType singleFormListType;
  final Function(List<SingleFormDataModel>) onFinished;
  @override
  _CoachSingleFormListViewState createState() =>
      _CoachSingleFormListViewState();
}

class _CoachSingleFormListViewState extends State<CoachSingleFormListView> {
  List<SingleFormDataModel> dataList = <SingleFormDataModel>[
    SingleFormDataModel()
  ];

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  @override
  void dispose() {
    for (final SingleFormDataModel element in dataList) {
      element.singleTC.dispose();
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
      title: title,
      child: _contentView,
      onSubmit: _ctaSubmit,
      onCancel: _ctaCancel,
    );
  }

  Widget get _contentView {
    return Column(
      children: <Widget>[
        _dataListView,
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
            onTap: _ctaAddNewDataForm,
          ),
        ),
        _appSpacer.vHStandard,
      ],
    );
  }

  Widget get _dataListView {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        padding: _appSpacer.edgeInsets.all.none,
        itemBuilder: (_, int index) => bindData(index));
  }

  Widget bindData(int index) {
    final SingleFormDataModel item = dataList[index];

    if (item.editData) {
      return bindDataForm(index);
    } else if (item.isPopulated) {
      return bindDataCard(index);
    } else {
      return bindDataForm(index);
    }
  }

  Widget bindDataForm(int index) {
    final SingleFormDataModel item = dataList[index];
    return Padding(
      padding: _appSpacer.edgeInsets.x.sm,
      child: SingleTextFieldFormView(
        formKey: item.formKey,
        tc: item.singleTC,
        textCapitalization: TextCapitalization.words,
        label: label,
        onSubmit: () => _ctaSetData(index),
      ),
    );
  }

  Widget bindDataCard(int index) {
    final SingleFormDataModel item = dataList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          _appSpacer.vWsm,
          Expanded(
              child: Text(
            item.singleFormData,
            style: TextStyle(
                fontSize: _appQuery.width / 26, fontWeight: FontWeight.w700),
          )),
          _appSpacer.vWsm,
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _ctaDeleteData(index)),
        ],
      ),
    );
  }

  void _ctaDeleteData(int index) {
    if (dataList.length > 1) {
      setState(() {
        dataList.removeAt(index);
      });
    }
  }

  void _ctaSetData(int index) {
    final SingleFormDataModel item = dataList[index];
    final bool isFormValid = item.formKey.currentState.validate();
    if (isFormValid) {
      setState(() {
        item.setDataFromTC();
      });
    }
  }

  void _ctaAddNewDataForm() {
    dataList ??= <SingleFormDataModel>[];

    if (dataList.isNotEmpty) {
      final SingleFormDataModel lastFormData = dataList.last;
      if (lastFormData.isPopulated) {
        setState(() {
          dataList.add(SingleFormDataModel());
        });
      }
    } else {
      setState(() {
        dataList.add(SingleFormDataModel());
      });
    }
  }

  void _ctaSubmit() {
    if (_isValid) {
      widget.onFinished(dataList);
      widget.viewModel.ctaNext();
    }
  }

  void _ctaCancel() {
    widget.viewModel.ctaBack();
  }

  bool get _isValid {
    bool valid = true;

    for (final SingleFormDataModel item in dataList) {
      if (!item.isPopulated) {
        valid = false;
      }
    }

    if (!valid) {
      /// Show snackbar / toast
    }

    return valid;
  }

  String get title {
    switch (widget.singleFormListType) {
      case SingleFormListType.profession:
        return 'Profession';
      case SingleFormListType.language:
        return 'Languages Spoken';
      case SingleFormListType.websiteAndSocialMedia:
        return 'Website and Social Media';
      default:
        return '';
    }
  }

  String get label {
    switch (widget.singleFormListType) {
      case SingleFormListType.profession:
        return 'Profession';
      case SingleFormListType.language:
        return 'Language';
      case SingleFormListType.websiteAndSocialMedia:
        return 'URL';
      default:
        return '';
    }
  }
}

enum SingleFormListType { profession, language, websiteAndSocialMedia }
