

import 'package:google_admob/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardedInterstitial extends StatefulWidget {
  RewardedInterstitial({Key? key}) : super(key: key);

  @override
  State<RewardedInterstitial> createState() => _RewardedInterstitialState();
}

class _RewardedInterstitialState extends State<RewardedInterstitial> {
  RewardedInterstitialAd? _rewardedInterstitialAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadRewardedInterstitialAd();
  }

  void showrewardedInterstitialAd() {
    if (_rewardedInterstitialAd != null) {
      _rewardedInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedInterstitialAd ad) {
            print("RewardedInterstitialAd onAdShowedFullScreenContent");
          },
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            loadRewardedInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            loadRewardedInterstitialAd();
          }
      );

      _rewardedInterstitialAd!.setImmersiveMode(true);
      _rewardedInterstitialAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        print("${reward.amount} ${reward.type}");
      });
    }
  }

  void loadRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: 'ca-app-pub-2135695156084823/6020439638',
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              _rewardedInterstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
              _rewardedInterstitialAd = null;
              print("RewardedInterstitialAd error $error");
            }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: OutlinedButton(
                onPressed: () {
                  showrewardedInterstitialAd();
                },
                child: Text('Show RewardedInterstitial Ad'))));
  }

}
