import 'package:auto_route/auto_route.dart';
import 'package:fullstackdiv_material/system/analytics/mixpanel_analytics.dart';
import 'package:injectable/injectable.dart';

class DefaultAnalytics {
  DefaultAnalytics(this._analytics);

  final MixpanelAnalytics _analytics;

  @factoryMethod
  static Future<DefaultAnalytics> getInstance(
      MixpanelAnalytics analytics) async {
    return DefaultAnalytics(analytics);
  }

  void trackBookTaxi({
    @required String origin,
    @required String destination,
    @required String price,
    @required String taxiType,
    @required String priceType,
  }) {
    final Map<String, Object> properties = <String, Object>{
      'Pickup Address': origin,
      'Destination Address': destination,
      'Taxi Type': taxiType,
      'Price': price,
      'Ride Type': priceType,
    };
    _analytics.trackEvent('Book Taxi', properties);
  }

  void trackShare({
    @required String origin,
    @required String destination,
    @required String price,
    @required String taxiType,
    @required String priceType,
  }) {
    final Map<String, Object> properties = <String, Object>{
      'Pickup Address': origin,
      'Destination Address': destination,
      'Taxi Type': taxiType,
      'Price': price,
      'Ride Type': priceType,
    };
    _analytics.trackEvent('Click Taxi - Share', properties);
  }

  void trackDecidePickUpLocationPage() => _analytics.trackEvent(
      'View Taxi Choose Pickup spot page',
      <String, Object>{'Screen ID': '455.1.0.0_ZestApp_TaxiFlow'});

  void trackDecideRideAndPaymentPage() => _analytics.trackEvent(
      'View Taxi Confirm Ride Page',
      <String, Object>{'Screen ID': '455.1.2.0_ZestApp_TaxiFlow'});

  void trackChangeRidePage() => _analytics.trackEvent(
      'View Taxi Choose Ride Page',
      <String, Object>{'Screen ID': '455.1.3.0_ZestApp_TaxiFlow'});

  void trackFindingTaxiPage() => _analytics.trackEvent(
      'View Taxi Finding Ride Page',
      <String, Object>{'Screen ID': '455.1.2.1_ZestApp_TaxiFlow'});

  void trackNoDriverFoundPage() => _analytics.trackEvent(
      'View Taxi No Rides Found',
      <String, Object>{'Screen ID': '455.2.1.1_ZestApp_Edge_NoDrivers'});

  void trackTaxiReplacementPage() => _analytics.trackEvent(
      'View Taxi Finding a Ride Replacement',
      <String, Object>{'Screen ID': '455.3.2.0_ZestApp_Edge_DriverCancel'});

  void trackCancelTaxiPage() => _analytics.trackEvent('View Taxi Cancel a Ride',
      <String, Object>{'Screen ID': '455.5.2.0_ZestApp_Edge_UserCancel2'});

  void trackTaxiFoundPage() => _analytics.trackEvent(
      'View Taxi Found a Ride Page',
      <String, Object>{'Screen ID': '455.1.4.0_ZestApp_TaxiFlow'});

  void trackTaxiInProgressToPickUpPage() => _analytics.trackEvent(
      'View Taxi Ride Almost There Page',
      <String, Object>{'Screen ID': '455.1.5.0_ZestApp_TaxiFlow'});

  void trackTaxiArrivedToPickUpPage() => _analytics.trackEvent(
      'View Taxi Ride has arrived Page',
      <String, Object>{'Screen ID': '455.1.7.0_ZestApp_TaxiFlow'});

  void trackUserAboardPage() => _analytics.trackEvent(
      'View Taxi Ride in Progress Page',
      <String, Object>{'Screen ID': '455.1.8.0_ZestApp_TaxiFlow'});

  void trackTaxiTripCompleted() => _analytics.trackEvent(
      'View Taxi Ride is Complete Page',
      <String, Object>{'Screen ID': '455.1.9.0_ZestApp_TaxiFlow'});

  void trackCtaLeaveFeedback() =>
      _analytics.trackEvent('Click Taxi - Support', <String, Object>{
        'Button ID': '457.2.0.0_CustomerSupport_InFlow_Feedback.suggestion'
      });
}
