import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/slider/slider_thumb_shape.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class BasicSlider extends StatefulWidget {
  const BasicSlider(
      {this.minValue = 0.0,
      this.maxValue = 1.0,
      this.currentValue,
      this.unit = 'km',
      this.onChanged,
      this.activeTrackColor = kAppPrimaryElectricBlue,
      this.inactiveTrackColor = kAppGreyD,
      this.textColor = kAppPrimaryElectricBlue,
      this.circleColor = kAppPrimaryElectricBlue});

  final double minValue;
  final double maxValue;
  final double currentValue;
  final String unit;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color textColor;
  final Color circleColor;
  final ValueChanged<double> onChanged;

  @override
  _BasicSliderState createState() => _BasicSliderState();
}

class _BasicSliderState extends State<BasicSlider> {
  double _currentValue;

  @override
  void initState() {
    _currentValue = widget.currentValue ?? widget.minValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: widget.activeTrackColor,
        inactiveTrackColor: widget.inactiveTrackColor,
        trackHeight: 2.0,
        thumbShape: SliderThumbShape(
            min: widget.minValue,
            max: widget.maxValue,
            unit: widget.unit,
            textColor: widget.textColor,
            circleColor: widget.circleColor),
        overlayColor: kAppTransparent,
      ),
      child: Slider(
        min: widget.minValue,
        max: widget.maxValue,
        value: _currentValue,
        onChanged: (double value) {
          setState(() {
            _currentValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged(_currentValue);
          }
        },
      ),
    );
  }
}
