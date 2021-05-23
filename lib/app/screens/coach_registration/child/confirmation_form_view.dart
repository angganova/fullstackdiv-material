import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_vm.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/form/confirmation_form.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/model/confirmation_form_data.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/basic_child_option_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/basic_child_view.dart';

class CoachConfirmationView extends StatefulWidget {
  const CoachConfirmationView(
      {Key key,
      @required this.viewModel,
      @required this.confirmationFormType,
      this.onFinished})
      : super(key: key);
  final CoachRegistrationVM viewModel;
  final ConfirmationFormType confirmationFormType;
  final Function(List<ConfirmationFormData>) onFinished;
  @override
  _CoachConfirmationViewState createState() => _CoachConfirmationViewState();
}

class _CoachConfirmationViewState extends State<CoachConfirmationView>
    with TickerProviderStateMixin {
  List<ConfirmationFormData> dataList = <ConfirmationFormData>[
    ConfirmationFormData()
  ];

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  bool showFirstForm = true;

  @override
  void dispose() {
    for (final ConfirmationFormData element in dataList) {
      element.titleTC.dispose();
      element.urlTC.dispose();
      element.descriptionTC.dispose();
      element.categoryTC.dispose();
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
      title: _title,
      child: _contentView,
      onSubmit: _ctaSubmit,
      onCancel: _ctaCancel,
      scrollable: !showFirstForm,
    );
  }

  String get _title {
    if (showFirstForm) {
      return _unconfirmedTitle;
    } else {
      return _confirmedTitle;
    }
  }

  Widget get _contentView {
    return Column(
      children: <Widget>[_firstContentView, _secondContentView],
    );
  }

  Widget get _firstContentView {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
      child: Container(
        height: showFirstForm ? null : 0,
        child: BasicChildOptionView(
          submitText: 'Yes',
          onSubmit: () => setState(() => showFirstForm = false),
          cancelText: 'No',
          onCancel: () => widget.viewModel.ctaNext(),
        ),
      ),
    );
  }

  Widget get _secondContentView {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
      child: Container(
        height: showFirstForm ? 0 : null,
        child: Column(
          children: <Widget>[
            _bookListView,
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
      ),
    );
  }

  Widget get _bookListView {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        padding: _appSpacer.edgeInsets.all.none,
        itemBuilder: (_, int index) => bindBook(index));
  }

  Widget bindBook(int index) {
    final ConfirmationFormData item = dataList[index];

    if (item.editData) {
      return bindEducationForm(index);
    } else if (item.isPopulated) {
      return bindEducationCard(index);
    } else {
      return bindEducationForm(index);
    }
  }

  Widget bindEducationForm(int index) {
    final ConfirmationFormData item = dataList[index];
    return Column(
      children: <Widget>[
        CoachConfirmationFormView(
          formKey: item.formKey,
          descriptionTC: item.descriptionTC,
          titleTC: item.titleTC,
          urlTC: item.urlTC,
          categoryTC: item.categoryTC,
          showCategory:
              widget.confirmationFormType == ConfirmationFormType.books,
        ),
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
    final ConfirmationFormData item = dataList[index];
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
                'Book ${index + 1}',
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
          _bindTitleSubtitle('Title', item.title),
          _bindTitleSubtitle('URL', item.url),
          if (widget.confirmationFormType == ConfirmationFormType.books)
            _bindTitleSubtitle('Category', item.category),
          _bindTitleSubtitle('Description', item.description),
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
    if (dataList.length > 1) {
      setState(() {
        dataList.removeAt(index);
      });
    }
  }

  void _ctaEditEducation(int index) {
    final ConfirmationFormData item = dataList[index];
    setState(() {
      item.editData = true;
    });
  }

  void _ctaSetEducation(int index) {
    final ConfirmationFormData item = dataList[index];
    final bool isFormValid = item.formKey.currentState.validate();
    if (isFormValid) {
      setState(() {
        item.setDataFromTC();
      });
    }
  }

  void _ctaAddNewEducationForm() {
    dataList ??= <ConfirmationFormData>[];

    if (dataList.isNotEmpty) {
      final ConfirmationFormData lastBasicFormData = dataList.last;
      if (lastBasicFormData.isPopulated) {
        setState(() {
          dataList.add(ConfirmationFormData());
        });
      }
    } else {
      setState(() {
        dataList.add(ConfirmationFormData());
      });
    }
  }

  void _ctaSubmit() {
    if (_isValid) {
      widget.viewModel.ctaNext();
    }
  }

  void _ctaCancel() {
    if (showFirstForm) {
      widget.viewModel.ctaBack();
    } else {
      setState(() {
        showFirstForm = true;
      });
    }
  }

  bool get _isValid {
    bool valid = true;

    for (final ConfirmationFormData item in dataList) {
      if (!item.isPopulated) {
        valid = false;
      }
    }

    if (!valid) {
      /// Show snackbar / toas
    }

    return valid;
  }

  String get _unconfirmedTitle {
    switch (widget.confirmationFormType) {
      case ConfirmationFormType.books:
        return 'Have you written any books?';
      case ConfirmationFormType.courses:
        return 'Have you created any courses?';
      case ConfirmationFormType.videos:
        return 'Have you created any videos?';
      default:
        return '';
    }
  }

  String get _confirmedTitle {
    switch (widget.confirmationFormType) {
      case ConfirmationFormType.books:
        return 'Books';
      case ConfirmationFormType.courses:
        return 'Courses';
      case ConfirmationFormType.videos:
        return 'Videos';
      default:
        return '';
    }
  }
}

enum ConfirmationFormType { books, courses, videos }
