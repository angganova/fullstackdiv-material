import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_item/notification_list_item.dart';
import 'package:fullstackdiv_material/app/components/vertical_drawer/vertical_drawer.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoNotificationListItem extends StatelessWidget {
  /// this is the example of page with [VerticalDrawer]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Notification List Item',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultMargin),
                child: ListView(
                  children: <Widget>[
                    const NotificationListItem(
                      text: 'test notification',
                      widgetTheme: WidgetTheme.blackWhite,
                    ),
                    SizedBox(height: kSpacer.xs),
                    const NotificationListItem(
                      text:
                          'Surcharges can include road tolls or additional fees charged during peak hours, '
                          'midnight or at for certain locations (e.g. airports).',
                      widgetTheme: WidgetTheme.blueWhite,
                    ),
                    SizedBox(height: kSpacer.xs),
                    NotificationListItem(
                      text:
                          'Meeting someone? Share your destination and arrival time.',
                      widgetTheme: WidgetTheme.greyBlack,
                      actionName: 'Share',
                      action: () {},
                    ),
                    SizedBox(height: kSpacer.xs),
                    const NotificationListItem(
                      text: 'You should arrive by',
                      textColor: kAppBlack,
                      backgroundColor: kAppPrimaryOrange,
                      imagePath: 'assets/icons/pins/pin_destination.png',
                      trailingText: '12:35 pm',
                    ),
                    SizedBox(height: kSpacer.xs),
                    const NotificationListItem(
                      text: 'Your ride should arrive in',
                      textColor: kAppBlack,
                      backgroundColor: kAppPrimaryBrightBlue,
                      imagePath: 'assets/icons/taxi/taxi_car.png',
                      imageBackgroundColor: kAppWhite,
                      trailingText: '7 mins',
                    ),
                    SizedBox(height: kSpacer.xs),
                    const NotificationListItem(
                      text: 'Walk 400m',
                      widgetTheme: WidgetTheme.greyBlack,
                      icon: Icons.location_on,
                      trailingText: '2 mins',
                    ),
                    SizedBox(height: kSpacer.xs),
                    const NotificationListItem(
                      text: 'Wait for bus',
                      widgetTheme: WidgetTheme.blackWhite,
                      icon: Icons.location_on,
                      trailingText: '13:25',
                      trailingSubtitle: 'Arrives by',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
