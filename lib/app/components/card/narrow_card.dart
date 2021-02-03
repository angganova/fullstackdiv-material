import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class NarrowCard extends StatelessWidget {
  const NarrowCard({
    @required this.title,
    this.subtitle,
    this.image,
    this.icon,
    this.metadata,
    this.badgeText,
    this.detailsBadge,
    this.isTitleBelowCard = true,
    this.isWithGradienceOverlay = false,
    this.backgroundColor = kAppGreyD,
    this.badgeBackgroundColor,
    this.titleColor,
    this.subtitleColor = kAppBlack,
    this.metadataColor = kAppGreyB,
    this.onTap,
    this.aspectRatio,
  });

  /// required
  final String title;
  final String subtitle;

  /// optional
  final String image;
  final IconData icon;
  final String metadata;
  final String badgeText;
  final String detailsBadge;
  final bool isTitleBelowCard;
  final bool isWithGradienceOverlay;
  final Color backgroundColor;
  final Color badgeBackgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color metadataColor;
  final VoidCallback onTap;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _contentView(context),
    );
  }

  Widget _contentView(BuildContext context) {
    final double screenWidth = AppQuery(context).width;
    const double ratio = kExtentZeroPoint33;
    if (aspectRatio != null) {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(kDefaultMargin),
                    ),
                  ),
                ),
                AspectRatio(aspectRatio: 120 / 136, child: _image(context)),
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
                if (isTitleBelowCard)
                  Positioned.fill(
                    child:
                        Align(alignment: Alignment.center, child: Icon(icon)),
                  )
                else
                  Positioned.fill(
                    top: kSpacer.sm,
                    left: kSpacer.sm,
                    child:
                        Align(alignment: Alignment.topLeft, child: Icon(icon)),
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
                    bottom: kSpacer.sm,
                    left: kSpacer.sm,
                    right: kSpacer.sm,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _title,
                    ),
                  ),
              ],
            ),
            if (isTitleBelowCard)
              Padding(
                padding: kSpacer.edgeInsets.only(top: 'sm'),
                child: _title,
              ),
            _subtitle,
            _metadata,
          ],
        ),
      );
    } else {
      return Container(
        width: screenWidth * ratio,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(kDefaultMargin),
                    ),
                  ),
                ),
                AspectRatio(aspectRatio: 120 / 136, child: _image(context)),
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
                if (isTitleBelowCard)
                  Positioned.fill(
                    child:
                        Align(alignment: Alignment.center, child: Icon(icon)),
                  )
                else
                  Positioned.fill(
                    top: kSpacer.sm,
                    left: kSpacer.sm,
                    child:
                        Align(alignment: Alignment.topLeft, child: Icon(icon)),
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
                    bottom: kSpacer.sm,
                    left: kSpacer.sm,
                    right: kSpacer.sm,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _title,
                    ),
                  ),
              ],
            ),
            if (isTitleBelowCard)
              Padding(
                padding: kSpacer.edgeInsets.only(top: 'sm'),
                child: _title,
              ),
            _subtitle,
            _metadata,
          ],
        ),
      );
    }
  }

  Widget get _badge {
    if (badgeText == null) {
      return Container();
    }
  }

  Widget get _detailsBadge {
    if (detailsBadge == null) {
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
              child: Text(
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
    if (image == null) {
      return Container();
    }
    if (image.contains('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kDefaultMargin),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: image,
                filterQuality: FilterQuality.high,
                memCacheHeight: cacheMaxHeightImage,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 50),
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
    Color color;
    if (titleColor == null) {
      if (isTitleBelowCard) {
        color = kAppBlack;
      } else {
        color = kAppWhite;
      }
    } else {
      color = titleColor;
    }
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle(color: color).primaryH4,
    );
  }

  Widget get _subtitle {
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
