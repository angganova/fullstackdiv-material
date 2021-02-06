import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class SearchListHeader extends StatelessWidget {
  const SearchListHeader({
    @required this.searchHint,
    @required this.onTextFieldTap,
  });

  ///required
  final String searchHint;

  ///optional
  final VoidCallback onTextFieldTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: kSpacer.standard,
            right: kSpacer.standard,
            bottom: AppSpacer(context: context).standard,
          ),
          child: TextField(
            style: AppTextStyle(color: kAppGreyB).primaryPL,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kAppGreyC,
                  width: 2.0,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kAppGreyC,
                  width: 2.0,
                ),
              ),
              hintText: searchHint,
              suffixIcon: Padding(
                padding: kSpacer.edgeInsets.left.md,
                child: const Icon(
                  Icons.search,
                  size: kSmallIconSize,
                  color: kAppGreyB,
                ),
              ),
            ),
            readOnly: true,
            onTap: onTextFieldTap,
          ),
        ),
      ],
    );
  }
}
