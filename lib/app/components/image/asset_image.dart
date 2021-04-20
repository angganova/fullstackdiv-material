import 'package:flutter/cupertino.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/variables/image_string.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
      {Key key,
      this.borderRadius,
      this.url,
      this.fit,
      this.width,
      this.height,
      this.color,
      this.alignment})
      : super(key: key);
  final BorderRadius borderRadius;
  final String url;
  final BoxFit fit;
  final double width;
  final double height;
  final Color color;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? AppRadius.createCircularRadius(0),
      child: Image.asset(
        url ?? vLogoAppBg,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        color: color,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }
}
