import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);

  String get bannerAdUnitId =>
      Platform.isAndroid
          ? 'ca-app-pub-2135695156084823/4508897472'
          : 'ca-app-pub-2135695156084823/6562606941';

  String get interstitialAdUnitId => 'ca-app-pub-2135695156084823/4588223871';
  String get rewardedAdUnitId => 'ca-app-pub-2135695156084823/8035410648';
  String get rewardInterstitialAdUnitId => 'ca-app-pub-2135695156084823/6020439638';
  String get nativeAdUnitId => 'ca-app-pub-2135695156084823/4117219076';

  InterstitialAdLoadCallback get interstitialAdLoadCallback => _interstitialAdLoadCallback;
  final InterstitialAdLoadCallback _interstitialAdLoadCallback =
  InterstitialAdLoadCallback(
      onAdLoaded: (ad) => print('interstitial Ad loaded: ${ad.adUnitId}'),
      onAdFailedToLoad:(error) =>
          print('interstitial Ad failed to load: ${error.message}'),
  );

  BannerAdListener get bannerAdListener => _bannerAdListener;
  final BannerAdListener _bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => print('banner Ad loaded: ${ad.adUnitId}'),
    onAdClosed: (ad) => print('banner Ad closed: ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) =>
        print('banner Ad failed to load: ${ad.adUnitId}, $error'),
    onAdOpened: (ad) => print('banner Ad loaded: ${ad.adUnitId}'),
    onAdClicked: (ad) => print('banner Ad clicked: ${ad.adUnitId}'),
    onAdImpression: (ad) => print('banner Ad loaded: ${ad.adUnitId}'),
    onAdWillDismissScreen: (ad) =>
        print('banner Ad dismissScreen: ${ad.adUnitId}'),
    onPaidEvent: (ad, double, precisionType, string) =>
        print(
            'banner Ad loaded: ${ad
                .adUnitId}, $double, $precisionType, $string'),
  );
}
