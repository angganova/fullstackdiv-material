import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/custom_icon_button.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class MerchantCard extends StatelessWidget {
  /// this is the [MerchantCard] component that used in
  /// [MerchantCarousel]

  const MerchantCard({
    @required this.title,
    @required this.subtitle,
    this.image,
    this.titleColor = kAppBlack,
    this.subtitleColor = kAppGreyB,
    this.onLikeTap,
    this.onCardTap,
    this.isLiked = false,
    this.discount,
  });

  /// required
  final String title;
  final String subtitle;

  /// optional
  final String image;
  final Color titleColor;
  final Color subtitleColor;
  final VoidCallback onLikeTap;
  final VoidCallback onCardTap;
  final bool isLiked;
  final String discount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        /// because this will be shown side by side so its value is 24/2
        padding: kSpacer.edgeInsets.all.xs,
        decoration: const BoxDecoration(
          color: kAppWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(kBorderRadiusSmall),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (image != null && image != '')
                  _image(context)
                else
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(kBorderRadiusExtraSmall),
                    child: Container(
                      width: 0.3 * AppQuery(context).width,
                      color: kAppGreyD,
                      child: AspectRatio(
                        aspectRatio: 0.81,
                        child: Icon(
                          Icons.restaurant,
                        ),
                      ),
                    ),
                  ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 12.0,
                      left: kSpacer.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          maxLines: 1,
                          style: AppTextStyle(
                            color: titleColor,
                            context: context,
                          ).primaryH3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: kSpacer.xxs),
                        Text(
                          subtitle,
                          maxLines: 1,
                          softWrap: true,
                          style: AppTextStyle(
                            color: subtitleColor,
                            context: context,
                          ).primaryLabel6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (onLikeTap != null)
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: (0.3 * AppQuery(context).width) + kSpacer.sm,
                    bottom: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (discount != null)
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: kSpacer.xs,
                                vertical: 6.0,
                              ),
                              margin: kSpacer.edgeInsets.bottom.xs,
                              decoration: const BoxDecoration(
                                color: kAppSecondaryYellow,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(kBorderRadiusSmall),
                                ),
                              ),
                              child: Text(
                                discount,
                                style: AppTextStyle(
                                  color: kAppBlack,
                                  context: context,
                                ).primaryLabel4,
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: <Widget>[
                          CustomIconButton(
                            icon: Icons.brightness_1_outlined,
                            iconSize: AppSpacer(context: context).sm,
                            onPressed: onLikeTap,
                            shadowStrokeType: ShadowStrokeType.stroke2px,
                            widgetTheme: isLiked
                                ? WidgetTheme.whiteRed
                                : WidgetTheme.whiteGrey,
                            padding:
                                AppSpacer(context: context).edgeInsets.all.xs,
                          ),
                        ],
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

  Widget _image(BuildContext context) {
    if (image != null && image.contains('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kDefaultMargin),
        child: Container(
          width: 0.3 * AppQuery(context).width,
          child: AspectRatio(
            aspectRatio: 2 / 2.55,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 200),
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
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadiusExtraSmall),
        child: Container(
          width: 0.3 * AppQuery(context).width,
          child: AspectRatio(
            aspectRatio: 0.81,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }
}
