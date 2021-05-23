import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/form/single_form.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/model/single_form_data.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/utils/file_utils.dart';

import 'model/confirmation_form_data.dart';

class CoachRegistrationVM {
  CoachRegistrationVM();
  CoachRegistrationVM._();

  static final CoachRegistrationVM instance = CoachRegistrationVM._();
  final FileUtils _fileUtils = FileUtils();

  /// 1st Page - Section A - General Information
  String selectedFirstName;
  String selectedLastName;
  String selectedEmail;
  int selectedDobDay;
  int selectedDobMonth;
  int selectedDobYear;
  String selectedPhoneNumber;
  String selectedGender;

  /// 1st Page - Section B - General Information
  String selectedAddress;
  String selectedCity;
  String selectedPostalCode;
  String selectedCountry;

  /// 2nd Page - Profile Picture
  File selectedProfilePicture;
  String selectedProfilePicturePath;

  /// 3rd Page - Education
  String selectedUniversity;
  String selectedDegrees;
  String selectedTitle;

  /// 4th Page - Professions
  List<SingleFormDataModel> selectedProfessions;

  /// 5th Page - Create any Books
  bool selectedCreateAnyBooks;
  List<ConfirmationFormData> selectedBooksCreated;

  /// 6th Page - Create any Course
  bool selectedCreateAnyCourse;
  List<ConfirmationFormData> selectedCourseCreated;

  /// 7th Page - Create any Videos
  bool selectedCreateAnyVideos;
  List<ConfirmationFormData> selectedVideosCreated;

  /// 8th Page - Influencer
  bool selectedIsInfluencer;
  List<SingleFormDataModel> selectedInfluencerPlatform;

  /// 9th Page - Languages
  List<SingleFormDataModel> selectedLanguages;

  /// 10th Page - Website and Social Media
  List<SingleFormDataModel> selectedWebsiteAndSocialMedia;

  /// 11th Page - Website and Social Media
  SingleFormDataModel selectedBiography;

  /// 12th Page - Website and Social Media
  SingleFormDataModel selectedAdditionalInformation;

  /// Widget specific variable
  BuildContext widgetScaffoldContext;
  BuildContext widgetBuildContext;

  PageController childPageController;
  List<Widget> childPages;

  int currentPage = 0;

  Future<bool> ctaOnBackPressed() {
    return Future<bool>.value(true);
  }

  void widgetInitState(PageController controller, List<Widget> pages) {
    childPageController = controller;
    childPages = pages;
  }

  void widgetPostFrame(
      BuildContext scaffoldContext, BuildContext buildContext) {
    widgetScaffoldContext = scaffoldContext;
    widgetBuildContext = buildContext;
  }

  void ctaNext() {
    if (currentPage < childPages.length - 1) {
      childPageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutSine);
    }
  }

  void ctaBack() {
    if (currentPage > 0) {
      childPageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutSine);
    }
  }

  void onPageChanged(int index) {
    currentPage = index;
  }

  Future<File> selectFile() async {
    //   final FilePickerResult result = await FilePicker.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: <String>['jpg', 'png'],
    //   );
    //
    //   if (result != null) {
    //     return File(result.files.single.path);
    //   } else {
    return null;
    // }
  }

  Future<String> _generateFileToSend(String path, File file) async {
    // final String _base64File = await _fileUtils.convertFileToBase64(path, file);
    // final String _fileStringToSend = 'data:image/png;base64,' + _base64File;
    // return _fileStringToSend;

    return null;
  }

  // String getFileNameAndExt(String path) => _fileUtils.getFileNameAndExt(path);

  // bool validateDocExt(String path) => _fileUtils.validateImage(path);

  void setSelectedProfession(List<SingleFormDataModel> dataList) {
    selectedProfessions = dataList;
  }

  void setSelectedBooks(List<ConfirmationFormData> dataList) {
    selectedBooksCreated = dataList;
  }

  void setSelectedCourses(List<ConfirmationFormData> dataList) {
    selectedCourseCreated = dataList;
  }

  void setSelectedVideos(List<ConfirmationFormData> dataList) {
    selectedVideosCreated = dataList;
  }

  void setSelectedLanguage(List<SingleFormDataModel> dataList) {
    selectedLanguages = dataList;
  }

  void setSelectedWebsiteAndSocialMedia(List<SingleFormDataModel> dataList) {
    selectedWebsiteAndSocialMedia = dataList;
  }

  void setSelectedInfluencerPlatform(List<SingleFormDataModel> dataList) {
    selectedInfluencerPlatform = dataList;
  }

  void setSelectedBiography(SingleFormDataModel data) {
    selectedBiography = data;
  }

  void setSelectedAdditionalInfo(SingleFormDataModel data) {
    selectedAdditionalInformation = data;
  }
}
