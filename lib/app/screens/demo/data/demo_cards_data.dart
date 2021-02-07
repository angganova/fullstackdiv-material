import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/card/feature_card.dart';
import 'package:fullstackdiv_material/app/components/card/narrow_card.dart';
import 'package:fullstackdiv_material/app/components/card/wide_card.dart';
import 'package:fullstackdiv_material/app/components/snackbar/basic_snack_bar.dart';
import 'package:fullstackdiv_material/app/components/toast/public_toast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

BuildContext context;

List<Widget> allCards(BuildContext ct) {
  context = ct;
  return <Widget>[
    Container(
      padding: kSpacer.edgeInsets.only(bottom: 'sm', left: 'sm'),
      child: Text(
        'Scroll down to see all cards',
        maxLines: 2,
        style: AppTextStyle(color: kAppBlack).primaryH3,
      ),
    ),
    _buildHeader('Narrow Card Type A:'),
    _buildListViewNarrowCardTypeA(length: 10),
    _buildHeader('Narrow Card Type  B:'),
    _buildListViewNarrowCardTypeB(length: 10),
    _buildHeader('Narrow Card Type C :'),
    _buildListViewNarrowCardTypeC(length: 10),
    _buildHeader('Narrow Card Type D :'),
    _buildListViewNarrowCardTypeD(length: 10),
    _buildHeader('Wide Card :'),
    _buildListViewWideCard(length: 10),
    _buildHeader('New Wide Card :'),
    _buildListViewNewWideCard(length: 10),
    _buildHeader('Feature Card :'),
    _buildFeatureCard(length: 5),
  ];
}

Widget _buildHeader(String title) {
  return Container(
    padding: const EdgeInsets.all(kDefaultMargin),
    color: kAppBlack,
    child: Text(
      title,
      maxLines: 2,
      style: AppTextStyle(color: kAppWhite).primaryH4,
    ),
  );
}

Widget _buildListViewNarrowCardTypeA({int length}) {
  final List<Widget> cards = <Widget>[];
  for (int index = 0; index < length; index++) {
    cards.add(Padding(
      padding: kSpacer.edgeInsets.x.xxs,
      child: NarrowCard(
        image: 'https://picsum.photos/200?$index',
        title: 'Restaurant name (index $index)',
        badgeText: index == 1 || index == 3 ? null : '$index km',
        detailsBadge: index == 2 || index == 3 ? null : 'Details',
        badgeBackgroundColor: WidgetTheme.yellowBlack.backgroundColor,
        onTap: () {
          showPublicToast(msg: 'onTap (index $index)');
        },
      ),
    ));
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultMargin, horizontal: kSpacer.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    ),
  );
}

Widget _buildListViewNarrowCardTypeB({int length}) {
  final List<Widget> cards = <Widget>[];
  for (int index = 0; index < length; index++) {
    cards.add(Padding(
      padding: kSpacer.edgeInsets.x.xxs,
      child: NarrowCard(
        image: 'https://picsum.photos/200?$index',
        title: 'Restaurant name (index $index)',
        badgeText: index == 1 || index == 3 ? null : '$index km',
        detailsBadge: index == 2 || index == 3 ? null : 'Details',
        badgeBackgroundColor: WidgetTheme.yellowBlack.backgroundColor,
        isTitleBelowCard: false,
        isWithGradienceOverlay: true,
        onTap: () {
          showPublicToast(msg: 'onTap (index $index)');
        },
      ),
    ));
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultMargin, horizontal: kSpacer.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    ),
  );
}

Widget _buildListViewNarrowCardTypeC({int length}) {
  final List<Widget> cards = <Widget>[];
  for (int index = 0; index < length; index++) {
    cards.add(Padding(
      padding: kSpacer.edgeInsets.x.xxs,
      child: NarrowCard(
        icon: Icons.restaurant,
        title: 'Restaurant name (index $index)',
        badgeText: index == 2 || index == 3 ? null : '$index km',
        detailsBadge: index == 1 || index == 3 ? null : 'Details',
        badgeBackgroundColor: WidgetTheme.yellowBlack.backgroundColor,
        onTap: () {
          showPublicToast(msg: 'onTap (index $index)');
        },
      ),
    ));
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultMargin, horizontal: kSpacer.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    ),
  );
}

