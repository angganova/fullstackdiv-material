import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fullstackdiv_material/app/screens/web_view/chrome_safari_browser.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlView extends StatelessWidget {
  const HtmlView({
    @required this.data,
    this.textStyle,
    this.textMargin,
    this.onLinkTap,
  });

  final String data;
  final TextStyle textStyle;
  final EdgeInsets textMargin;
  final Function(String) onLinkTap;
  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyle =
        textStyle ?? AppTextStyle(color: kAppBlack).primaryP2;
    return Html(
      data: data,
      style: <String, Style>{
        'body': Style(margin: kSpacer.edgeInsets.all.none),
        'p': Style(
          fontSize: FontSize(_textStyle.fontSize),
          fontFamily: _textStyle.fontFamily,
          letterSpacing: _textStyle.letterSpacing,
          color: _textStyle.color,
          fontWeight: _textStyle.fontWeight,
          fontStyle: _textStyle.fontStyle,
          margin: textMargin ??
              EdgeInsets.only(
                top: kSpacer.none,
                bottom: kSpacer.xs,
              ),
        ),
      },
      onLinkTap: onLinkTap ??
          (String url) {
            _launchURL(url);
          },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await MyChromeSafariBrowser(browserFallback: InAppBrowser()).open(
        url: url,
        options: ChromeSafariBrowserClassOptions(
          android: AndroidChromeCustomTabsOptions(
              addDefaultShareMenuItem: false, keepAliveEnabled: true),
          ios: IOSSafariOptions(
            dismissButtonStyle: IOSSafariDismissButtonStyle.DONE,
            presentationStyle: IOSUIModalPresentationStyle.OVER_FULL_SCREEN,
          ),
        ),
      );
    }
  }
}
