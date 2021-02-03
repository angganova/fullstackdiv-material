import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [RatingItem] which used inside the custom [Rating] class
class RatingItem extends StatelessWidget {
  const RatingItem({
    @required this.selected,
    @required this.onSelected,
  });

  /// required
  final bool selected;
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: kSpacer.edgeInsets.x.xxs,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: kRatingItemSize,
            child: AspectRatio(
                aspectRatio: 1,
                child: BasicButton(
                  padding: const EdgeInsets.all(kDefaultSmallMargin),
                  shadowStrokeType: selected
                      ? ShadowStrokeType.none
                      : ShadowStrokeType.lowShadow,
                  backgroundColor: selected ? kAppPrimaryRed : kAppWhite,
                  icon: selected ? Icons.star : Icons.star_border,
                  onPressed: () {
                    onSelected(!selected);
                  },
                )),
          ),
        ),
      ),
    );
  }
}
