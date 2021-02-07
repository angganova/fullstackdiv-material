import 'package:flutter/material.dart';
import 'package:flutuate_mixpanel/flutuate_mixpanel.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/config/platform_info.dart';
import 'package:injectable/injectable.dart';

class MixpanelAnalytics {
  MixpanelAnalytics(this.mixpanel, this._environments) {
    _registerSuperProperty();
  }

  final MixpanelAPI mixpanel;
  final Environments _environments;

  @factoryMethod
  static Future<MixpanelAnalytics> getInstance(
      PlatformInfo info, Environments environments) async {
    final MixpanelAPI _mixpanel =
        await MixpanelAPI.getInstance(environments.getMixpanelToken);
    return MixpanelAnalytics(_mixpanel, environments);
  }

  void _registerSuperProperty() {
    final Map<String, Object> superProperties = <String, Object>{};
    superProperties['environment'] = _environments.getCurrentEnv;
    mixpanel.registerSuperProperties(superProperties);
  }

  void flush() {
    mixpanel.flush();
  }

  void trackEvent(String event, Map<String, Object> properties) {
    mixpanel.track(event, properties);
    flush();
    debugPrint('Zest Event Tracking "$event"');
    // debugPrint('Zest Event Properties "${properties.toString()}"');
    print(properties);
  }
}
