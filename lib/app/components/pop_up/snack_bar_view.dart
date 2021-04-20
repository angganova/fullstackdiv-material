import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/flat_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/styles/radius.dart';

class SnackBarView extends StatefulWidget {
  const SnackBarView({
    @required this.text,
    this.widgetTheme = WidgetTheme.yellowBlack,
    this.assetImageName,
    this.icon,
    this.onClickSnackBar,
    this.trailingText,
    this.trailingSubtitle,
    this.trailingActionName,
    this.trailingActionColor,
    this.onClickTrailing,
    this.duration,
    this.animation,
    this.padding,
    this.radius = kBorderRadiusExtraTiny,
    this.onClose,
  });

  /// required
  final String text;

  /// recommended
  final WidgetTheme widgetTheme;

  /// optional
  final String assetImageName;
  final IconData icon;
  final VoidCallback onClickSnackBar;
  final String trailingText;
  final String trailingSubtitle;
  final String trailingActionName;
  final Color trailingActionColor;
  final VoidCallback onClickTrailing;
  final Animation<double> animation;
  final EdgeInsets padding;
  final double radius;
  final VoidCallback onClose;
  final Duration duration;

  @override
  _SnackBarViewState createState() => _SnackBarViewState();
}

class _SnackBarViewState extends State<SnackBarView>
    with TickerProviderStateMixin {
  AnimationController _sizeAnimationController;
  Animation<double> _sizeAnimation;
  Tween<double> _sizeTween;
  AnimationController _imageSizeAnimationController;
  Animation<double> _imageSizeAnimation;
  Tween<double> _imageSizeTween;
  AnimationController _trailingPosAnimationController;
  Animation<double> _trailingPosAnimation;
  Tween<double> _trailingPosTween;

  @override
  void initState() {
    super.initState();

    /// Snack bar view animation
    _sizeAnimationController = AnimationController(
      duration: (_sizeAnimation != null &&
              _sizeAnimation.status == AnimationStatus.reverse)
          ? kDuration250
          : kDuration500,
      vsync: this,
    );

    _sizeTween = Tween<double>(
      begin: kExtentZeroPoint0,
      end: 1.0,
    );

    _sizeAnimation = _sizeTween.animate(
      CurvedAnimation(
        parent: _sizeAnimationController,
        curve: kEaseOut,
        reverseCurve: kEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });
    Future<dynamic>.delayed(kDuration100, () {
      _sizeAnimationController.forward();
    });

    Future<dynamic>.delayed(
        (widget.duration != null)
            ? Duration(seconds: (widget.duration.inSeconds - 1.0).toInt())
            : kDuration4s, () {
      if (mounted) {
        _sizeAnimationController.reverse();
      }
    });

    /// image animation
    _imageSizeAnimationController = AnimationController(
      duration: kDuration1s,
      vsync: this,
    );

    _imageSizeTween = Tween<double>(
        begin: kExtentZeroPoint0,
        end: widget.assetImageName != null ? kSpacer.md : kSpacer.sm);

    _imageSizeAnimation = _imageSizeTween.animate(
      CurvedAnimation(
        parent: _imageSizeAnimationController,
        curve: kSoftOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    _imageSizeAnimationController.forward();

    /// trailing items animation
    _trailingPosAnimationController = AnimationController(
      duration: kDuration500,
      vsync: this,
    );

    _trailingPosTween = Tween<double>(
        begin: 0.0,
        end: AppTextStyle(color: widget.trailingActionColor)
            .primaryLabel1
            .fontSize);

    _trailingPosAnimation = _trailingPosTween.animate(
      CurvedAnimation(
        parent: _trailingPosAnimationController,
        curve: kEaseOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    Future<dynamic>.delayed(kDuration500, () {
      _trailingPosAnimationController?.forward();
    });
  }

  @override
  void dispose() {
    _sizeAnimationController.dispose();
    _imageSizeAnimationController.dispose();
    _trailingPosAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    final AppQuery _appQuery = AppQuery(context);

    return WillPopScope(
      onWillPop: () async {
        if (widget.onClose != null) {
          widget.onClose();
        }
        return Future<bool>.value(true);
      },
      child: Transform.scale(
        scale: _sizeAnimation.value,
        child: Container(
          width: _appQuery.width,
          margin: AppQuery(context).notchNotNull
              ? const EdgeInsets.only(bottom: 11.0)
              : kSpacer.edgeInsets.all.none,
          decoration: BoxDecoration(
            color: widget.widgetTheme.backgroundColor,
            borderRadius: AppRadius.createCircularRadius(widget.radius),
          ),
          child: Material(
            color: kAppClearWhite,
            child: InkWell(
              borderRadius: AppRadius.createCircularRadius(widget.radius),
              onTap: () {
                _sizeAnimationController.reverse();
                Future<dynamic>.delayed(kDuration500, () {
                  Scaffold.of(context).hideCurrentSnackBar();
                });

                if (widget.onClickSnackBar != null) {
                  widget.onClickSnackBar();
                }
              },
              child: Padding(
                padding: _appSpacer.edgeInsets.all.sm,
                child: Row(
                  children: <Widget>[
                    if (widget.assetImageName != null)
                      Padding(
                        padding: kSpacer.edgeInsets.right.sm,
                        child: Image.asset(
                          widget.assetImageName,
                          width: _imageSizeAnimation.value,
                          height: _imageSizeAnimation.value,
                        ),
                      )
                    else if (widget.icon != null)
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          kSpacer.xs,
                          kSpacer.xs,
                          kSpacer.xs + 12,
                          kSpacer.xs,
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.widgetTheme.textColor,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        widget.text ?? '',
                        style: AppTextStyle(color: widget.widgetTheme.textColor)
                            .primaryLabel1,
                      ),
                    ),
                    if (widget.trailingText != null &&
                        widget.trailingSubtitle != null)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: _trailingPosAnimation.value,
                            child: Text(
                              widget.trailingSubtitle,
                              style: AppTextStyle(
                                      color: widget.widgetTheme.textColor
                                          .withOpacity(kExtentZeroPoint5))
                                  .primaryLabel4,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          SizedBox(
                            height: _trailingPosAnimation.value,
                            child: Text(
                              widget.trailingText,
                              style: AppTextStyle(
                                      color: widget.widgetTheme.textColor)
                                  .primaryLabel1,
                            ),
                          ),
                        ],
                      )
                    else if (widget.trailingText != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: SizedBox(
                          height: _trailingPosAnimation.value,
                          child: Text(
                            widget.trailingText,
                            textAlign: TextAlign.right,
                            style: AppTextStyle(
                                    color: widget.widgetTheme.textColor)
                                .primaryLabel1,
                          ),
                        ),
                      ),
                    if (widget.trailingActionName != null &&
                        widget.onClickTrailing != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: SizedBox(
                          height: _trailingPosAnimation.value,
                          child: AppFlatButton(
                            title: widget.trailingActionName,
                            onPressed: () {
                              _sizeAnimationController.reverse();
                              Future<dynamic>.delayed(kDuration500, () {
                                Scaffold.of(context).hideCurrentSnackBar();
                              });
                              widget.onClickTrailing();
                            },
                            padding: kSpacer.edgeInsets.all.none,
                            textStyle:
                                AppTextStyle(color: widget.trailingActionColor)
                                    .primaryLabel1,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: InkWell(
                        onTap: () {
                          _sizeAnimationController.reverse();
                          Future<dynamic>.delayed(kDuration500, () {
                            Scaffold.of(context).hideCurrentSnackBar();
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: widget.widgetTheme.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
