import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // Test ID
      : 'ca-app-pub-3940256099942544/2934735716';

  static String get interstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712' // Test ID
      : 'ca-app-pub-3940256099942544/4411468910';

  static String get rewardedAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917' // Test ID
      : 'ca-app-pub-3940256099942544/1712485313';

  InterstitialAd? _interstitialAd;
  int _clickCount = 0;

  Future<void> init() async {
    await MobileAds.instance.initialize();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  void showInterstitialAd() {
    _clickCount++;
    if (_clickCount % 5 == 0 && _interstitialAd != null) {
      _interstitialAd!.show();
      _loadInterstitialAd();
    }
  }

  void showRewardedAd(Function onReward) {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      adLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show(onUserEarnedReward: (ad, reward) => onReward());
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }
}
