import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class GalleryCard extends StatefulWidget {
  const GalleryCard({
    @required this.image,
    this.onTap,
  });

  /// required
  final String image;

  /// optional
  final VoidCallback onTap;

  @override
  _GalleryCardState createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  bool _isImageLoading = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = AppQuery(context).width;
    const double ratio = kExtentZeroPoint5;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: screenWidth * ratio,
        child: AspectRatio(aspectRatio: 222 / 266, child: _image),
      ),
    );
  }

  Widget get _image {
    if (widget.image.contains('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(kDefaultMargin),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ShimmerView(
                padding: AppSpacer(context: context).edgeInsets.all.none,
                play: _isImageLoading,
                child: Container(
                  color: _isImageLoading ? kAppWhite : null,
                ),
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: _isImageLoading,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      if (loadingProgress == null) {
                        setState(() {
                          _isImageLoading = false;
                        });
                      }
                      if (_isImageLoading == false) {
                        setState(() {
                          _isImageLoading = true;
                        });
                      }
                    });
                    return child;
                  },
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
          widget.image,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
