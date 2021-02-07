import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
import 'package:fullstackdiv_material/app/components/shimmer/list_view_shimmer.dart';

class BasicListViewShimmerPage extends StatelessWidget {
  /// this is the example of page with [ListViewShimmer]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BasicHeader(
              title: 'List View Shimmer',
              onBackButtonTapped: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(
              child: ListViewShimmer(),
            ),
          ],
        ),
      ),
    );
  }
}
