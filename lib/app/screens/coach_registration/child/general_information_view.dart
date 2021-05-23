import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_vm.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/utils/data_validation.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/basic_child_view.dart';
import 'package:fullstackdiv_material/system/styles/colors.dart';

class CoachGeneralInformationView extends StatefulWidget {
  const CoachGeneralInformationView({Key key, this.viewModel})
      : super(key: key);
  final CoachRegistrationVM viewModel;
  @override
  _CoachGeneralInformationViewState createState() =>
      _CoachGeneralInformationViewState();
}

class _CoachGeneralInformationViewState
    extends State<CoachGeneralInformationView> with TickerProviderStateMixin {
  final GlobalKey<FormState> _firstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameTC = TextEditingController();
  final TextEditingController lastNameTC = TextEditingController();
  final TextEditingController emailTC = TextEditingController();
  final TextEditingController dobTC = TextEditingController();
  final TextEditingController phoneNumberTC = TextEditingController();
  final TextEditingController genderTC = TextEditingController();

  final TextEditingController addressTC = TextEditingController();
  final TextEditingController cityTC = TextEditingController();
  final TextEditingController postalCodeTC = TextEditingController();
  final TextEditingController countryTC = TextEditingController();

  final FocusNode firstNameFN = FocusNode();
  final FocusNode lastNameFN = FocusNode();
  final FocusNode emailFN = FocusNode();
  final FocusNode dobFN = FocusNode();
  final FocusNode phoneNumberFN = FocusNode();
  final FocusNode genderFN = FocusNode();

  final FocusNode addressFN = FocusNode();
  final FocusNode cityFN = FocusNode();
  final FocusNode postalCodeFN = FocusNode();
  final FocusNode countryFN = FocusNode();

  final List<String> genderOptList = <String>['Male', 'Female'];

  final DateTime dateTimeNow = DateTime.now();

  List<int> yearOptList;
  List<int> monthOptList;
  List<String> monthNameList = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<int> dayOptList;

  int selectedYear = 1;
  int selectedMonth = 1;
  int selectedDay = 1;
  String selectedGender = 'Male';

  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  bool showFirstForm = true;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    firstNameTC.dispose();
    lastNameTC.dispose();
    emailTC.dispose();
    dobTC.dispose();
    phoneNumberTC.dispose();
    genderTC.dispose();

    addressTC.dispose();
    cityTC.dispose();
    postalCodeTC.dispose();
    countryTC.dispose();

    firstNameFN.dispose();
    lastNameFN.dispose();
    emailFN.dispose();
    dobFN.dispose();
    phoneNumberFN.dispose();
    genderFN.dispose();

    addressFN.dispose();
    cityFN.dispose();
    postalCodeFN.dispose();
    countryFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context);

    return CoachBasicChildView(
      parentBuildContext: widget.viewModel.widgetScaffoldContext,
      title: 'General Information',
      child: _contentView,
      onSubmit: _ctaSubmit,
      onCancel: showFirstForm ? null : _ctaCancel,
    );
  }

  Widget get _contentView {
    return Padding(
      padding: _appSpacer.edgeInsets.x.sm,
      child: Column(
        children: <Widget>[_firstFormView, _secondFormView],
      ),
    );
  }

  Widget get _firstFormView => AnimatedSize(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: showFirstForm ? null : 0,
          child: Form(
            key: _firstFormKey,
            child: Column(
              children: <Widget>[
                bindFormField(firstNameTC, firstNameFN,
                    labelText: 'First Name',
                    maxLength: 15,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (String s) => _validator(
                        controller: firstNameTC, text: firstNameTC.text),
                    onFieldSubmitted: (_) => _requestFocus(lastNameFN)),
                bindFormField(lastNameTC, lastNameFN,
                    labelText: 'Last Name',
                    maxLength: 15,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (String s) => _validator(
                        controller: lastNameTC, text: lastNameTC.text),
                    onFieldSubmitted: (_) => _requestFocus(emailFN)),
                bindFormField(emailTC, emailFN,
                    labelText: 'Email',
                    maxLength: 45,
                    textInputType: TextInputType.emailAddress,
                    validator: (String s) =>
                        _validator(controller: emailTC, text: emailTC.text),
                    onFieldSubmitted: (_) => _resetFocus()),
                _appSpacer.vHsm,
                _dobView,
                bindFormField(phoneNumberTC, phoneNumberFN,
                    labelText: 'Phone Number',
                    maxLength: 10,
                    textInputType: TextInputType.phone,
                    validator: (String s) => _validator(
                        controller: phoneNumberTC, text: phoneNumberTC.text),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _resetFocus()),
                _appSpacer.vHsm,
                _genderView
              ],
            ),
          ),
        ),
      );

  Widget get _secondFormView => AnimatedSize(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: showFirstForm ? 0 : null,
          child: Form(
            key: _secondFormKey,
            child: Column(
              children: <Widget>[
                bindFormField(addressTC, addressFN,
                    labelText: 'Address',
                    maxLength: 15,
                    textInputType: TextInputType.streetAddress,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (String s) =>
                        _validator(controller: addressTC, text: addressTC.text),
                    onFieldSubmitted: (_) => _requestFocus(cityFN)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: bindFormField(cityTC, cityFN,
                            labelText: 'City',
                            maxLength: 15,
                            textCapitalization: TextCapitalization.words,
                            textInputType: TextInputType.streetAddress,
                            validator: (String s) => _validator(
                                controller: cityTC, text: cityTC.text),
                            onFieldSubmitted: (_) =>
                                _requestFocus(postalCodeFN))),
                    _appSpacer.vWsm,
                    Expanded(
                        child: bindFormField(postalCodeTC, postalCodeFN,
                            labelText: 'Postal Code',
                            maxLength: 5,
                            textInputType: TextInputType.number,
                            validator: (String s) => _validator(
                                controller: postalCodeTC,
                                text: postalCodeTC.text),
                            onFieldSubmitted: (_) => _requestFocus(countryFN))),
                  ],
                ),
                bindFormField(countryTC, countryFN,
                    labelText: 'Country',
                    maxLength: 15,
                    textInputType: TextInputType.streetAddress,
                    textCapitalization: TextCapitalization.words,
                    validator: (String s) =>
                        _validator(controller: countryTC, text: countryTC.text),
                    onFieldSubmitted: (_) => _resetFocus()),
              ],
            ),
          ),
        ),
      );

  Widget get _dobView {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _titleView('Birthday'),
        Row(
          children: <Widget>[
            Expanded(
              child: DropdownButton<int>(
                value: selectedMonth,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                // style: _appTextStyle.primaryLabel1,
                underline: Container(
                  height: 2,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: kAppPrimaryColor),
                ),
                onChanged: (int i) {
                  setState(() => selectedMonth = i);
                  _getDaysFromDateTime();
                },
                items: monthOptList
                    .map((int item) => DropdownMenuItem<int>(
                          value: item,
                          child: Padding(
                            padding: _appSpacer.edgeInsets
                                .only(left: 'xxs', right: 'xs'),
                            child: Text(monthNameList[item - 1].toString()),
                          ),
                        ))
                    .toList(),
              ),
            ),
            _appSpacer.vWxs,
            bindDropdownView(
                selectedValue: selectedDay,
                itemList: dayOptList,
                onChanged: (int i) {
                  setState(() => selectedDay = i);
                },
                isExpanded: false),
            _appSpacer.vWxs,
            bindDropdownView(
                selectedValue: selectedYear,
                itemList: yearOptList,
                onChanged: (int i) {
                  setState(() => selectedYear = i);
                  _getDaysFromDateTime();
                },
                isExpanded: false)
          ],
        ),
      ],
    );
  }

  Widget get _genderView {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _titleView('Gender'),
        DropdownButton<String>(
          value: selectedGender,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          // style: _appTextStyle.primaryLabel1,
          underline: Container(
            height: 2,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: kAppPrimaryColor),
          ),
          onChanged: (String s) => setState(() => selectedGender = s),
          items: genderOptList
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: _appSpacer.edgeInsets.y.xs,
                      child: Text(item.toString()),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _titleView(String text) => Text(
        text,
        style: _appTextStyle.primaryLabel1.copyWith(color: kAppPrimaryColor),
      );

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

  Widget bindDropdownView(
      {int selectedValue,
      List<int> itemList,
      Function(int) onChanged,
      bool isExpanded = true}) {
    return DropdownButton<int>(
      value: selectedValue,
      isExpanded: isExpanded,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      // style: _appTextStyle.primaryLabel1,
      underline: Container(
        height: 2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: kAppPrimaryColor),
      ),
      onChanged: (int i) => onChanged(i),
      items: itemList
          .map((int item) => DropdownMenuItem<int>(
                value: item,
                child: Padding(
                  padding: _appSpacer.edgeInsets.only(left: 'xxs', right: 'xs'),
                  child: Text(item.toString()),
                ),
              ))
          .toList(),
    );
  }

  void _initPlatformState() {
    yearOptList =
        List<int>.generate(100, (int index) => dateTimeNow.year - 13 - index)
            .toList();
    monthOptList = List<int>.generate(12, (int index) => index + 1).toList();

    _setInitialData();
  }

  void _setInitialData() {
    setState(() {
      firstNameTC.text = widget.viewModel.selectedFirstName;
      lastNameTC.text = widget.viewModel.selectedLastName;
      emailTC.text = widget.viewModel.selectedEmail;

      selectedDay = widget.viewModel?.selectedDobDay ?? dateTimeNow.day;
      selectedMonth = widget.viewModel?.selectedDobMonth ?? dateTimeNow.month;
      selectedYear = widget.viewModel?.selectedDobYear ?? dateTimeNow.year - 13;

      phoneNumberTC.text = widget.viewModel.selectedPhoneNumber;
      selectedGender = widget.viewModel?.selectedGender ?? genderOptList[0];

      addressTC.text = widget.viewModel.selectedAddress;
      cityTC.text = widget.viewModel.selectedCity;
      postalCodeTC.text = widget.viewModel.selectedPostalCode;
      countryTC.text = widget.viewModel.selectedCountry;
    });

    _getDaysFromDateTime();
  }

  void _getDaysFromDateTime() {
    final DateTime lastDayOfMonth =
        DateTime(selectedYear, selectedMonth + 1, 0);
    dayOptList =
        List<int>.generate(lastDayOfMonth.day, (int index) => index + 1)
            .toList();
    if (!dayOptList.contains(selectedDay)) {
      selectedDay = lastDayOfMonth.day;
    }
    setState(() {});
  }

  void _ctaSubmit() {
    if (showFirstForm) {
      /// Validate first form
      /// if valid, show second form
      final bool isValid = _firstFormKey.currentState.validate();
      if (isValid) {
        _setFirstFormData();
        setState(() {
          showFirstForm = false;
        });
      }
    } else {
      /// Validate second form
      /// if valid proceed to second page
      final bool isValid = _secondFormKey.currentState.validate();
      if (isValid) {
        _setSecondFormData();
        widget.viewModel.ctaNext();
      }
    }
  }

  void _ctaCancel() {
    if (!showFirstForm) {
      setState(() {
        showFirstForm = true;
      });
    } else {
      widget.viewModel.ctaBack();
    }
  }

  void _requestFocus(FocusNode fn) => FocusScope.of(context).requestFocus(fn);

  void _resetFocus() => FocusScope.of(context).requestFocus(FocusNode());

  String _validator({TextEditingController controller, String text}) {
    if (controller == firstNameTC) {
      return DataValidation.nameIsValid(text, tag: 'First Name');
    } else if (controller == lastNameTC) {
      return DataValidation.nameIsValid(text, tag: 'Last Name', minLength: 2);
    } else if (controller == emailTC) {
      return DataValidation.emailIsValid(text);
    } else if (controller == phoneNumberTC) {
      return DataValidation.phoneIsValid(text);
    } else if (controller == addressTC) {
      return DataValidation.basicLengthIsValid(text,
          tag: 'Address', minLength: 5);
    } else if (controller == cityTC) {
      return DataValidation.basicLengthIsValid(text, tag: 'City', minLength: 3);
    } else if (controller == postalCodeTC) {
      return DataValidation.basicLengthIsValid(text,
          tag: 'Postal Code', minLength: 5);
    } else if (controller == countryTC) {
      return DataValidation.basicLengthIsValid(text,
          tag: 'Country', minLength: 3);
    }

    return null;
  }

  void _setFirstFormData() {
    widget.viewModel.selectedFirstName = firstNameTC.text;
    widget.viewModel.selectedLastName = lastNameTC.text;
    widget.viewModel.selectedEmail = emailTC.text;

    widget.viewModel.selectedDobDay = selectedDay;
    widget.viewModel.selectedDobMonth = selectedMonth;
    widget.viewModel.selectedDobYear = selectedYear;

    widget.viewModel.selectedPhoneNumber = phoneNumberTC.text;
    widget.viewModel.selectedGender = selectedGender;
  }

  void _setSecondFormData() {
    widget.viewModel.selectedAddress = addressTC.text;
    widget.viewModel.selectedCity = cityTC.text;
    widget.viewModel.selectedPostalCode = postalCodeTC.text;
    widget.viewModel.selectedCountry = countryTC.text;
  }
}
