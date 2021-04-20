import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/app/components/image/asset_image.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class SSOErrorView extends StatelessWidget {
  const SSOErrorView({Key key, this.submitCallback}) : super(key: key);
  final VoidCallback submitCallback;
  @override
  Widget build(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    final AppQuery _appQuery = AppQuery(context);
    final AppTextStyle _appTextStyle = AppTextStyle(context: context);

    return Material(
      color: kAppWhite,
      child: Container(
        width: _appQuery.width,
        height: _appQuery.height,
        padding: _appSpacer.edgeInsets.all.sm,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(child: Container()),
              AppAssetImage(
                url: 'assets/images/logo_device_security.png',
                width: _appQuery.width * 0.8,
                fit: BoxFit.contain,
                color: kAppPrimaryColor,
              ),
              Expanded(child: Container()),
              Text(
                'This account already logged in another device, '
                'please login again',
                style: _appTextStyle.primaryH3,
                textAlign: TextAlign.center,
              ),
              _appSpacer.vHsm,
              WideButton(
                title: 'Ok',
                textStyle: _appTextStyle.primaryB1,
                onPressed: () {
                  if (submitCallback != null) {
                    submitCallback();
                  }
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
