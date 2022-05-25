import 'package:google_admob/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Interstitial extends StatefulWidget {
  Interstitial({Key? key}) : super(key: key);

  @override
  State<Interstitial> createState() => _InterstitialState();
}

class _InterstitialState extends State<Interstitial> {
  InterstitialAd? _interstitialAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        InterstitialAd.load(
            adUnitId: InterstitialAd.testAdUnitId /*adState.interstitialAdUnitId*/,
            request: AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (ad) {
                print('interstitial Ad loaded: ${ad.adUnitId}');
                _interstitialAd = ad;
                _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (ad){
                    _interstitialAd!.dispose();
                  },
                  onAdFailedToShowFullScreenContent: (ad, error){
                    _interstitialAd!.dispose();
                }
                );
              },
              onAdFailedToLoad: (error) =>
                  print('interstitial Ad failed to load: ${error.message}'),
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: OutlinedButton(
                onPressed: () {
                  if (_interstitialAd != null) _interstitialAd!.show();
                },
                child: Text('Show Interstitial Ad'))
        ));
  }
}
