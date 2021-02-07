import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/action_sheet/action_sheet.dart';
import 'package:fullstackdiv_material/app/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoActionSheetPage extends StatelessWidget {
  /// this is the page where we show the example of [ActionSheet]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Action Sheet',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  WideButton(
                    title: 'Action Sheet [Icon]',
                    widgetTheme: WidgetTheme.blackWhite,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: ActionSheet(
                          title: placeholderString,
                          children: <ActionChild>[
                            ActionChild(
                                title: placeholderString,
                                icon: Icons.location_on),
                            ActionChild(
                              title: placeholderString,
                              icon: Icons.sort_by_alpha,
                              onChildTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kSpacer.xs,
                  ),
                  WideButton(
                    title: 'Action Sheet [No Icon]',
                    widgetTheme: WidgetTheme.redWhite,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: ActionSheet(
                          title: placeholderString,
                          children: <ActionChild>[
                            ActionChild(title: placeholderString),
                            ActionChild(
                              title: placeholderString,
                              onChildTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
