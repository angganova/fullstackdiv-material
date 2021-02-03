import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/rating/rating_item.dart';
import 'package:fullstackdiv_material/app/components/rating/stores/rating_store.dart';

/// This is the custom [Rating] class
class Rating extends StatefulWidget {
  const Rating({
    @required this.onRated,
    this.ratingCount = 5,
    this.initialRating = 0,
    this.enabled = true,
  });

  /// required
  final Function(int) onRated;

  /// optional
  final int initialRating;
  final int ratingCount;
  final bool enabled;

  @override
  _Rating createState() => _Rating();
}

class _Rating extends State<Rating> {
  final RatingStore ratingStore = RatingStore();

  @override
  void initState() {
    super.initState();
    ratingStore.ratingCount = widget.ratingCount;
    ratingStore.rating = widget.initialRating;
    ratingStore.enabled = widget.enabled;
  }

  @override
  void dispose() {
    ratingStore.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <RatingItem>[
        for (int index = 1; index <= ratingStore.ratingCount; index++)
          RatingItem(
            selected: ratingStore.rating >= index,
            onSelected: (bool selected) {
              if (ratingStore.enabled) {
                setState(() {
                  ratingStore.rating = index;
                });
                widget.onRated(index);
              }
            },
          ),
      ],
    );
  }
}
