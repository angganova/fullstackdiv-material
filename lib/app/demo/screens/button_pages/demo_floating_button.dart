import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/app/components/button/small_button.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoFloatingButtonPage extends StatelessWidget {
  /// this is the demo page of [FloatingButton]
  /// in this page, we show how to use the existing [Buttons]
  /// to be a Custom [FloatingActionButton]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppGreyD,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BasicHeader(
              title: 'Floating Buttons',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Container(
              padding: kSpacer.edgeInsets.only(left: 'sm'),
              color: kAppBlack,
              child: Text(
                'Basic buttons float too!',
                maxLines: 2,
                style: AppTextStyle(color: kAppWhite).primaryH3,
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    color: kAppGreyD,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding:
                          kSpacer.edgeInsets.only(right: 'sm', bottom: 'sm'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomIconButton(
                            shadowStrokeType: ShadowStrokeType.lowShadow,
                            icon: Icons.brightness_1_outlined,
                            onPressed: () {
                              showPublicToast(
                                msg: 'Bottom Right Floating Button',
                                gravity: ToastGravity.BOTTOM,
                                fontSize: kSpacer.sm,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding:
                          kSpacer.edgeInsets.only(left: 'sm', bottom: 'sm'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CustomIconButton(
                            shadowStrokeType: ShadowStrokeType.lowShadow,
                            icon: Icons.brightness_1_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SmallButton(
                      shadowStrokeType: ShadowStrokeType.lowShadow,
                      title: 'Small Floating Button',
                      onPressed: () {
                        showPublicToast(
                          msg: 'Center Floating Button',
                          gravity: ToastGravity.BOTTOM,
                          fontSize: kSpacer.sm,
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: kSpacer.edgeInsets.only(right: 'sm', top: 'xs'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomIconButton(
                            widgetTheme: WidgetTheme.blueWhite,
                            icon: Icons.brightness_1_outlined,
                            onPressed: () {
                              showPublicToast(
                                msg: 'Top Right Floating Button',
                                gravity: ToastGravity.BOTTOM,
                                fontSize: kSpacer.sm,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: kSpacer.edgeInsets.only(left: 'sm', top: 'xs'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CustomIconButton(
                            widgetTheme: WidgetTheme.blackWhite,
                            icon: Icons.brightness_1_outlined,
                            onPressed: () {
                              showPublicToast(
                                msg: 'Top Left Floating Button',
                                gravity: ToastGravity.BOTTOM,
                                fontSize: kSpacer.sm,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
