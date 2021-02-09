import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/deeplink/deeplink_service.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/routes/map_routes.gr.dart';
import 'package:uni_links/uni_links.dart';

class FsdApp extends StatefulWidget {
  @override
  _FsdApp createState() => _FsdApp();
}

class _FsdApp extends State<FsdApp> with WidgetsBindingObserver {
  final DynamicLinkService _dynamicLinkService = getIt<DynamicLinkService>();
  StreamSubscription<String> _sub;
  bool initialLinkCalled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(seconds: 3)).then((_) {
        _dynamicLinkService
            .getUniLinkInitial(context)
            .then((_) => initialLinkCalled = true);
      });

      _sub = getLinksStream().listen((String uri) {
        _dynamicLinkService.goToDeepLink(Uri.parse(uri));
      });
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (Platform.isIOS || !initialLinkCalled) {
        // _dynamicLinkService
        //     .getUniLinkInitial(context)
        //     .then((_) => initialLinkCalled = true);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fullstackdiv',
      theme: themeLight(),
      builder: ExtendedNavigator.builder(
        router: AppRouter(),
        initialRoute: Routes.splashView,
        builder: (BuildContext context, Widget child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: child,
          );
        },
      ),
    );
  }
}
