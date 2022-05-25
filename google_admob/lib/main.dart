import 'package:flutter/material.dart';
import 'package:google_admob/ad_state.dart';
import 'package:google_admob/native_ads.dart';
import 'package:google_admob/reward_interstitial_ads.dart';
import 'package:google_admob/rewarded_ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'interstitial_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? bannerAd;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        bannerAd = BannerAd(
            size: AdSize.banner,
            adUnitId: BannerAd.testAdUnitId /*adState.bannerAdUnitId*/,
            listener: adState.bannerAdListener,
            request: AdRequest())
          ..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Text('hello'),
          ),
          Positioned(
              right: 0.0,
              left: 0.0,
              bottom: 50.0,
              child: buildBannerAd()
          ),
          Positioned(
              right: 100.0,
              left: 100.0,
              top: 200.0,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Interstitial())),
                child: Text('Interstitial Ad'),)
          ),
          Positioned(
              right: 100.0,
              left: 100.0,
              top: 250.0,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Rewarded())),
                child: Text('RewardedAd Ad'),)
          ),
          /*Positioned(
              right: 100.0,
              left: 100.0,
              top: 300.0,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Native())),
                child: Text('Native Ad'),)
          ),
          Positioned(
              right: 100.0,
              left: 100.0,
              top: 350.0,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RewardedInterstitial())),
                child: Text('Reward Interstitial Ad'),)
          )*/
        ]));
  }

  SizedBox buildBannerAd() {
    return SizedBox(
            height: 50,
            child: bannerAd != null
                ? AdWidget(
              ad: bannerAd!,
            )
                : SizedBox(height: 50,),
          );
  }
}
