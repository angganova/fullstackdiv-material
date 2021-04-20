import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';


class AppLoadingView extends StatefulWidget {
  const AppLoadingView(
      {Key key,
      @required this.isLoading,
      this.center = true,
      this.color = kAppPrimaryColor})
      : super(key: key);
  final bool isLoading;
  final bool center;
  final Color color;
  @override
  _AppLoadingViewState createState() => _AppLoadingViewState();
}

class _AppLoadingViewState extends State<AppLoadingView> {
  @override
  Widget build(BuildContext context) {
    final Widget _loadingView = AnimatedOpacity(
      opacity: widget.isLoading ? 1 : 0,
      duration: kDuration500,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      ),
    );

    if (widget.center) {
      return Center(
        child: _loadingView,
      );
    } else {
      return _loadingView;
    }
  }
}
