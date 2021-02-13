import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullstackdiv_material/app/components/shimmer/shimmer_view.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class InteractiveListItem extends StatefulWidget {
  /// this is the [InteractiveListItem]
  /// with [image]/[icon], [title], [description],
  /// and [frontInfoText], [frontInfoIcon] on the front right side
  /// and [backInfoText], [backInfoIcon] on the back right side
  /// This component is inspired by [Dismissible]
  const InteractiveListItem({
    @required this.title,
    @required this.description,
    this.image,
    this.imageFit = BoxFit.cover,
    this.icon,
    this.picture,
    this.isSlideAble = true,
    this.frontInfoText,
    this.frontInfoIcon,
    this.backInfoText,
    this.backInfoIcon,
    this.descriptionMaxLines = 1,
    this.shadowStrokeType = ShadowStrokeType.none,
    this.imageBackgroundColor = kAppWhite,
    this.iconBackgroundColor = kAppWhite,
    this.frontBackgroundColor = kAppGreyD,
    this.backBackgroundColor = kAppPrimaryElectricBlue,
    this.frontInfoTextColor = kAppBlack,
    this.backInfoTextColor = kAppWhite,
    this.frontInfoIconColor = kAppGreyC,
    this.backInfoIconColor = kAppWhite,
    this.imageBackgroundSize,
    this.iconSize = kSmallIconSize,
    this.radius,
    this.frontInfoIconSize = kSmallIconSize,
    this.backInfoIconSize = kSmallIconSize,
    this.padding,
    this.imagePadding,
    this.movementDuration = const Duration(milliseconds: 500),
    this.onSlideLeftAction,
    this.onFrontIconAction,
    this.onTap,
    this.useCacheImage = false,
  });

  /// required
  final String title;
  final String description;

  /// recommended
  final ShadowStrokeType shadowStrokeType;

  /// optional
  final IconData icon;
  final String image;
  final BoxFit imageFit;

  final Widget picture;

  final bool isSlideAble;

  final String frontInfoText;
  final String backInfoText;

  final IconData backInfoIcon;
  final IconData frontInfoIcon;

  final Color imageBackgroundColor;
  final Color iconBackgroundColor;
  final Color frontBackgroundColor;
  final Color backBackgroundColor;
  final Color frontInfoTextColor;
  final Color backInfoTextColor;
  final Color frontInfoIconColor;
  final Color backInfoIconColor;

  final double imageBackgroundSize;
  final double iconSize;
  final double radius;
  final double frontInfoIconSize;
  final double backInfoIconSize;
  final bool useCacheImage;

  final int descriptionMaxLines;

  final EdgeInsets imagePadding;
  final EdgeInsets padding;

  /// Defines the duration for card  to come back to original position.
  final Duration movementDuration;

  final VoidCallback onSlideLeftAction;
  final Function(TapUpDetails) onFrontIconAction;
  final VoidCallback onTap;

  @override
  _InteractiveListItemState createState() => _InteractiveListItemState();
}

