import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/just_text_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// this is the [Function] to show [BasicSnackBar]
class SnackBarPopUp {
  static void sInformationSnackBar(
      {@required BuildContext context,
      @required String text,
      IconData icon = Icons.info_outline_rounded,
      WidgetTheme widgetTheme = WidgetTheme.yellowBlack,
      Duration duration = kDuration5s}) {
    sBasicSnackBar(
        context: context,
        text: text,
        icon: icon,
        widgetTheme: widgetTheme,
        duration: duration);
  }

  static void sWarningSnackBar(
      {@required BuildContext context,
      @required String text,
      IconData icon = Icons.warning_amber_outlined,
      WidgetTheme widgetTheme = WidgetTheme.yellowBlack,
      Duration duration = kDuration5s}) {
    sBasicSnackBar(
        context: context,
        text: text,
        icon: icon,
        widgetTheme: widgetTheme,
        duration: duration);
  }

  static void sErrorSnackBar(
      {@required BuildContext context,
      @required String text,
      IconData icon = Icons.error_outline,
      WidgetTheme widgetTheme = WidgetTheme.redWhite,
      Duration duration = kDuration5s}) {
    sBasicSnackBar(
        context: context,
        text: text,
        icon: icon,
        widgetTheme: widgetTheme,
        duration: duration);
  }

  static void sBasicSnackBar({
    @required BuildContext context,
    String text,
    WidgetTheme widgetTheme = WidgetTheme.yellowBlack,
    String assetImageName,
    String networkImageUrl,
    IconData icon,
    double iconSize,
    Color backgroundColor,
    Color textColor,
    Duration duration,
    VoidCallback action,
    String trailingText,
    String trailingSubtitle,
    String trailingActionName,
    Color trailingActionColor,
    VoidCallback trailingAction,
    EdgeInsets padding,
    double radius = kBorderRadiusSmall,
    VoidCallback onClose,
  }) {
    /// declare basic snack bar view
    final BasicSnackBarView _snackBarView = BasicSnackBarView(
      text: text,
      widgetTheme: widgetTheme,
      assetImageName: assetImageName,
      icon: icon,
      iconSize: iconSize,
      backgroundColor: backgroundColor,
      textColor: textColor,
      action: action,
      trailingText: trailingText,
      trailingSubtitle: trailingSubtitle,
      trailingActionName: trailingActionName,
      trailingActionColor: trailingActionColor,
      trailingAction: trailingAction,
      duration: duration ?? kDuration5s,
      padding: padding,
      radius: radius,
      onClose: onClose,
    );

    /// show Snack Bar view
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? kDuration5s,
        elevation: 0.0,
        backgroundColor: kAppClearWhite,
        content: _snackBarView,
      ),
    );
  }
}

/// this is the [BasicSnackBar] view
/// which called by [sBasicSnackBar]
class BasicSnackBarView extends StatefulWidget {
  const BasicSnackBarView({
    @required this.text,
    this.widgetTheme = WidgetTheme.yellowBlack,
    this.assetImageName,
    this.icon,
    this.iconSize,
    this.backgroundColor,
    this.textColor,
    this.action,
    this.trailingText,
    this.trailingSubtitle,
    this.trailingActionName,
    this.trailingActionColor,
    this.trailingAction,
    this.duration,
    this.animation,
    this.padding,
    this.radius = kBorderRadiusSmall,
    this.onClose,
  });

  /// required
  final String text;

  /// recommended
  final WidgetTheme widgetTheme;

  /// optional
  final String assetImageName;
  final IconData icon;
  final double iconSize;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback action;
  final String trailingText;
  final String trailingSubtitle;
  final String trailingActionName;
  final Color trailingActionColor;
  final VoidCallback trailingAction;
  final Duration duration;
  final Animation<double> animation;
  final EdgeInsets padding;
  final double radius;
  final VoidCallback onClose;

  @override
  _BasicSnackBarViewState createState() => _BasicSnackBarViewState();
}

class _BasicSnackBarViewState extends State<BasicSnackBarView>
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
        end: (widget.assetImageName != null)
            ? kSpacer.md
            : (widget.iconSize ?? kSpacer.sm));

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
      _trailingPosAnimationController.forward();
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
    return WillPopScope(
      onWillPop: () async {
        widget.onClose?.call();
        return Future<bool>.value(true);
      },
      child: Padding(
        padding: AppQuery(context).notchNotNull
            ? const EdgeInsets.only(bottom: 11.0)
            : kSpacer.edgeInsets.all.none,
        child: InkWell(
          onTap: () {
            _sizeAnimationController.reverse();
            Future<dynamic>.delayed(kDuration500, () {
              Scaffold.of(context).hideCurrentSnackBar();
            });
            widget.action();
          },
          child: Transform.scale(
            scale: _sizeAnimation.value,
            child: ShadowStrokeStyles(
              color:
                  widget.backgroundColor ?? widget.widgetTheme.backgroundColor,
              shadowStrokeType: ((widget.backgroundColor ??
                          widget.widgetTheme.backgroundColor) ==
                      kAppWhite)
                  ? ShadowStrokeType.medShadow
                  : ShadowStrokeType.none,
              radius: widget.radius,
              padding: widget.padding ??
                  EdgeInsets.fromLTRB(
                    kSpacer.sm,
                    14.0,
                    kSpacer.sm,
                    14.0,
                  ),
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
                        size: _imageSizeAnimation.value,
                        color: widget.widgetTheme.textColor,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      widget.text,
                      style: AppTextStyle(
                              color: widget.textColor ??
                                  widget.widgetTheme.textColor)
                          .primaryLabel2,
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
                                    color: (widget.textColor ??
                                            widget.widgetTheme.textColor)
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
                                    color: widget.textColor ??
                                        widget.widgetTheme.textColor)
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
                                  color: widget.textColor ??
                                      widget.widgetTheme.textColor)
                              .primaryLabel1,
                        ),
                      ),
                    ),
                  if (widget.trailingActionName != null &&
                      widget.trailingAction != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: SizedBox(
                        height: _trailingPosAnimation.value,
                        child: JustTextButton(
                          title: widget.trailingActionName,
                          onPressed: () {
                            _sizeAnimationController.reverse();
                            Future<dynamic>.delayed(kDuration500, () {
                              Scaffold.of(context).hideCurrentSnackBar();
                            });
                            widget.trailingAction();
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
                        size: kSmallIconSize,
                        color: widget.textColor ?? widget.widgetTheme.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
