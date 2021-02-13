import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_animations.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

/// NOTE : Please try to create a class from [basic_button.dart]
/// and not directly change this class
class BasicButton extends StatefulWidget {
  /// this is the main class of the button
  /// all button is made of this class
  /// [onPressed] are required
  /// [leadingIcon] & [title] are optional so we can build a button
  /// with/only/without [leadingIcon] or with/only/without [text] or with/only/without [leadingImage]
  /// but we SHOULD choose one of [leadingIcon] & [title] & [leadingImage]

  const BasicButton({
    @required this.onPressed,
    this.title,
    this.titleReplacement,
    this.leadingIcon,
    this.widgetTheme = WidgetTheme.primaryWhite,
    this.shadowStrokeType,
    this.padding,
    this.textStyle,
    this.radius,
    this.fullWidth = false,
    this.margin,
    this.border,
    this.trailingIcon,
  });

  /// required
  final VoidCallback onPressed;

  /// one of them (at least) should NOT NULL
  final String title;
  final Widget titleReplacement;
  final IconData leadingIcon;
  final IconData trailingIcon;

  /// recommended
  final WidgetTheme widgetTheme;
  final ShadowStrokeType shadowStrokeType;
  final EdgeInsets padding;

  /// optional
  final TextStyle textStyle;
  final BoxBorder border;
  final double radius;

  /// this [fullWidth] is to change button to full width or not
  final bool fullWidth;

  final EdgeInsets margin;

  @override
  _BasicButtonState createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton>
    with TickerProviderStateMixin {
  /// for icons
  Color get _iconColor => widget.widgetTheme.textColor;

  /// for shadow/stroke type
  ShadowStrokeType get _shadowStrokeType =>
      widget.shadowStrokeType ?? widget.widgetTheme.shadowStrokeType;

  /// for background color
  Color get _backgroundColor => widget.widgetTheme.backgroundColor;

  /// for text style
  TextStyle get _textStyle =>
      widget.textStyle ??
      AppTextStyle(color: widget.widgetTheme.textColor, context: context)
          .primaryB2;

  /// for radius (no radius means auto-rounded the button)
  double get _radius => widget.radius ?? kBorderRadiusTiny;

  /// for padding
  EdgeInsets get _padding {
    if (_shadowStrokeType == ShadowStrokeType.stroke2px) {
      return const EdgeInsets.symmetric(
        vertical: kDefaultMargin - 2,
        horizontal: kDefaultMargin - 2,
      );
    } else if (_shadowStrokeType == ShadowStrokeType.stroke1px) {
      return const EdgeInsets.symmetric(
        vertical: kDefaultMargin - 1,
        horizontal: kDefaultMargin - 1,
      );
    } else {
      return AppSpacer(context: context).edgeInsets.all.standard;
    }
  }

  EdgeInsets get _margin => widget.margin;

  /// Animating the On Pressed in the button
  AnimationController _animationController;
  AnimationController _disabledAnimationController;
  Animation<double> _animation;
  Animation<double> _disabledAnimation;
  Animation<Color> _colorAnimation;
  Animation<double> _opacityAnimation;
  Tween<double> _tween;
  ColorTween _colorTween;
  Tween<double> _opacityTween;
  bool _enableAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: kDuration200,
      vsync: this,
    );

    /// size animation
    _tween = Tween<double>(
      begin: kExtentPoint1,
      end: kExtentZeroPoint9,
    );
    _animation = _tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: kCurve,
        reverseCurve: kReverseCurve,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });

    /// disable enable size animation
    _disabledAnimationController = AnimationController(
      duration: kDuration500,
      vsync: this,
    );

    _disabledAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _disabledAnimationController,
        curve: kEaseOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _isAnimating = false;
          _disabledAnimationController.reverse();
        }
      });

    /// color animation
    _colorTween = ColorTween(
      begin: widget.widgetTheme.textColor,
      end: widget.widgetTheme.selectedTextColor,
    );

    _colorAnimation = _colorTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: kCurve,
        reverseCurve: kReverseCurve,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });

    /// double animation
    _opacityTween = Tween<double>(begin: kExtentZeroPoint0, end: kExtentPoint1);
    _opacityAnimation = _opacityTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: kCurve,
        reverseCurve: kReverseCurve,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _disabledAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets marginDefined = widget.fullWidth
        ? AppSpacer(context: context).edgeInsets.x.standard
        : kSpacer.edgeInsets.all.none;
    if (_margin != null) {
      marginDefined = _margin;
    }
    if (_backgroundColor == kAppClearWhite) {
      return GestureDetector(
        onTap: () => toggleAnimation(),
        child: Container(
          margin: marginDefined,
          child: _child,
        ),
      );
    } else {
      if (widget.onPressed == null) {
        _enableAnimation = true;
      } else if (widget.onPressed != null && _enableAnimation == true) {
        _isAnimating = true;
        _enableAnimation = false;
        _disabledAnimationController.forward();
      }
      return GestureDetector(
        onTap: () => toggleAnimation(),
        child: Transform.scale(
          scale: _isAnimating ? _disabledAnimation.value : 1.0,
          child: TransformScaleAnimation(
            animation: _animation,
            child: Container(
              margin: marginDefined,
              decoration: BoxDecoration(
                border: widget.border,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    widget.radius ?? AppQuery(context).radius,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _child,
                  Positioned.fill(
                    child: FadeAnimation(
                      animation: _opacityAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kAppBlack.withOpacity(0.05),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              /// auto-rounded the button
                              widget.radius ?? AppQuery(context).radius,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void toggleAnimation() {
    if (widget.onPressed != null) {
      widget.onPressed();
    }
    _animationController.forward();
  }

  Widget get _child {
    return ShadowStrokeStyles(
        shadowStrokeType: _shadowStrokeType,
        radius: _radius,
        padding: widget.padding ?? _padding,
        color: widget.onPressed != null
            ? _backgroundColor
            : widget.widgetTheme.disabledBackgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: _content,
        ));
  }

  List<Widget> get _content {
    return <Widget>[
      if (widget.leadingIcon != null)
        Icon(
          widget.leadingIcon,
          color: _iconColor,
        ),
      if (widget.titleReplacement != null)
        widget.titleReplacement
      else if (widget.title != null)
        Padding(
          padding: widget.leadingIcon == null
              ? kSpacer.edgeInsets.left.none
              : kSpacer.edgeInsets.left.xs,
          child: TextColorAnimation(
            text: widget.title,
            textStyle: _textStyle,
            animation: _colorAnimation,
          ),
        )
      else if (widget.title != null)
        Flexible(
          child: Padding(
            padding: widget.leadingIcon == null
                ? kSpacer.edgeInsets.left.none
                : kSpacer.edgeInsets.left.xs,
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _textStyle,
            ),
          ),
        ),
    ];
  }
}
