import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/image/asset_image.dart';
import 'package:fullstackdiv_material/app/components/loader/app_loader.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/variables/image_string.dart';

class AppCachedImage extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final double radius;
  final BoxFit fit;
  final Color color;
  final BlendMode blendMode;
  final bool showLoading;
  final bool roundShape;
  final Alignment alignment;
  final Widget errorWidget;
  final bool showErrorImage;

  const AppCachedImage(
      {Key key,
      this.url,
      this.width,
      this.height,
      this.radius,
      this.fit,
      this.color,
      this.blendMode,
      this.showLoading = true,
      this.roundShape = false,
      this.alignment = Alignment.center,
      this.errorWidget,
        this.showErrorImage = true})
      : super(key: key);

  @override
  _AppCachedImageState createState() => _AppCachedImageState();
}

class _AppCachedImageState extends State<AppCachedImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.roundShape) {
      return ClipOval(
        child: cachedImageView,
      );
    } else {
      return ClipRRect(
        borderRadius:
            AppRadius.createCircularRadius(widget.radius ?? kBorderRadiusTiny),
        child: cachedImageView,
      );
    }
  }

  Widget get cachedImageView {
    return CachedNetworkImage(
      imageUrl: widget.url,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      fit: widget.fit ?? BoxFit.cover,
      colorBlendMode: widget.blendMode,
      alignment: widget.alignment,
      errorWidget: (BuildContext context, String url, dynamic error) {
        debugPrint('XXX can\'t load url, due to error : $error');
        if(widget.showErrorImage) {
          return widget.errorWidget ?? defaultErrorWidget;
        }else{
          return Container();
        }
      },
      placeholder: widget.showLoading
          ? (BuildContext context, String url) => Container(
                width: widget.width,
                height: widget.height,
                padding: AppSpacer(context: context).edgeInsets.all.xs,
                child: const AppLoadingView(
                  isLoading: true,
                ),
              )
          : null,
    );
  }

  Widget get defaultErrorWidget => ClipRRect(
      borderRadius:
          AppRadius.createCircularRadius(widget.radius ?? kBorderRadiusTiny),
      child: AppAssetImage(
        url: vLogoAppBg,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      ));
}
