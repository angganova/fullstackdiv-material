import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class WideCard extends StatelessWidget {
  const WideCard({
    @required this.image,
    @required this.title,
    this.subtitle,
    this.subtitleCustomized,
    this.metadata,
    this.badgeText,
    this.detailsBadge,
    this.detailsBadgeCustomized,
    this.isTitleBelowCard = true,
    this.isSubTitleBelowCard = true,
    this.isWithGradienceOverlay = false,
    this.badgeBackgroundColor,
    this.titleColor = kAppBlack,
    this.subtitleColor = kAppBlack,
    this.metadataColor = kAppGreyB,
    this.onTap,
    this.titleMaxLine = 1,
  });

  /// required
  final String image;
  final String title;
  final Widget subtitleCustomized;

  /// optional
  final String subtitle;
  final String metadata;
  final String badgeText;
  final String detailsBadge;
  final Widget detailsBadgeCustomized;
  final bool isTitleBelowCard;
  final bool isSubTitleBelowCard;
  final bool isWithGradienceOverlay;
  final Color badgeBackgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color metadataColor;
  final VoidCallback onTap;
  final int titleMaxLine;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = AppQuery(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * kExtentZeroPoint6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                AspectRatio(aspectRatio: 224 / 136, child: _image(context)),
                if (isWithGradienceOverlay)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadiusSmall),
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color.fromRGBO(0, 0, 0, 0.2),
                            Color.fromRGBO(0, 0, 0, 0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _detailsBadge,
                        _badge,
                      ],
                    ),
                  ),
                ),
                if (!isTitleBelowCard)
                  Positioned.fill(
                    bottom: !isSubTitleBelowCard ? kSpacer.md : kSpacer.sm,
                    left: kSpacer.sm,
                    right: kSpacer.sm,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _title,
                    ),
                  ),
                if (!isSubTitleBelowCard)
                  Positioned.fill(
                    bottom: kSpacer.sm,
                    left: kSpacer.sm,
                    right: kSpacer.sm,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _subtitle,
                    ),
                  ),
              ],
            ),
            if (isTitleBelowCard)
              _title
            else
              const SizedBox(
                height: 12,
              ),
            if (isSubTitleBelowCard) _subtitle,
            _metadata,
          ],
        ),
      ),
    );
  }

  Widget get _badge {
    if (badgeText == null) {
      return Container();
    }else{
      return Container();
    }
  }

  Widget get _detailsBadge {
    if (detailsBadge == null && detailsBadgeCustomized == null) {
      return Container();
    } else {
      return Padding(
        padding: kSpacer.edgeInsets.only(top: 'xs', right: 'xs'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kBorderRadiusSmall),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(22, 22, 22, 0.32),
              ),
              child: detailsBadgeCustomized ??
                  Text(
                    detailsBadge,
                    style: AppTextStyle(color: kAppWhite).primaryLabel4,
                  ),
            ),
          ),
        ),
      );
    }
  }

  Widget _image(BuildContext context) {
    if (image.contains('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kDefaultMargin),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: image,
                filterQuality: FilterQuality.high,
                // memCacheWidth: 800,
                memCacheHeight: cacheMaxHeightImage,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 100),
                errorWidget:
                    (BuildContext context, String url, dynamic error) =>
                        Container(),
                placeholder: (BuildContext context, String text) => Center(
                  child: ShimmerView(
                    padding: AppSpacer(context: context).edgeInsets.all.none,
                    play: true,
                    child: Container(
                      color: kAppWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kDefaultMargin),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget get _title {
    if (title == null) {
      return Container();
    }
    return Padding(
      padding: kSpacer.edgeInsets.only(top: 'sm'),
      child: Text(
        title,
        maxLines: titleMaxLine,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle(color: titleColor).primaryH4,
      ),
    );
  }

  Widget get _subtitle {
    if (subtitleCustomized != null) {
      return subtitleCustomized;
    }
    if (subtitle == null) {
      return Container();
    }
    return Padding(
      padding: kSpacer.edgeInsets.only(top: 'xxs'),
      child: Text(
        subtitle,
        maxLines: 1,
        style: AppTextStyle(color: subtitleColor).primaryLabel4,
      ),
    );
  }

  Widget get _metadata {
    if (metadata == null) {
      return Container();
    } else {
      return Padding(
        padding: kSpacer.edgeInsets.only(top: 'xxs'),
        child: Text(
          metadata,
          maxLines: 1,
          style: AppTextStyle(color: metadataColor).primaryLabel4,
        ),
      );
    }
  }
}
