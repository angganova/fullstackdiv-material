import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/app/components/snackbar/basic_snack_bar.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoSnackbarPage extends StatelessWidget {
  /// this is the page where we show the example of [SnackBar]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Snack Bar',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScroll(
                /// IMPORTANT NOTE :
                /// if we want to show the [SnackBar],
                /// the context should come from this [Builder]
                /// like the example below
                child: Builder(
                  builder: (BuildContext context) => Padding(
                    padding: kSpacer.edgeInsets.all.xs,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        WideButton(
                          title: 'White Snack Bar',
                          widgetTheme: WidgetTheme.whiteBlack,
                          onPressed: () => showBasicSnackBar(
                              context: context,
                              widgetTheme: WidgetTheme.whiteBlack,
                              text: placeholderString,
                              assetImageName: 'assets/demo/bell.png',
                              action: () => showPublicToast(
                                    msg: 'Snackbar tapped!',
                                  ),
                              trailingActionName: 'Undo',
                              trailingAction: () {}),
                        ),
                        SizedBox(
                          height: kSpacer.xs,
                        ),
                        WideButton(
                          title: 'Yellow Snack Bar',
                          widgetTheme: WidgetTheme.yellowBlack,
                          onPressed: () => showBasicSnackBar(
                            context: context,
                            text: placeholderString,
                            assetImageName: 'assets/demo/bell.png',
                            action: () => showPublicToast(
                              msg: 'Snackbar tapped!',
                            ),
                            // trailingSubtitle: 'Arrives by',
                            trailingText: '13.25',
                          ),
                        ),
                        SizedBox(
                          height: kSpacer.xs,
                        ),
                        WideButton(
                          title: 'Subtitle Snack Bar',
                          widgetTheme: WidgetTheme.blackYellow,
                          onPressed: () => showBasicSnackBar(
                            context: context,
                            widgetTheme: WidgetTheme.blackYellow,
                            text: placeholderString,
                            assetImageName: 'assets/demo/bell.png',
                            action: () => showPublicToast(
                              msg: 'Snackbar tapped!',
                            ),
                            trailingSubtitle: 'Arrives by',
                            trailingText: '13.25',
                          ),
                        ),
                        SizedBox(
                          height: kSpacer.xs,
                        ),
                        WideButton(
                          title: 'Red Snack Bar',
                          widgetTheme: WidgetTheme.redWhite,
                          onPressed: () => showBasicSnackBar(
                            context: context,
                            text: placeholderString,
                            assetImageName: 'assets/demo/bell.png',
                            widgetTheme: WidgetTheme.redWhite,
                            action: () => showPublicToast(
                              msg: 'Snackbar tapped!',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: kSpacer.xs,
                        ),
                        WideButton(
                          title: 'No Icon/Image',
                          widgetTheme: WidgetTheme.blueWhite,
                          onPressed: () => showBasicSnackBar(
                            context: context,
                            text: placeholderString,
                            widgetTheme: WidgetTheme.blueWhite,
                            action: () => showPublicToast(
                              msg: 'Snackbar tapped!',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: kSpacer.xs,
                        ),
                        WideButton(
                          title: 'No Icon/Image 2nd Ver',
                          widgetTheme: WidgetTheme.whiteBlue,
                          onPressed: () => showBasicSnackBar(
                            context: context,
                            text: placeholderString,
                            widgetTheme: WidgetTheme.whiteBlue,
                            action: () => showPublicToast(
                              msg: 'Snackbar tapped!',
                            ),
                            trailingText: '13.25',
                          ),
                        ),
                        SizedBox(
                          height: kSpacer.xs,
                        ),
                        WideButton(
                          title: 'With Icon',
                          widgetTheme: WidgetTheme.blackWhite,
                          onPressed: () => showBasicSnackBar(
                            context: context,
                            text: placeholderString,
                            widgetTheme: WidgetTheme.blackWhite,
                            icon: Icons.train,
                            action: () => showPublicToast(
                              msg: 'Snackbar tapped!',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
