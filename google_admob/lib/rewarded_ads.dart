

import 'package:google_admob/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rewarded extends StatefulWidget {
  Rewarded({Key? key}) : super(key: key);

  @override
  State<Rewarded> createState() => _RewardedState();
}

class _RewardedState extends State<Rewarded> {
  RewardedAd? _rewardedAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadRewardedAd();
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {
            print("Ad onAdShowedFullScreenContent");
          },
          onAdDismissedFullScreenContent: (RewardedAd ad) {
            ad.dispose();
            loadRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
            ad.dispose();
            loadRewardedAd();
          }
      );

      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        print("${reward.amount} ${reward.type}");
      });
    }
  }

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              _rewardedAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
              _rewardedAd = null;
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: OutlinedButton(
                onPressed: () {
                  showRewardedAd();
                },
                child: Text('Show Rewarded Ad'))));
  }

}
