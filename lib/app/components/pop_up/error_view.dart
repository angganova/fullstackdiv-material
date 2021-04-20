import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/image/asset_image.dart';
import 'package:fullstackdiv_material/app/components/image/cached_image.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(
      {Key key,
      this.retryCallback,
      this.cancelCallback,
      this.imageUrl,
      this.imageAsset,
      this.text,
      this.retryText,
      this.cancelText})
      : super(key: key);
  final String imageUrl;
  final String imageAsset;
  final String text;
  final String retryText;
  final VoidCallback retryCallback;
  final String cancelText;
  final VoidCallback cancelCallback;
  @override
  Widget build(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    final AppQuery _appQuery = AppQuery(context);
    final AppTextStyle _appTextStyle = AppTextStyle(context: context);
    final double _assetImageWidth = _appQuery.width * 0.8;

    return Material(
      color: kAppWhite,
      child: Container(
        width: _appQuery.width,
        height: _appQuery.height,
        padding: _appSpacer.edgeInsets.all.sm,
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            if (imageAsset != null)
              AppAssetImage(
                url: imageAsset,
                width: _assetImageWidth,
                fit: BoxFit.contain,
              )
            else if (imageUrl != null)
              AppCachedImage(
                url: imageAsset,
                width: _assetImageWidth,
                fit: BoxFit.contain,
              )
            else
              Container(),
            _appSpacer.vHsm,
            Expanded(child: Container()),
            Text(
              text ?? '',
              style: _appTextStyle.primaryH3,
              textAlign: TextAlign.center,
            ),
            _appSpacer.vHsm,
            WideButton(
              title: retryText ?? 'Retry',
              textStyle: _appTextStyle.primaryB1,
              onPressed: () {
                if (retryCallback != null) {
                  retryCallback();
                }
                Navigator.pop(context);
              },
            ),
            _appSpacer.vHsm,
            WideButton(
              title: cancelText ?? 'Cancel',
              widgetTheme: WidgetTheme.whitePrimary,
              textStyle: _appTextStyle.primaryB1,
              onPressed: () {
                if (cancelCallback != null) {
                  cancelCallback();
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
