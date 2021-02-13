import 'package:flutter/material.dart';

import 'media_query.dart';

///
/// Created computed spacing values for padding and margin.
///
/// 1. To create general spacing in [EdgeInsets], use
///   `kSpacer.edgeInsets.[side].[size]`
///
///     * Single-Side EdgeInsets: `kSpacer.edgeInsets.bottom.xxs`
///         = `EdgeInsets.only(bottom: 4.0)`
///
///     * Horizontal EdgeInsets: `kSpacer.edgeInsets.x.xs`
///         = `EdgeInsets.symmetric(horizontal: 8.0)`
///
///     * Vertical EdgeInsets: `kSpacer.edgeInsets.y.sm`
///         = `EdgeInsets.symmetric(vertical: 16.0)`
///
///     * All-Side EdgeInsets: `kSpacer.edgeInsets.all.xl`
///         = `EdgeInsets.all(48.0)`
///
/// 2. To create symmetric spacing in [EdgeInsets], use
///   `kSpacer.edgeInsets.symmetric(x: [size], y: [size])`
///
///     * `kSpacer.edgeInsets.symmetric(x: 'md', y: 'lg')`
///         = `EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0)`
///
/// 3. To create only-side spacing in [EdgeInsets], use
///   `kSpacer.edgeInsets.only([side]: [size], [side]: [size])`
///
///     * `kSpacer.edgeInsets.only(left: 'md', bottom: 'lg')`
///         = `EdgeInsets.only(left: 32.0, bottom: 40.0)`
///
/// 4. To create spacing in [double], use `kSpacer.[size]`
///
///     * double value: `kSpacer.xxl`
///         = 56.0
///
/// Available Options:
/// [side] : [left], [right], [top], [bottom], [x]=horizontal, [y]=vertical
/// [size] : [none]=0, [xxs]=4, [xs]=8, [sm]=16, [md]=32, [lg]=40
/// [xl]=48, [xxl]=56, [standard]=24

///
/// Global grid spacer unit value
double kGridSpacer = 4.0;

///
/// This injects the grid spacer value to [Dimensions]
AppSpacer kSpacer = AppSpacer();

///
/// This helps in getting the factor for each of the specification
///
/// this gets to [none] = *0, [xxs] = *1, etc.
const Map<String, double> _Helper = <String, double>{
  'none': 0,
  'xxs': 1,
  'xs': 2,
  'sm': 4,
  'md': 8,
  'lg': 10,
  'xl': 12,
  'xxl': 14,
  'standard': 6,
};

///
/// This is the global dimensions class
///
/// with functions to compute spacing in [EdgeInsets] and [double].
class AppSpacer {
  AppSpacer({this.spacerValue, this.context}) {
    textScaleFactor = 1.0;
    spacerValue ??= kGridSpacer;
    if (context != null) {
      final AppQuery _query = AppQuery(context);
      if (_query.isSmallDevice) {
        textScaleFactor = 0.5;
      } else if (!_query.isLargeDevice) {
        textScaleFactor = 0.85;
      }
    }
    edgeInsets = DimensionEdgeInsets(spacerValue * textScaleFactor);
  }

  final BuildContext context;

  double spacerValue;
  DimensionEdgeInsets edgeInsets;
  double textScaleFactor;

  /// value: 24
  double get standard => spacerValue * 6 * textScaleFactor;

  /// value: 0
  double get none => spacerValue * _Helper['none'] * textScaleFactor;

  /// value: 4
  double get xxs => spacerValue * _Helper['xxs'] * textScaleFactor;

  /// value: 8
  double get xs => spacerValue * _Helper['xs'] * textScaleFactor;

  /// value: 16
  double get sm => spacerValue * _Helper['sm'] * textScaleFactor;

  /// value: 32
  double get md => spacerValue * _Helper['md'] * textScaleFactor;

  /// value: 40
  double get lg => spacerValue * _Helper['lg'] * textScaleFactor;

  /// value: 48
  double get xl => spacerValue * _Helper['xl'] * textScaleFactor;

  /// value: 56
  double get xxl => spacerValue * _Helper['xxl'] * textScaleFactor;

  Widget get vNone => Container();
  Widget get vHStandard => Container(height: standard);
  Widget get vHxxs => Container(height: xxs);
  Widget get vHxs => Container(height: xs);
  Widget get vHsm => Container(height: sm);
  Widget get vHmd => Container(height: md);
  Widget get vHlg => Container(height: lg);
  Widget get vHxl => Container(height: xl);
  Widget get vHxxl => Container(height: xxl);

  Widget get vWStandard => Container(width: standard);
  Widget get vWxxs => Container(width: xxs);
  Widget get vWxs => Container(width: xs);
  Widget get vWsm => Container(width: sm);
  Widget get vWmd => Container(width: md);
  Widget get vWlg => Container(width: lg);
  Widget get vWxl => Container(width: xl);
  Widget get vWxxl => Container(width: xxl);
}

