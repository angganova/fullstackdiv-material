import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uni_links/uni_links.dart';

@injectable
class DynamicLinkService {
  Map<String, DateTime> currentDeepLink = <String, DateTime>{};

  Future<void> retrieveDynamicLink(BuildContext context) async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      debugPrint('DynamicLinks onLink $deepLink');
    }, onError: (OnLinkErrorException e) async {
      debugPrint('DynamicLinks onError ${e.message}');
    });

    if (deepLink != null) {
      ///
    }
  }

  Future<void> getUniLinkInitial(BuildContext context) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Uri uri = await getInitialUri();
      if (uri != null) {
        goToDeepLink(uri);
      }
    } catch (e) {
      // Handle exception by warning the user their action did not succeed
      // return?
      debugPrint(e.toString());
    }
  }

  void goToDeepLink(Uri uri) {
    final Map<String, String> uriParam = uri.queryParameters;
    String deepLink;
    if (currentDeepLink[uri.toString()] != null) {
      final int timeDiff = DateTime.now().millisecondsSinceEpoch -
          currentDeepLink[uri.toString()].millisecondsSinceEpoch;
      if (timeDiff < 5000) {
        return;
      }
    }
    currentDeepLink[uri.toString()] = DateTime.now();

    if (uriParam['t'] == 'merchant') {
      deepLink = '/marketplace/merchant/${uriParam['id']}';
    } else if (uriParam['t'] == 'deal') {
      deepLink = '/discover/${uriParam['id']}';
    } else if (uriParam['t'] == 'jp') {
      if (uriParam.containsKey('address')) {}
    } else if (uriParam['t']?.toLowerCase() == 'o') {
      deepLink = '/status/${uriParam['b']}-${uriParam['n']}';
    }

    if (deepLink != null) {
    } else {}
  }
}
