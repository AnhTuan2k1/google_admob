import 'package:google_admob/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Native extends StatefulWidget {
  Native({Key? key}) : super(key: key);

  @override
  State<Native> createState() => _NativeState();
}

class _NativeState extends State<Native> {
  NativeAd? _nativeAd;
  bool isloaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadNativeAd();
  }

  void loadNativeAd() {
    _nativeAd = NativeAd(
        request: const AdRequest(),
        ///This is a test adUnitId make sure to change it
        adUnitId: NativeAd.testAdUnitId,
        factoryId: 'listTile',
        listener: NativeAdListener(
            onAdLoaded: (ad){
              print('------------native ad loaded-------------');
              isloaded = true;
            },
            onAdFailedToLoad: (ad, error){
              ad.dispose();
              print('------------failed to load the native ad ${error.message}, ${error.code}------------');
            }
        )
    );

    _nativeAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: OutlinedButton(
                onPressed: () {
                  setState(() {});
                },
                child: isloaded
                ? Container(
                  child: AdWidget(ad: _nativeAd!,),
                  alignment: Alignment.center,
                  height: 170,
                  color: Colors.black12,
                )
                : const Text('Native Ad'))
        ));
  }
}
