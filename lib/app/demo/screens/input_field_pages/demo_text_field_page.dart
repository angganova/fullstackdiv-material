import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view.dart';
import 'package:fullstackdiv_material/app/components/text_field/text_field.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoTextFieldPage extends StatefulWidget {
  @override
  _DemoTextFieldPageState createState() => _DemoTextFieldPageState();
}

class _DemoTextFieldPageState extends State<DemoTextFieldPage> {
  /// Key for form builder to perform form validation
  final GlobalKey<FormState> _fbKey = GlobalKey<FormState>();

  /// Text editing controller for each fields
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _nameValue;
  String _phoneValue;
  String _emailValue;

  @override
  void dispose() {
    /// make sure to dispose all disposable stuff
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppWhite,
        body: SafeArea(
          child: Form(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                BasicHeader(
                  title: 'Text Field Example',
                  onBackButtonTapped: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: kSpacer.edgeInsets.all.md,
                    child: BasicListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /// Standard Text Field
                            Text(
                              'Standard Text Field Example',
                              style: AppTextStyle(color: kAppBlack).primaryP,
                            ),
                            AppTextField(
                              hint: 'Enter your name',
                              controller: _nameController,
                              error: nameFieldError != null,
                              onChanged: (String value) {
                                setState(() {
                                  _nameValue = value;
                                });
                              },
                              validator: (String value) {
                                return nameFieldError;
                              },
                              inputType: TextInputType.name,
                            ),
                            const SizedBox(height: kDefaultMargin),

                            /// Phone Text Field
                            Text(
                              'Phone Field Example',
                              style: AppTextStyle(color: kAppBlack).primaryP,
                            ),
                            AppTextField(
                              controller: _phoneController,
                              error: phoneFieldError != null,
                              onChanged: (String value) {
                                setState(() {
                                  _phoneValue = value;
                                });
                              },
                              validator: (String value) {
                                return phoneFieldError;
                              },
                              inputType: TextInputType.number,
                            ),
                            const SizedBox(height: kDefaultMargin),

                            /// Email Text Field
                            Text(
                              'Email Field Example',
                              style: AppTextStyle(color: kAppBlack).primaryP,
                            ),
                            AppTextField(
                              hint: 'Enter your email',
                              controller: _emailController,
                              error: emailFieldError != null,
                              onChanged: (String value) {
                                setState(() {
                                  _emailValue = value;
                                });
                              },
                              validator: (String value) {
                                return emailFieldError;
                              },
                              inputType: TextInputType.emailAddress,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String get nameFieldError {
    if (_nameValue == null) {
      return null;
    }

    final bool minLengthValid = _nameValue.length > 3;
    if (!minLengthValid) {
      return 'Name should be greater than 3 characters';
    }

    return null;
  }

  String get phoneFieldError {
    if (_phoneValue == null) {
      return null;
    }

    if (_phoneValue.isEmpty) {
      return 'Phone cannot be empty';
    }

    if (_phoneValue.length < 8) {
      return 'Number seems too short';
    }

    return null;
  }

  String get emailFieldError {
    if (_emailValue == null) {
      return null;
    }

    if (_emailValue.isEmpty) {
      return 'Email address is required';
    }

    return null;
  }
}
