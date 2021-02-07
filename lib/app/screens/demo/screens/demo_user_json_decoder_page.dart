import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/small_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/app/screens/demo/decoder/demo_json_decoder.dart';
import 'package:fullstackdiv_material/app/screens/demo/model/demo_user_model.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this class is [StatefulWidget] because we change the state inside here

class DemoUserJsonDecoder extends StatefulWidget {
  @override
  _DemoUserJsonDecoderState createState() => _DemoUserJsonDecoderState();
}

class _DemoUserJsonDecoderState extends State<DemoUserJsonDecoder> {
  /// this is the page where we generate a json object
  /// then revert it back to the json to be shown to the user

  String _result;
  String _message = '';
  List<User> _data;

  @override
  Widget build(BuildContext context) {
    final ColorScheme _colorScheme = Theme.of(context).colorScheme;
    final TextStyle _textStyle = AppTextStyle(color: kAppBlack).primaryH4;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              BasicHeader(
                title: 'User JSON Parser',
                onBackButtonTapped: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Padding(
                  padding: kSpacer.edgeInsets.x.xs,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SmallButton(
                              title: 'Generate User\nJSON to Object',
                              onPressed: jsonToObject,
                              widgetTheme: WidgetTheme.blackWhite,
                            ),
                          ),
                          SizedBox(
                            width: kSpacer.xs,
                          ),
                          Expanded(
                            child: SmallButton(
                              title: 'Generate User\nObject to JSON',
                              backgroundColor: (_result != null)
                                  ? _colorScheme.primary
                                  : kAppGreyB,
                              textColor: kAppWhite,
                              onPressed: objectToJson,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kSpacer.sm,
                      ),
                      Expanded(
                        child: SingleChildScroll(
                          padding: kSpacer.edgeInsets.bottom.lg,
                          scrollDirection: Axis.vertical,
                          child: Text(
                            _result ?? _message,
                            style: _textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// this is the method to generate User JSON to User Object
  Future<void> jsonToObject() async {
    String generatedString = 'The User Object Data :';

    try {
      _data = await convertUserJson();
      // if the data return is empty then show 'Error Generate JSON'
      if (_data.isEmpty) {
        return setState(() {
          _message = 'Error Generate JSON';
          _result = null;
        });
      }

      // if the data return is not empty then convert the data to json
      // to be shown above the button
      for (final User user in _data) {
        generatedString =
            generatedString + '\nName : ${user.name} & Email : ${user.email}';
        print(user.name);
      }
      setState(() {
        _result = generatedString;
      });
    } catch (e) {
      print(e);
      setState(() {
        _message = 'Error Generate JSON';
        _result = null;
      });
    }
  }

  /// this is the method to revert back User Object to User JSON
  Future<void> objectToJson() async {
    String generatedString = 'The User JSON Data :';

    // if the data return is empty then show 'Error Generate JSON'
    if (_data == null) {
      return setState(() {
        _message =
            'Error Generate Object\nYou have to Generate User JSON to Object first';
        _result = null;
      });
    }

    // if the data return is not empty then convert the data to json
    // to be shown above the button
    try {
      for (final User user in _data) {
        final String jsonUser = jsonEncode(user);
        generatedString = generatedString + '\n$jsonUser';
      }
    } catch (e) {
      print(e);
      setState(() {
        _message = 'Error Generate Object';
        _result = null;
      });
    }
    setState(() {
      _result = generatedString;
    });
  }
}
