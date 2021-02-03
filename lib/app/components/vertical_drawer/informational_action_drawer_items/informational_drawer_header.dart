import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class InfoDrawerHeader extends StatelessWidget {
  const InfoDrawerHeader({
    this.title,
    this.textAlignment = TextAlign.left,
  });

  final String title;
  final TextAlign textAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kSpacer.edgeInsets.all.standard,
      child: Text(
        title,
        textAlign: textAlignment,
        style: AppTextStyle(color: kAppBlack, context: context).primaryH2,
      ),
    );
  }
}
