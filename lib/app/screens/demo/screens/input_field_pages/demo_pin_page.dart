import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/pin/pin.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoPinPage extends StatefulWidget {
  @override
  _DemoPinPageState createState() => _DemoPinPageState();
}

class _DemoPinPageState extends State<DemoPinPage> {
  /// This correct pin value is optional
  /// If there's no security concern to check it on the fly
  /// we can just put the correct pin into ZPin constructor
  static const String _correctPin = '1234';

  /// PinInputTextFormField form-key
  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formKey');

  /// Control the input text field.
  final TextEditingController _pinController = TextEditingController(text: '');

  /// Indicate whether the pin field has error or not
  /// after being validated.
  bool _hasError = false;

  bool _pinFilled = false;

  /// Indicate that pin field on focused state (Keyboard shown)
  /// Will affect style of [AppPin] decoration
  final bool _focused = false;

  @override
  void initState() {
    _pinController.addListener(() {
      debugPrint('controller execute. pin:${_pinController.text}');
    });

    super.initState();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Pin Example',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: kSpacer.edgeInsets.all.md,
                child: Column(
                  children: <Widget>[
                    AppPin(
                      formKey: _formKey,
                      controller: _pinController,
                      error: _hasError,
                      correctPin: _correctPin,
                      focused: _focused,
                      enable: true,
                      inputType: TextInputType.text,
                      onSubmit: (String pin) {
                        _onSubmitPin();
                      },
                      onChanged: (String pin) {
                        if (pin.length < AppPin.pinLength) {
                          setState(() {
                            _pinFilled = false;
                            _hasError = false;
                          });
                        } else {
                          setState(() {
                            _pinFilled = true;
                          });
                        }
                      },
                      onSaved: (String pin) {
                        ///debugPrint('onSaved pin:$pin');
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'PIN cannot be empty';
                        }
                        if (value != _correctPin) {
                          return 'Invalid Code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: kDefaultMargin,
                    ),
                    Text(
                      'Correct PIN: $_correctPin',
                      style: AppTextStyle(color: kAppBlack).primaryLabel1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.forward),
        backgroundColor: _pinFilled ? kAppPrimaryElectricBlue : kAppGreyC,
        onPressed: _pinFilled
            ? () {
                _onSubmitPin();
              }
            : null,
      ),
    );
  }

  void _onSubmitPin() {
    // Remove focus / hide keyboard
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      showPublicToast(msg: 'Pin valid');
      _formKey.currentState.save();
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }
}
