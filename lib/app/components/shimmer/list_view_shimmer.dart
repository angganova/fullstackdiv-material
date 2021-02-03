import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/list_view/basic_list_view_builder.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/app/components/single_child_scroll/single_child_scroll.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ListViewShimmer extends StatelessWidget {
  const ListViewShimmer({
    this.play = true,
    this.baseColor = kAppGreyD,
    this.highlightColor = kAppWhite,
    this.itemCount = 1,
    this.padding,
    this.space,
  });

  final bool play;
  final Color baseColor;
  final Color highlightColor;
  final int itemCount;
  final EdgeInsets padding;
  final EdgeInsets space;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppSpacer(context: context).edgeInsets.x.standard,
      child: SingleChildScroll(
        physics: const NeverScrollableScrollPhysics(),
        child: ShimmerView(
          baseColor: baseColor,
          highlightColor: highlightColor,
          play: play,
          child: BasicListViewBuilder(
            padding: kSpacer.edgeInsets.all.none,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, __) => Padding(
              padding: space ?? kSpacer.edgeInsets.bottom.xs,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: kSpacer.xxl,
                    height: kSpacer.xxl,
                    decoration: const BoxDecoration(
                      color: kAppWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(kBorderRadiusExtraSmall),
                      ),
                    ),
                  ),
                  Padding(
                    padding: kSpacer.edgeInsets.x.xs,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: AppQuery(context).width / 2,
                          height: kSpacer.xs,
                          color: kAppWhite,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: AppQuery(context).width / 2.5,
                          height: kSpacer.xs,
                          color: kAppWhite,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            itemCount: itemCount,
          ),
        ),
      ),
    );
  }
}
