import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    @required this.title,
    @required this.subtitle,
    @required this.metadata,
    @required this.image,
    this.titleMaxLines = 1,
    this.backgroundColor = kAppSecondaryYellow,
    this.imageShadowStrokeType = ShadowStrokeType.lowShadow,
    this.onTap,
  });

  /// required
  final String title;
  final String subtitle;
  final String metadata;
  final String image;

  /// optional
  final int titleMaxLines;
  final Color backgroundColor;
  final ShadowStrokeType imageShadowStrokeType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSpacer.standard)),
          color: backgroundColor,
        ),
        constraints: BoxConstraints(
            minWidth: 100.0,
            minHeight: 136.0,
            maxWidth: AppQuery(context).width - kSpacer.standard * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(kSpacer.standard),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: AppTextStyle(color: kAppBlack).primaryH3,
                        maxLines: titleMaxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: kSpacer.xs,
                      ),
                      Container(
                        child: Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: AppTextStyle(color: kAppBlack).primaryLabel2,
                        ),
                      ),
                      SizedBox(
                        height: kSpacer.xs,
                      ),
                      Text(
                        metadata,
                        style: AppTextStyle(color: kAppBlack.withOpacity(0.5))
                            .primaryLabel1,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
              child: _image,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _image {
    if (image == null || image == '') {
      return Container();
    }
    if (image.contains('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadiusExtraSmall),
        child: ShadowStrokeStyles(
          shadowStrokeType: imageShadowStrokeType,
          padding: kSpacer.edgeInsets.all.none,
          radius: kBorderRadiusExtraSmall,
          child: Image.network(
            image,
            fit: BoxFit.cover,
            width: 96.0,
            height: 96.0,
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadiusExtraSmall),
        child: ShadowStrokeStyles(
          shadowStrokeType: imageShadowStrokeType,
          padding: kSpacer.edgeInsets.all.none,
          radius: kBorderRadiusExtraSmall,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: 96.0,
            height: 96.0,
          ),
        ),
      );
    }
  }
}
