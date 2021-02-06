import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/list_item/interactive_list_item.dart';
import 'package:fullstackdiv_material/app/components/popupmenu/app_popup_menu.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DemoInteractiveListItem extends StatefulWidget {
  @override
  _DemoInteractiveListItemState createState() =>
      _DemoInteractiveListItemState();
}

class _DemoInteractiveListItemState extends State<DemoInteractiveListItem> {
  List<InteractiveListItem> _listOfWidget;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void showPopupMenu(TapUpDetails tapUpDetails, String text) {
    final List<AppPopupMenuEntry<String>> items = <AppPopupMenuEntry<String>>[
      const AppPopupMenuItem<String>(
          child: ZestMenu(icon: Icons.edit, text: 'Edit'), value: '1'),
      const AppPopupMenuDivider(),
      const AppPopupMenuItem<String>(
          child: ZestMenu(icon: Icons.share, text: 'Share'), value: '2'),
    ];
    showZestPopupMenu(
            context: context, tapUpDetails: tapUpDetails, items: items)
        .then<void>((String itemSelected) {
      if (itemSelected == null) {
        return;
      }
      if (itemSelected == '1') {
        //code here
        showPublicToast(msg: 'Edit $text');
      } else if (itemSelected == '2') {
        //code here
        showPublicToast(msg: 'Share $text');
      } else {
        //code here
      }
    });
  }

  void initData() {
    _listOfWidget = <InteractiveListItem>[];
    _listOfWidget.add(
      InteractiveListItem(
        icon: Icons.home,
        title: 'Mom’s House',
        description: '48 Spottiswoode Park Rd',
        frontInfoIcon: Icons.more,
        backInfoText: 'Clear',
        backInfoIcon: Icons.close,
        isSlideAble: true,
        backBackgroundColor: kAppFriendlyRed,
        onSlideLeftAction: () {
          showPublicToast(msg: 'Clear');
        },
        onFrontIconAction: (TapUpDetails tapUpDetails) async {
          showPopupMenu(tapUpDetails, 'Mom’s House');
        },
        onTap: () {
          showPublicToast(msg: 'Tap Mom’s House');
        },
      ),
    );
    _listOfWidget.add(
      InteractiveListItem(
        image: 'https://picsum.photos/200/200?${Random().nextInt(9999)}',
        title: 'Tippling Club',
        description: '71 Duxton Hill',
        frontInfoText: 'More',
        frontInfoIcon: Icons.more,
        backInfoText: 'Clear',
        backInfoIcon: Icons.close,
        isSlideAble: true,
        backBackgroundColor: kAppFriendlyRed,
        onSlideLeftAction: () {
          showPublicToast(msg: 'Clear');
        },
        onFrontIconAction: (TapUpDetails tapUpDetails) {
          showPopupMenu(tapUpDetails, 'Tippling Club');
        },
        onTap: () {
          showPublicToast(msg: 'Tap Tippling Club');
        },
      ),
    );
    _listOfWidget.add(
      InteractiveListItem(
        image: 'assets/demo/flutter_logo.png',
        title: 'Marquis of Lorne',
        description: '98A Club Street',
        frontInfoIcon: Icons.more,
        backInfoText: 'Clear',
        backInfoIcon: Icons.close,
        isSlideAble: true,
        backBackgroundColor: kAppFriendlyRed,
        onSlideLeftAction: () {
          showPublicToast(msg: 'Clear');
        },
        onFrontIconAction: (TapUpDetails tapUpDetails) {
          showPopupMenu(tapUpDetails, 'Marquis of Lorne');
        },
        onTap: () {
          showPublicToast(msg: 'Tap Marquis of Lorne');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Interactive List Item',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _listOfWidget.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: kDefaultMargin,
                ),
                padding: const EdgeInsets.only(
                    top: kDefaultMargin, bottom: kDefaultMargin),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultMargin),
                    child: _listOfWidget[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
