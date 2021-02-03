import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/slider/basic_slider.dart';

class DemoBasicSliderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'Basic Slider',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            BasicSlider(
              currentValue: 4,
              maxValue: 20,
              minValue: 0,
              onChanged: (double value) {
                print('value ${value.round().toString()}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