///
/// Customized EdgeInsets class
///
/// which includes manipulation of the sides
/// [left], [right], [top], [bottom]
/// [x] - left & right, [y] - top & bottom
/// [all] - left, right, top & bottom
class DimensionEdgeInsets {
  DimensionEdgeInsets(this.spacerValue) {
    _left = DimensionSide(spacerValue, SidesFlag(1, 0, 0, 0));
    _top = DimensionSide(spacerValue, SidesFlag(0, 1, 0, 0));
    _right = DimensionSide(spacerValue, SidesFlag(0, 0, 1, 0));
    _bottom = DimensionSide(spacerValue, SidesFlag(0, 0, 0, 1));
    _x = DimensionSide(spacerValue, SidesFlag(1, 0, 1, 0));
    _y = DimensionSide(spacerValue, SidesFlag(0, 1, 0, 1));
    _all = DimensionSide(spacerValue, SidesFlag(1, 1, 1, 1));
  }

  final double spacerValue;
  DimensionSide _left;
  DimensionSide _top;
  DimensionSide _right;
  DimensionSide _bottom;
  DimensionSide _x;
  DimensionSide _y;
  DimensionSide _all;

  DimensionSide get left => _left;

  DimensionSide get top => _top;

  DimensionSide get right => _right;

  DimensionSide get bottom => _bottom;

  DimensionSide get x => _x;

  DimensionSide get y => _y;

  DimensionSide get all => _all;

  EdgeInsets symmetric({String x, String y}) {
    validateHelperKey(x);
    validateHelperKey(y);
    return DimensionSize(
      spacerValue,
      SidesFlag(1, 1, 1, 1),
      x == null ? _Helper['none'] : _Helper[x],
      y == null ? _Helper['none'] : _Helper[y],
      x == null ? _Helper['none'] : _Helper[x],
      y == null ? _Helper['none'] : _Helper[y],
    ).data;
  }

  EdgeInsets only({String left, String top, String right, String bottom}) {
    validateHelperKey(left);
    validateHelperKey(top);
    validateHelperKey(right);
    validateHelperKey(bottom);

    return DimensionSize(
      spacerValue,
      SidesFlag(
        left == null ? 0 : 1,
        top == null ? 0 : 1,
        right == null ? 0 : 1,
        bottom == null ? 0 : 1,
      ),
      left == null ? _Helper['none'] : _Helper[left],
      top == null ? _Helper['none'] : _Helper[top],
      right == null ? _Helper['none'] : _Helper[right],
      bottom == null ? _Helper['none'] : _Helper[bottom],
    ).data;
  }

  void validateHelperKey(String keyName) {
    if (keyName != null && !_Helper.containsKey(keyName)) {
      throw 'Size name "$keyName" is not in the list. Check _Helper class.';
    }
  }
}

///
/// This gets us the actual side and manipulate it according to the size
///
/// this gets to
/// [spacer] - grid spacer value,
/// [sidesFlag] - left, right, top & bottom (all 4)
class DimensionSide {
  DimensionSide(this.spacer, this.sidesFlag);

  double spacer;
  SidesFlag sidesFlag;

  /// value: 0
  EdgeInsets get none {
    return DimensionSize(spacer, sidesFlag, _Helper['none']).data;
  }

  /// value: 4
  EdgeInsets get xxs {
    return DimensionSize(spacer, sidesFlag, _Helper['xxs']).data;
  }

  /// value: 8
  EdgeInsets get xs {
    return DimensionSize(spacer, sidesFlag, _Helper['xs']).data;
  }

  /// value: 16
  EdgeInsets get sm {
    return DimensionSize(spacer, sidesFlag, _Helper['sm']).data;
  }

  /// value: 24
  EdgeInsets get standard {
    return DimensionSize(spacer, sidesFlag, _Helper['standard']).data;
  }

  /// value: 32
  EdgeInsets get md {
    return DimensionSize(spacer, sidesFlag, _Helper['md']).data;
  }

  /// value: 40
  EdgeInsets get lg {
    return DimensionSize(spacer, sidesFlag, _Helper['lg']).data;
  }

  /// value: 48
  EdgeInsets get xl {
    return DimensionSize(spacer, sidesFlag, _Helper['xl']).data;
  }

  /// value: 56
  EdgeInsets get xxl {
    return DimensionSize(spacer, sidesFlag, _Helper['xxl']).data;
  }
}

///
/// This actually does the calculation according to the spacer, sides & factor
///
/// this gets to
/// [spacer] - grid spacer value,
/// [sidesFlag] - left, right, top & bottom (all 4)
/// [factor] - none, xxs, xs, sm, md, lg, xl, xxl (Helper class)
class DimensionSize {
  DimensionSize(this.spacer, this.sidesFlag, this.factorL,
      [this.factorT, this.factorR, this.factorB]) {
    factorT ??= factorL;
    factorR ??= factorL;
    factorB ??= factorL;
  }

  double spacer;
  SidesFlag sidesFlag;
  double factorL; // Left side
  double factorT; // Top side
  double factorR; // Right side
  double factorB; // Bottom side

  EdgeInsets get data => EdgeInsets.fromLTRB(
        sidesFlag.leftFlag * spacer * factorL,
        sidesFlag.topFlag * spacer * factorT,
        sidesFlag.rightFlag * spacer * factorR,
        sidesFlag.bottomFlag * spacer * factorB,
      );
}

///
/// This sets the value of the sides
///
/// this includes:
/// [left], [right], [top] & [bottom]
class SidesFlag {
  SidesFlag(this.leftFlag, this.topFlag, this.rightFlag, this.bottomFlag);

  double leftFlag = 0;
  double topFlag = 0;
  double rightFlag = 0;
  double bottomFlag = 0;
}
