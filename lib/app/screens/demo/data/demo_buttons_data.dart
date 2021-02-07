import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/app/components/button/just_text_button.dart';
import 'package:fullstackdiv_material/app/components/button/large_button.dart';
import 'package:fullstackdiv_material/app/components/button/small_button.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the list of all kind of buttons inside the app
/// we show 2 types of button [button with icon] & [button with no icon]

List<Widget> allButtons() {
  final TextStyle _defaultTextStyle = AppTextStyle(color: kAppBlack).primaryH4;
  final SizedBox sizedBox = SizedBox(
    width: kSpacer.xxs,
  );

  return <Widget>[
    Container(
      padding: kSpacer.edgeInsets.only(bottom: 'sm', left: 'sm'),
      child: Text(
        'Scroll down to see all buttons',
        maxLines: 2,
        style: AppTextStyle(color: kAppBlack).primaryH3,
      ),
    ),
    Container(
      padding: kSpacer.edgeInsets.all.sm,
      color: kAppBlack,
      child: Text(
        'Large Buttons :',
        maxLines: 2,
        style: AppTextStyle(color: kAppWhite).primaryH4,
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LargeButton(
            title: 'Large White',
            onPressed: () {
              showPublicToast(
                  msg: 'Large Button With Icon Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            icon: Icons.compass_calibration_sharp,
          ),
        ],
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LargeButton(
            title: 'Large Blue',
            onPressed: () {
              showPublicToast(
                  msg: 'Large Button With Icon Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            icon: Icons.location_on,
            widgetTheme: WidgetTheme.blueWhite,
          ),
        ],
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LargeButton(
            title: 'Large White',
            onPressed: () {
              showPublicToast(
                  msg: 'Large Button With Text Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
          ),
          sizedBox,
          LargeButton(
            title: 'Large Blue',
            onPressed: () {
              showPublicToast(
                  msg: 'Large Button With Text Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            widgetTheme: WidgetTheme.blueWhite,
          ),
        ],
      ),
    ),
    Container(
      padding: kSpacer.edgeInsets.all.sm,
      color: kAppBlack,
      child: Text(
        'Wide Buttons :',
        maxLines: 2,
        style: AppTextStyle(color: kAppWhite).primaryH4,
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WideButton(
            title: 'Wide White',
            onPressed: () {
              showPublicToast(
                  msg: 'Wide Button With Icon Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            icon: Icons.person,
          ),
        ],
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WideButton(
            title: 'Wide Blue',
            onPressed: () {
              showPublicToast(
                  msg: 'Large Button With Icon Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            icon: Icons.person,
            widgetTheme: WidgetTheme.blueWhite,
          ),
        ],
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WideButton(
            title: 'Wide White',
            onPressed: () {
              showPublicToast(
                  msg: 'Wide Button With Text Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
          ),
        ],
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WideButton(
            title: 'Wide Blue',
            onPressed: () {
              showPublicToast(
                  msg: 'Wide Button With Text Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            widgetTheme: WidgetTheme.blueWhite,
          ),
        ],
      ),
    ),
    Container(
      padding: kSpacer.edgeInsets.all.sm,
      color: kAppBlack,
      child: Text(
        'Small Buttons :',
        maxLines: 2,
        style: AppTextStyle(color: kAppWhite).primaryH4,
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SmallButton(
            title: 'Small White',
            onPressed: () {
              showPublicToast(
                  msg: 'Small Button With Icon Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            icon: Icons.person,
          ),
          sizedBox,
          SmallButton(
            title: 'Small Blue',
            onPressed: () {
              showPublicToast(
                  msg: 'Small Button With Icon Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            icon: Icons.person,
            widgetTheme: WidgetTheme.blueWhite,
          ),
        ],
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SmallButton(
            title: 'Small White',
            onPressed: () {
              showPublicToast(
                  msg: 'Large Button With Text Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
          ),
          sizedBox,
          SmallButton(
            title: 'Small Blue',
            onPressed: () {
              showPublicToast(
                  msg: 'Small Button With Text Tapped',
                  fontSize: _defaultTextStyle.fontSize);
            },
            widgetTheme: WidgetTheme.blueWhite,
          ),
        ],
      ),
    ),
    Container(
      padding: kSpacer.edgeInsets.all.sm,
      color: kAppBlack,
      child: Text(
        'Icon Buttons :',
        maxLines: 2,
        style: AppTextStyle(color: kAppWhite).primaryH4,
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomIconButton(
              icon: Icons.person,
              onPressed: () {
                showPublicToast(
                    msg: 'Icon Button Tapped',
                    fontSize: _defaultTextStyle.fontSize);
              },
            ),
            sizedBox,
            CustomIconButton(
              icon: Icons.person,
              onPressed: () {
                showPublicToast(
                    msg: 'Icon Button Tapped',
                    fontSize: _defaultTextStyle.fontSize);
              },
              widgetTheme: WidgetTheme.blueWhite,
            ),
          ],
        ),
      ),
    ),
    Container(
      padding: kSpacer.edgeInsets.all.sm,
      color: kAppBlack,
      child: Text(
        'Full Width Buttons :',
        maxLines: 2,
        style: AppTextStyle(color: kAppWhite).primaryH4,
      ),
    ),
    SizedBox(
      height: kSpacer.xs,
    ),
    WideButton(
      title: 'Full Width Button',
      onPressed: () {
        showPublicToast(
            msg: 'Long Button Tapped', fontSize: _defaultTextStyle.fontSize);
      },
      fullWidth: true,
    ),
    SizedBox(
      height: kSpacer.xs,
    ),
    WideButton(
      title: 'Full Width Button',
      onPressed: () {
        showPublicToast(
            msg: 'Long Button Tapped', fontSize: _defaultTextStyle.fontSize);
      },
      isTransparent: true,
      fullWidth: true,
      textColor: kAppBlack,
      selectedTextColor: kAppPrimaryElectricBlue,
    ),
    SizedBox(
      height: kSpacer.xs,
    ),
    WideButton(
      title: 'Full Width Button',
      onPressed: () {
        showPublicToast(
            msg: 'Long Button Tapped', fontSize: _defaultTextStyle.fontSize);
      },
      widgetTheme: WidgetTheme.blueWhite,
      fullWidth: true,
    ),
    SizedBox(
      height: kSpacer.xs,
    ),
    Container(
      padding: kSpacer.edgeInsets.all.sm,
      color: kAppBlack,
      child: Text(
        'Just Text Buttons :',
        maxLines: 2,
        style: AppTextStyle(color: kAppWhite).primaryH4,
      ),
    ),
    Padding(
      padding: kSpacer.edgeInsets.all.xs,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            JustTextButton(
              title: 'Just Text',
              onPressed: () {
                showPublicToast(
                    msg: 'Just Text Button Tapped',
                    fontSize: _defaultTextStyle.fontSize);
              },
            ),
          ],
        ),
      ),
    ),
  ];
}
