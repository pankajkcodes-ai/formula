import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class AdmobHelper extends ChangeNotifier {
  int _rewardedPoint = 0;

  int getrewardpoint() => _rewardedPoint;

  static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  InterstitialAd? _interstitialAd;

  RewardedAd? _rewardedAd;

  int num_of_attempt_load = 0;

  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  // GET BANNER ADS
  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          print("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          print('Ad opened');
        }),
        request: AdRequest());

    return bAd;
  }

  // CREATE INTERSTITIAL AD
  void createInterad() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        _interstitialAd = ad;
        num_of_attempt_load = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        num_of_attempt_load + 1;
        _interstitialAd = null;

        if (num_of_attempt_load <= 2) {
          createInterad();
        }
      }),
    );
  }

  // SHOW INTERSTITIAL AD
  void showInterad() {
    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("ad onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('$ad OnAdFailed $aderror');
      ad.dispose();
      createInterad();
    });

    _interstitialAd?.show();

    _interstitialAd = null;
  }

  // LOAD INTERSTITIAL AD
  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          print("Ad loaded");
          this._rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          // loadRewardedAd();
        }));
  }

// SHOW INTERSTITIAL AD
  void showRewaredAd() {
    _rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView? ad, RewardItem rpoint) {
      print("Reward Earned is ${rpoint.amount}");
      // _rewardedPoint = _rewardedPoint + rpoint.amount;

      notifyListeners();
    });

    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {},
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );
  }
}
