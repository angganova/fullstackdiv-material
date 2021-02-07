import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/bottom_sheet/bottom_sheet_dynamic.dart';
import 'package:fullstackdiv_material/app/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:fullstackdiv_material/app/components/button/large_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoBottomSheetPage extends StatelessWidget {
  /// this is the page where we show the example of [BottomSheet]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Bottom Sheet',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LargeButton(
                    title: 'Informational',
                    widgetTheme: WidgetTheme.blackWhite,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: BottomSheetInformational(
                          title: placeholderString,
                          description: placeholderString,
                          confirmButtonTitle: 'Yes, delete it',
                          cancelButtonTitle: 'No, cancel',
                          confirmCallback: () {},
                          cancelCallback: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kSpacer.xxs,
                  ),
                  LargeButton(
                    title: 'Text&Button',
                    widgetTheme: WidgetTheme.redWhite,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: BottomSheetDynamic(
                          title: placeholderString,
                          confirmButtonTitle: 'Yes, delete it',
                          cancelButtonTitle: 'No, cancel',
                          confirmCallback: () {},
                          cancelCallback: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kSpacer.xxs,
                  ),
                  LargeButton(
                    title: 'Text&Button+Image',
                    widgetTheme: WidgetTheme.blueWhite,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: BottomSheetDynamic(
                          title: placeholderString,
                          child: Image.asset(placeholderAssetImage),
                          confirmButtonTitle: 'Yes, delete it',
                          cancelButtonTitle: 'No, cancel',
                          confirmCallback: () {},
                          cancelCallback: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kSpacer.xxs,
                  ),
                  LargeButton(
                    title: 'Text&Button+Image&Text',
                    widgetTheme: WidgetTheme.yellowBlack,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: BottomSheetDynamic(
                          title: placeholderString,
                          child: Column(
                            children: <Widget>[
                              Image.asset(placeholderAssetImage),
                              SizedBox(height: kSpacer.xs),
                              Text(
                                placeholderString,
                                style:
                                    AppTextStyle(color: kAppPrimaryBrightBlue)
                                        .primaryH4,
                              )
                            ],
                          ),
                          confirmButtonTitle: 'Yes, delete it',
                          cancelButtonTitle: 'No, cancel',
                          confirmCallback: () {},
                          cancelCallback: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kSpacer.xxs,
                  ),
                  LargeButton(
                    title: 'Informational Sheet 1 Button',
                    widgetTheme: WidgetTheme.blackWhite,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: BottomSheetInformational(
                          title: placeholderString,
                          description: placeholderString,
                          cancelButtonTitle: 'Done',
                          cancelCallback: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: kSpacer.xxs,
                  ),
                  LargeButton(
                    title: 'Dynamic Sheet 1 Button',
                    widgetTheme: WidgetTheme.yellowBlack,
                    onPressed: () {
                      showCustomBottomSheet(
                        context: context,
                        child: BottomSheetDynamic(
                          title: placeholderString,
                          child: Column(
                            children: <Widget>[
                              Image.asset(placeholderAssetImage),
                              SizedBox(height: kSpacer.xs),
                              Text(
                                placeholderString,
                                style:
                                    AppTextStyle(color: kAppPrimaryBrightBlue)
                                        .primaryH4,
                              )
                            ],
                          ),
                          confirmButtonTitle: 'Okay',
                          confirmCallback: () {
                            Navigator.pop(context);
                          },
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
