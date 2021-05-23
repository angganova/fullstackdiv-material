import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/child/confirmation_form_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/child/education_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/child/general_information_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/child/influencer_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/child/single_form_list_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/child/profile_picture_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/child/single_form_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_vm.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/model/confirmation_form_data.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/model/single_form_data.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/dots_indicator.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class CoachRegistrationView extends StatefulWidget {
  @override
  _CoachRegistrationViewState createState() => _CoachRegistrationViewState();
}

class _CoachRegistrationViewState extends State<CoachRegistrationView> {
  final CoachRegistrationVM _viewModel = CoachRegistrationVM();
  final PageController _childPageController = PageController(initialPage: 0);

  List<Widget> _childPages = <Widget>[];

  BuildContext _widgetScaffoldContext;
  BuildContext _widgetBuildContext;

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  bool readyToShow = false;
  bool isFinished = false;

  @override
  void dispose() {
    _childPageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context);

    _widgetScaffoldContext ??= context;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
            Colors.indigo.shade800,
            Colors.lightBlueAccent.shade100
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Coach Application'),
          leading: IconButton(
            icon: Icon(Platform.isAndroid
                ? Icons.arrow_back_rounded
                : Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Builder(
          builder: (BuildContext _context) {
            _widgetBuildContext ??= _context;
            return WillPopScope(
              onWillPop: () => _viewModel.ctaOnBackPressed(),
              child: SafeArea(child: _mainView),
            );
          },
        ),
      ),
    );
  }

  Widget get _mainView {
    return Stack(
      children: <Widget>[
        Container(width: _appQuery.width, height: _appQuery.height),
        _contentView,
        _finishView
      ],
    );
  }

  Widget get _contentView {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: readyToShow ? 1 : 0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[_dotsIndicatorView, Expanded(child: _pageView)],
      ),
    );
  }

  Widget get _finishView {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isFinished ? 1 : 0,
      child: IgnorePointer(
        ignoring: !isFinished,
        child: Container(
          alignment: Alignment.center,
          width: _appQuery.width,
          height: _appQuery.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  size: _appQuery.width / 2,
                ),
              ),
              _appSpacer.vHsm,
              Text(
                'Application Submitted!',
                style: _appTextStyle.primaryPL.copyWith(color: Colors.white),
              ),
              _appSpacer.vHsm,
              Text(
                'Your application will be reviewed and someone from our team will '
                'get back to you.',
                style:
                    _appTextStyle.primaryLabel1.copyWith(color: Colors.white),
              ),
              _appSpacer.vHsm,
              Container(
                width: _appQuery.width / 4,
                child: RaisedButton(
                  onPressed: () {},
                  padding: _appSpacer.edgeInsets.y.xs,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.white,
                  child: Text(
                    'OK',
                    style:
                        _appTextStyle.primaryB1.copyWith(color: Colors.indigo),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _pageView {
    return PageView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _childPageController,
        itemCount: _childPages.length,
        onPageChanged: (int index) {
          _viewModel.onPageChanged(index);
        },
        itemBuilder: (BuildContext context, int index) {
          return _bindPage(index);
        });
  }

  Widget _bindPage(int index) {
    final Widget child = _childPages[index % _childPages.length];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: const BoxDecoration(
          color: kAppWhite,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: child,
    );
  }

  Widget get _dotsIndicatorView {
    if (!readyToShow) {
      return Container();
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: DotsIndicator(
            controller: _childPageController,
            itemCount: _childPages.length,
            activeColor: Colors.yellow,
            inactiveColor: Colors.white,
            stepByStep: true,
          ));
    }
  }

  void _initPlatformState() {
    _childPages = <Widget>[
      CoachGeneralInformationView(
        viewModel: _viewModel,
      ),
      CoachProfilePictureView(
        viewModel: _viewModel,
      ),
      CoachEducationView(
        viewModel: _viewModel,
      ),
      CoachSingleFormListView(
        viewModel: _viewModel,
        singleFormListType: SingleFormListType.profession,
        onFinished: (List<SingleFormDataModel> dataList) =>
            _viewModel.setSelectedProfession(dataList),
      ),
      CoachConfirmationView(
        viewModel: _viewModel,
        confirmationFormType: ConfirmationFormType.books,
        onFinished: (List<ConfirmationFormData> dataList) =>
            _viewModel.setSelectedBooks(dataList),
      ),
      CoachConfirmationView(
        viewModel: _viewModel,
        confirmationFormType: ConfirmationFormType.courses,
        onFinished: (List<ConfirmationFormData> dataList) =>
            _viewModel.setSelectedCourses(dataList),
      ),
      CoachConfirmationView(
        viewModel: _viewModel,
        confirmationFormType: ConfirmationFormType.videos,
        onFinished: (List<ConfirmationFormData> dataList) =>
            _viewModel.setSelectedVideos(dataList),
      ),
      CoachInfluencerView(
        viewModel: _viewModel,
        onFinished: (List<SingleFormDataModel> dataList) =>
            _viewModel.setSelectedInfluencerPlatform(dataList),
      ),
      CoachSingleFormListView(
        viewModel: _viewModel,
        singleFormListType: SingleFormListType.language,
        onFinished: (List<SingleFormDataModel> dataList) =>
            _viewModel.setSelectedLanguage(dataList),
      ),
      CoachSingleFormListView(
        viewModel: _viewModel,
        singleFormListType: SingleFormListType.websiteAndSocialMedia,
        onFinished: (List<SingleFormDataModel> dataList) =>
            _viewModel.setSelectedWebsiteAndSocialMedia(dataList),
      ),
      CoachSingleFormView(
        viewModel: _viewModel,
        singleFormType: SingleFormType.biography,
        onFinished: (SingleFormDataModel data) =>
            _viewModel.setSelectedBiography(data),
      ),
      CoachSingleFormView(
        viewModel: _viewModel,
        singleFormType: SingleFormType.additionalInformation,
        onFinished: (SingleFormDataModel data) =>
            _viewModel.setSelectedAdditionalInfo(data),
      )
    ];

    _viewModel.widgetInitState(_childPageController, _childPages);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.widgetPostFrame(_widgetScaffoldContext, _widgetBuildContext);
      setState(() {
        readyToShow = true;
      });
    });
  }
}