Widget _buildListViewNarrowCardTypeD({int length}) {
  final List<Widget> cards = <Widget>[];
  for (int index = 0; index < length; index++) {
    cards.add(Padding(
      padding: kSpacer.edgeInsets.x.xxs,
      child: NarrowCard(
        icon: Icons.restaurant,
        title: 'Restaurant name (index $index)',
        badgeText: index == 2 || index == 3 ? null : '$index km',
        detailsBadge: index == 1 || index == 3 ? null : 'Details',
        badgeBackgroundColor: WidgetTheme.yellowBlack.backgroundColor,
        titleColor: kAppBlack,
        isTitleBelowCard: false,
        onTap: () {
          showPublicToast(msg: 'onTap (index $index)');
        },
      ),
    ));
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultMargin, horizontal: kSpacer.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    ),
  );
}

Widget _buildListViewWideCard({int length}) {
  final List<Widget> cards = <Widget>[];
  for (int index = 0; index < length; index++) {
    cards.add(Padding(
      padding: kSpacer.edgeInsets.x.xxs,
      child: WideCard(
        image: 'https://picsum.photos/200/300?$index',
        title: 'title (index $index)',
        subtitle: 'subtitle (index $index)',
        metadata: index == 2 ? null : 'metadata (index $index)',
        badgeText: index == 1 ? null : '$index% off',
        detailsBadge: index == 0 || index == 3 ? null : 'Details',
        detailsBadgeCustomized:
            index == 0 ? _buildListViewRichSubtitle('240.53', '186.70') : null,
        badgeBackgroundColor: WidgetTheme.yellowBlack.backgroundColor,
        onTap: () {
          showPublicToast(msg: 'onTap (index $index)');
        },
      ),
    ));
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultMargin, horizontal: kSpacer.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    ),
  );
}

Widget _buildListViewNewWideCard({int length}) {
  final List<Widget> cards = <Widget>[];
  for (int index = 0; index < length; index++) {
    cards.add(Padding(
      padding: kSpacer.edgeInsets.x.xxs,
      child: WideCard(
        image: 'https://picsum.photos/200/300?$index',
        title: 'title (index $index)',
        badgeText: index == 1 ? null : '$index% off',
        detailsBadge: index == 0 || index == 3 ? null : 'Details',
        detailsBadgeCustomized:
            index == 0 ? _buildListViewRichSubtitle('240.53', '186.70') : null,
        isTitleBelowCard: false,
        isWithGradienceOverlay: true,
        titleColor: kAppWhite,
        badgeBackgroundColor: WidgetTheme.yellowBlack.backgroundColor,
        onTap: () {
          showPublicToast(msg: 'onTap (index $index)');
        },
      ),
    ));
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultMargin, horizontal: kSpacer.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    ),
  );
}

Widget _buildFeatureCard({int length}) {
  final List<Widget> cards = <Widget>[];
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      for (int index = 0; index < length; index++) {
        cards.add(Padding(
          padding: kSpacer.edgeInsets.x.xxs,
          child: FeatureCard(
            title: 'title (index $index)',
            subtitle: 'subtitle (index $index)',
            metadata: 'metadata (index $index)',
            image: 'https://picsum.photos/200?$index',
            onTap: () {
              showBasicSnackBar(
                context: context,
                text: 'Feature Card $index',
                assetImageName: 'assets/demo/bell.png',
              );
            },
          ),
        ));
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: kDefaultMargin, horizontal: kSpacer.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cards,
          ),
        ),
      );
    },
  );
}

Widget _buildListViewRichSubtitle(String priceRetail, String priceSelling) {
  return RichText(
    text: TextSpan(
      text: '',
      children: <TextSpan>[
        TextSpan(
          text: '\$' + priceRetail,
          style: AppTextStyle(color: kAppWhite).primaryLabel4LineThrough,
        ),
        TextSpan(
          text: ' \$' + priceSelling,
          style: AppTextStyle(color: kAppWhite).primaryLabel4,
        ),
      ],
    ),
  );
}
