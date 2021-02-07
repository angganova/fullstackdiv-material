import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/text_field/general_search_field.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoGeneralSearchField extends StatefulWidget {
  @override
  _DemoGeneralSearchFieldState createState() => _DemoGeneralSearchFieldState();
}

class _DemoGeneralSearchFieldState extends State<DemoGeneralSearchField> {
  /// Text editing controller for each fields
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    /// make sure to dispose all disposable stuff
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppWhite,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              BasicHeader(
                title: 'General Search Field Example',
                onBackButtonTapped: () {
                  Navigator.pop(context);
                },
              ),
              GeneralSearchField(
                textFieldController: _textController,
                textFieldFocusNode: _textFocusNode,
                hint: 'Search',
              )
            ],
          ),
        ));
  }
}
