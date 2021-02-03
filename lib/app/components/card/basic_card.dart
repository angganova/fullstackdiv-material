import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class BasicWideCard extends StatelessWidget {
  /// this is the [BasicWideCard] component that contains image & texts
  /// it got [image], [title], & [subtitle] as the required values

  const BasicWideCard({
    @required this.image,
    @required this.title,
    @required this.subtitle,
    this.titleColor = kAppBlack,
    this.subtitleColor = kAppBlack,
    this.badgeContent,
    this.badgeTheme,
    this.description,
    this.descriptionColor = kAppGreyB,
    this.onCardTap,
  });

  /// required
  final String image;
  final String title;
  final String subtitle;

  /// optional
  final Color titleColor;
  final Color subtitleColor;
  final String badgeContent;
  final WidgetTheme badgeTheme;
  final String description;
  final Color descriptionColor;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        /// because this will be shown side by side so its value is 24/2
        padding: const EdgeInsets.all(kDefaultMargin / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              _image,
            SizedBox(height: kSpacer.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  style: AppTextStyle(color: titleColor).primaryH4,
                ),
                SizedBox(height: kSpacer.xxs),
                Text(
                  subtitle,
                  maxLines: 1,
                  softWrap: true,
                  style: AppTextStyle(color: subtitleColor).primaryLabel4,
                ),
                if (description != null)
                  Padding(
                    padding: EdgeInsets.only(top: kSpacer.xxs),
                    child: Text(
                      description,
                      maxLines: 1,
                      softWrap: true,
                      style:
                          AppTextStyle(color: descriptionColor).primaryLabel4,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get _image {
    if (image.contains('http')) {
      return Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultMargin),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultMargin),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
