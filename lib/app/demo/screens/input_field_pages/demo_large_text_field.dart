import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view.dart';
import 'package:fullstackdiv_material/app/components/text_field/large_text_field.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoLargeTextFieldPage extends StatefulWidget {
  @override
  _DemoLargeTextFieldPageState createState() => _DemoLargeTextFieldPageState();
}

class _DemoLargeTextFieldPageState extends State<DemoLargeTextFieldPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    /// make sure to dispose all disposable stuff
    _noteController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppWhite,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                BasicHeader(
                  title: 'Large Text Field Example',
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
                            ZLargeTextField(
                              controller: _noteController,
                              hint: 'Others reason; please specify',
                              onChanged: (String value) {},
                            ),
                            const SizedBox(height: kDefaultMargin),
                            ZLargeTextField(
                              controller: _addressController,
                              hint: 'Please input your address',
                              maxLength: 10,
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
}
