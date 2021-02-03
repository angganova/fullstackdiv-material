import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class BasicListItem extends StatefulWidget {
  /// this is the [BasicListItem]
  /// with [Image], [Title], [Subtitle],
  /// and [Description] on the right side
  const BasicListItem({
    @required this.title,
    this.subtitle,
    this.description,
    this.image,
    this.cachedImage,
    this.imageFit = BoxFit.cover,
    this.icon,
    this.iconSize,
    this.iconColor = kAppBlack,
    this.iconBoxColor = kAppGreyD,
    this.trailingTitle,
    this.trailingSubtitle,
    this.trailingTextAlign = TextAlign.center,
    this.trailingTitleTextStyle,
    this.trailingButtonIcon,
    this.onTrailingIconButton,
    this.shadowStrokeType = ShadowStrokeType.none,
    this.radius,
    this.backgroundColor = kAppWhite,
    this.imageBackgroundColor = kAppClearWhite,
    this.imageBackgroundSize,
    this.padding,
    this.imagePadding,
    this.subtitleTextColor,
    this.subtitleMaxLines,
    this.onTap,
    this.disableTap = true,
  });

  /// required
  final String title;

  /// recommended
  final ShadowStrokeType shadowStrokeType;

  /// optional
  final String subtitle;
  final Color subtitleTextColor;
  final String description;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color iconBoxColor;
  final String image;
  final String cachedImage;
  final BoxFit imageFit;
  final String trailingTitle;
  final String trailingSubtitle;
  final TextAlign trailingTextAlign;
  final TextStyle trailingTitleTextStyle;
  final IconData trailingButtonIcon;
  final VoidCallback onTrailingIconButton;
  final double radius;
  final Color backgroundColor;
  final Color imageBackgroundColor;
  final double imageBackgroundSize;
  final EdgeInsets padding;
  final EdgeInsets imagePadding;
  final int subtitleMaxLines;
  final VoidCallback onTap;
  final bool disableTap;
  @override
  _BasicListItemState createState() => _BasicListItemState();
}

class _BasicListItemState extends State<BasicListItem> {
  final bool _isImageLoading = true;