class _InteractiveListItemState extends State<InteractiveListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _moveController;
  Animation<Offset> _moveAnimation;

  double _dragExtent = 0.0;

  double get _overallDragAxisExtent {
    final Size size = context.size;
    return size.width;
  }

  final double _offsetOnSlideActionCalled = -80;

  bool _isSlideable;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      vsync: this,
      duration: widget.movementDuration,
    );
    _updateMoveAnimation();
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_moveController.isAnimating) {
      _dragExtent =
          _moveController.value * _overallDragAxisExtent * _dragExtent.sign;
      _moveController.stop();
    } else {
      _dragExtent = 0.0;
      _moveController.value = 0.0;
    }
    setState(() {
      _updateMoveAnimation();
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final double delta = details.primaryDelta;

    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        if (_dragExtent + delta > 0) {
          _dragExtent += delta;
        }
        break;
      case TextDirection.ltr:
        if (_dragExtent + delta < 0) {
          _dragExtent += delta;
        }
        break;
    }

    setState(() {
      _updateMoveAnimation();
    });

    _moveController.value = _dragExtent.abs() / _overallDragAxisExtent;
  }

  void _handleDragEnd(DragEndDetails details) {
    _moveController.reverse().whenComplete(() {
      if (_offsetOnSlideActionCalled >= _dragExtent) {
        widget.onSlideLeftAction();
      }
      _dragExtent = details.velocity.pixelsPerSecond.dx;
    });
  }

  void _updateMoveAnimation() {
    final double end = _dragExtent.sign;
    _moveAnimation = _moveController.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: Offset(end, 0.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.backInfoText == null && widget.backInfoIcon == null) {
      _isSlideable = false;
    } else {
      _isSlideable = widget.isSlideAble;
    }
    final double _radius = widget.radius ?? kBorderRadiusSmall;
    return GestureDetector(
      onHorizontalDragStart: _isSlideable ? _handleDragStart : null,
      onHorizontalDragUpdate: _isSlideable ? _handleDragUpdate : null,
      onHorizontalDragEnd: _isSlideable ? _handleDragEnd : null,
      onTap: widget.onTap,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child:
            _buildBackContent(_radius + 2.0), // add radius to hide bleeding
          ),
          _buildFront(_radius),
        ],
      ),
    );
  }

  Widget _buildBackContent(double radius) {
    return ShadowStrokeStyles(
      shadowStrokeType: widget.shadowStrokeType,
      radius: radius,
      color: widget.backBackgroundColor,
      padding: widget.padding ??
          EdgeInsets.symmetric(vertical: kSpacer.sm, horizontal: kSpacer.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: kSpacer.sm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.backInfoIcon,
                  color: widget.backInfoIconColor,
                  size: widget.backInfoIconSize,
                ),
                if (widget.backInfoText != null)
                  Padding(
                    padding: EdgeInsets.only(top: kSpacer.xs),
                    child: Text(
                      widget.backInfoText,
                      style: AppTextStyle(color: widget.backInfoTextColor)
                          .primaryLabel3,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFront(double radius) {
    if (_isSlideable) {
      return SlideTransition(
        position: _moveAnimation,
        child: _buildFrontContent(radius),
      );
    }
    return _buildFrontContent(radius);
  }

  Widget _buildFrontContent(double radius) {
    final EdgeInsets _imagePadding =
        widget.imagePadding ?? kSpacer.edgeInsets.all.none;
    return ShadowStrokeStyles(
      shadowStrokeType: widget.shadowStrokeType,
      radius: radius,
      color: widget.frontBackgroundColor,
      padding: widget.padding ?? const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (widget.image != null)
            if (widget.image.contains('assets'))
              Padding(
                padding: kSpacer.edgeInsets.right.sm,
                child: ShadowStrokeStyles(
                  shadowStrokeType: ShadowStrokeType.lowShadow,
                  padding: _imagePadding,
                  color: widget.imageBackgroundColor,
                  radius: kBorderRadiusExtraSmall,
                  child: Container(
                    width: widget.imageBackgroundSize ?? kSpacer.xxl,
                    height: widget.imageBackgroundSize ?? kSpacer.xxl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kSpacer.sm),
                      child: Image.asset(
                        widget.image,
                        fit: widget.imageFit,
                      ),
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: kSpacer.edgeInsets.right.sm,
                child: ShadowStrokeStyles(
                  shadowStrokeType: ShadowStrokeType.lowShadow,
                  padding: _imagePadding,
                  color: widget.imageBackgroundColor,
                  radius: kBorderRadiusExtraSmall,
                  child: Container(
                    width: widget.imageBackgroundSize ?? kSpacer.xxl,
                    height: widget.imageBackgroundSize ?? kSpacer.xxl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kSpacer.sm),
                      child: widget.useCacheImage
                          ? CachedNetworkImage(
                        imageUrl: widget.image,
                        filterQuality: FilterQuality.high,
                        memCacheHeight: cacheMaxHeightImage,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 100),
                        placeholder:
                            (BuildContext context, String text) => Center(
                          child: ShimmerView(
                            padding: AppSpacer(context: context)
                                .edgeInsets
                                .all
                                .none,
                            play: true,
                            child: Container(
                              color: kAppWhite,
                            ),
                          ),
                        ),
                      )
                          : Image.network(
                        widget.image,
                        fit: widget.imageFit,
                      ),
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
                  ShadowStrokeStyles(
                    shadowStrokeType: ShadowStrokeType.lowShadow,
                    padding: _imagePadding,
                    color: widget.iconBackgroundColor,
                    radius: kSpacer.sm,
                    child: Container(
                      width: widget.imageBackgroundSize ?? kSpacer.xxl,
                      height: widget.imageBackgroundSize ?? kSpacer.xxl,
                    ),
                  ),
                  Icon(
                    widget.icon,
                    size: widget.iconSize ?? kSpacer.sm,
                    color: kAppBlack,
                  ),
                ],
              ),
            )
          else if (widget.picture != null)
              Padding(
                padding: kSpacer.edgeInsets.right.sm,
                child: widget.picture,
              ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.title,
                  style: AppTextStyle(color: kAppBlack).primaryH4,
                ),
                SizedBox(
                  height: kSpacer.xxs,
                ),
                Text(
                  widget.description,
                  style: AppTextStyle(color: kAppGreyB).primaryLabel4,
                  maxLines: widget.descriptionMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (widget.frontInfoText != null)
                    Text(
                      widget.frontInfoText,
                      style: AppTextStyle(color: widget.frontInfoTextColor)
                          .primaryLabel4,
                    ),
                  if (widget.frontInfoText != null &&
                      widget.frontInfoIcon != null)
                    SizedBox(
                      width: kSpacer.sm,
                    ),
                  if (widget.frontInfoIcon != null)
                    Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        Icon(
                          widget.frontInfoIcon,
                          color: widget.frontInfoIconColor,
                          size: widget.frontInfoIconSize,
                        ),
                      ],
                    ),
                ],
              ),
              GestureDetector(
                onTapUp: widget.onFrontIconAction,
                child: Container(
                  color: kAppClearWhite,
                  width: 44.0,
                  height: 44.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
