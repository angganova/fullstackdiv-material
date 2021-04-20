import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/data/api/repository/api_repository.dart';
import 'package:fullstackdiv_material/data/api/response/global_response.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_state.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:fullstackdiv_material/system/routes/map_routes.gr.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final ApiRepository _apiRepository = getIt<ApiRepository>();

  ApiCallState _apiStateGetVersion = ApiCallState.stateEmpty;
  Timer _ignoreTimer;

  AppQuery _appQuery;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    _ignoreTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appQuery ??= AppQuery(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kAppClearWhite,
    ));

    return Scaffold(
      backgroundColor: kAppPrimaryColor,
      body: Container(
        width: _appQuery.width,
        height: _appQuery.height,
        child: Image.asset('assets/images/splash_cover.jpg'),
      ),
    );
  }

  Future<void> _getDirection() async {
    if (context == null) {
      /// Widget disposed already
      _ignoreTimer?.cancel();
      return;
    } else if (_apiStateGetVersion != ApiCallState.stateResulted) {
      /// Wait for the config api call to be done
      return;
    } else {
      /// Push to home view if user has session and no update needed
      _ignoreTimer?.cancel();
      ExtendedNavigator.of(context).replace(Routes.homeView);
    }
  }

  Future<void> _initPlatformState() async {
    /// Start ignore timer in case the page is freeze or stuck
    startIgnoreTimer();

    /// Check version update
    _apiRepository
        .getVersion(100)
        .then((GlobalApiResponse value) => _getDirection());

    /// Crashlytics
    Crashlytics.instance.enableInDevMode = false;

    /// Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
  }

  void startIgnoreTimer() {
    /// This to ensure that the app will go to next direction
    /// Make timer function just to skip and ignore api call and animation
    /// if the app show this page more than 5s
    /// Useful when the app stuck because of the animation error or api call
    /// error
    _ignoreTimer = Timer(kDuration5s, () {
      _apiStateGetVersion = ApiCallState.stateResulted;
      _getDirection();
    });
  }
}