  @override
  Widget build(BuildContext context) {
    /// here is some immutable properties
    final double _radius = widget.radius ?? kBorderRadiusSmall;
    final EdgeInsets _imagePadding =
        widget.imagePadding ?? kSpacer.edgeInsets.all.none;

    return GestureDetector(
      onTap: widget.onTap,
      child: ShadowStrokeStyles(
        shadowStrokeType: widget.shadowStrokeType,
        radius: _radius,
        color: widget.disableTap
            ? widget.backgroundColor
            : widget.backgroundColor.withOpacity(.5),
        padding:
            widget.padding ?? const EdgeInsets.only(bottom: kDefaultMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.cachedImage != null)
              Padding(
                padding: kSpacer.edgeInsets.right.sm,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadiusExtraSmall),
                  child: CachedNetworkImage(
                    imageUrl: widget.cachedImage,
                    width: widget.imageBackgroundSize ?? kSpacer.xxl,
                    height: widget.imageBackgroundSize ?? kSpacer.xxl,
                    memCacheHeight: widget.imageBackgroundSize?.toInt() ??
                        kSpacer.xxl.toInt(),
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 200),
                    placeholder: (BuildContext context, String text) => Center(
                      child: ShimmerView(
                        padding: kSpacer.edgeInsets.all.none,
                        play: true,
                        child: Container(
                          color: _isImageLoading ? kAppWhite : null,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else if (widget.image != null)
              if (widget.image.contains('assets'))
                Padding(
                  padding: kSpacer.edgeInsets.right.sm,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.imageBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(kBorderRadiusExtraSmall),
                    ),
                    width: widget.imageBackgroundSize ?? kSpacer.xxl,
                    height: widget.imageBackgroundSize ?? kSpacer.xxl,
                    padding: _imagePadding,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(kBorderRadiusExtraSmall),
                      child: Image.asset(
                        widget.image,
                        fit: widget.imageFit,
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: kSpacer.edgeInsets.right.sm,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.imageBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(kBorderRadiusExtraSmall),
                    ),
                    width: widget.imageBackgroundSize ?? kSpacer.xxl,
                    height: widget.imageBackgroundSize ?? kSpacer.xxl,
                    padding: _imagePadding,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(kBorderRadiusExtraSmall),
                      child: Image.network(
                        widget.image,
                        fit: widget.imageFit,
                      ),
                    ),
                  ),
                )
            else if (widget.icon != null)
              Padding(
                padding: kSpacer.edgeInsets.right.sm,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: widget.iconBoxColor,
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusExtraSmall),
                      ),
                      width: widget.imageBackgroundSize ?? kSpacer.xxl,
                      height: widget.imageBackgroundSize ?? kSpacer.xxl,
                      padding: EdgeInsets.all(kSpacer.lg / 2),
                    ),
                    Icon(
                      widget.icon,
                      size: widget.iconSize ?? kSmallIconSize,
                      color: widget.iconColor,
                    ),
                  ],
                ),
              ),
            if (widget.description != null && widget.subtitle != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(
                        color: widget.disableTap
                            ? kAppBlack
                            : kAppBlack.withOpacity(.5),
                      ).primaryH4,
                    ),
                    SizedBox(
                      height: kSpacer.xxs,
                    ),
                    Text(
                      widget.subtitle,
                      maxLines: widget.subtitleMaxLines ?? 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(
                              color: widget.subtitleTextColor ?? kAppGreyB)
                          .primaryLabel4,
                    ),
                    SizedBox(
                      height: kSpacer.xxs,
                    ),
                    Text(
                      widget.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(color: kAppGreyA).primaryLabel4,
                    ),
                  ],
                ),
              )
            else if (widget.description != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: AppTextStyle(
                        color: widget.disableTap
                            ? kAppBlack
                            : kAppBlack.withOpacity(.5),
                      ).primaryH4,
                    ),
                    SizedBox(
                      height: kSpacer.xxs,
                    ),
                    Text(
                      widget.description,
                      style: AppTextStyle(color: kAppGreyA).primaryLabel4,
                    ),
                  ],
                ),
              )
            else if (widget.subtitle != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: AppTextStyle(
                        color: widget.disableTap
                            ? kAppBlack
                            : kAppBlack.withOpacity(.5),
                      ).primaryH4,
                    ),
                    SizedBox(
                      height: kSpacer.xxs,
                    ),
                    Text(
                      widget.subtitle,
                      style: AppTextStyle(color: kAppGreyB).primaryLabel4,
                      maxLines: widget.subtitleMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTextStyle(
                    color: widget.disableTap
                        ? kAppBlack
                        : kAppBlack.withOpacity(0.5),
                  ).primaryH4,
                ),
              ),
            if (widget.trailingTitle != null && widget.trailingSubtitle != null)
              Padding(
                padding: AppSpacer(context: context).edgeInsets.left.standard,
                child: Column(
                  crossAxisAlignment: _currentCrossAxis,
                  children: <Widget>[
                    Text(
                      widget.trailingTitle,
                      textAlign: TextAlign.end,
                      style: AppTextStyle(color: kAppBlack).primaryH4,
                    ),
                    SizedBox(
                      height: kSpacer.xxs,
                    ),
                    Text(
                      widget.trailingSubtitle,
                      textAlign: TextAlign.end,
                      style: AppTextStyle(color: kAppGreyB).primaryLabel4,
                    ),
                  ],
                ),
              )
            else if (widget.trailingTitle != null)
              Text(
                widget.trailingTitle,
                style: widget.trailingTitleTextStyle ??
                    AppTextStyle(
                      color: widget.disableTap
                          ? kAppBlack
                          : kAppBlack.withOpacity(.5),
                    ).primaryH4,
              ),
            SizedBox(
              width: kSpacer.xs,
            ),
            if (widget.trailingButtonIcon != null &&
                widget.onTrailingIconButton != null)
              InkWell(
                onTap: widget.onTrailingIconButton,
                child: Icon(
                  widget.trailingButtonIcon,
                  size: widget.iconSize ?? kSmallIconSize,
                  color: kAppGreyC,
                ),
              ),
          ],
        ),
      ),
    );
  }

  CrossAxisAlignment get _currentCrossAxis {
    if (widget.trailingTextAlign == TextAlign.left)
      return CrossAxisAlignment.start;
    else if (widget.trailingTextAlign == TextAlign.right)
      return CrossAxisAlignment.end;
    else
      return CrossAxisAlignment.center;
  }
}
