import 'dart:io';

import 'package:flutter/services.dart';
import 'package:formula/utils/firestore_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class AdmobHelper extends ChangeNotifier {
  int _rewardedPoint = 0;

  int getRewardPoint() => _rewardedPoint;

  // AdmobAppId, AdmobBanner, AdmobInterstitial, AdmobNative, AdmobRewarded

  static String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static String rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';
  static String nativeAdUnitId = 'ca-app-pub-3940256099942544/2247696110';

  InterstitialAd? _interstitialAd;

  RewardedAd? _rewardedAd;

  int num_of_attempt_load = 0;

  static initialization() {
    // GET APP ID FROM FIRESTORE
    FirestoreService.getCollectionData('AdmobAppId').then((value) {
      if (value != null) {
        print("AdmobApId ${value}");
        // Usage
        setApplicationId("ca-app-pub-3940256099942544~3347511713");
      }
    });

    //
    FirestoreService.getCollectionData('AdmobBanner').then((value) {
      if (value != null) {
        bannerAdUnitId = value['adUnitId'];
      }
    });

    FirestoreService.getCollectionData('AdmobInterstitial').then((value) {
      if (value != null) {
        interstitialAdUnitId = value['adUnitId'];
      }
    });
    FirestoreService.getCollectionData('AdmobRewarded').then((value) {
      if (value != null) {
        rewardedAdUnitId = value['adUnitId'];
      }
    });
    FirestoreService.getCollectionData('AdmobNative').then((value) {
      if (value != null) {
        nativeAdUnitId = value['adUnitId'];
      }
    });

    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static Future<void> setApplicationId(String apiKey) async {
    const platform = MethodChannel('app_metadata');
    try {
      final String? result =
          await platform.invokeMethod('setApplicationId', {'apiKey': apiKey});
      print(result); // Output: Application ID set to: <Your API Key>
    } on PlatformException catch (e) {
      print("Failed to set Application ID: '${e.message}'.");
    }
  }

  // GET BANNER ADS
  static BannerAd getBannerAd() {
    FirestoreService.getCollectionData('AdmobBanner').then((value) {
      if (value != null) {
        bannerAdUnitId = value['adUnitId'];
      }
    });

    BannerAd bAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: bannerAdUnitId,
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
  void createInterstitialAd() {
    print("_interstitialAd : create method ");

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        print("_interstitialAd : onAdLoaded : $ad");
        _interstitialAd = ad;
        num_of_attempt_load = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        print("_interstitialAd : onAdFailedToLoad $error");
        num_of_attempt_load + 1;
        _interstitialAd = null;

        if (num_of_attempt_load <= 2) {
          createInterstitialAd();
        }
      }),
    );
  }

  // SHOW INTERSTITIAL AD
  void loadInterstitialAd() {
    print("_interstitialAd :$_interstitialAd");

    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("_interstitialAd onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("_interstitialAd Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('_interstitialAd $ad OnAdFailed $aderror');
      ad.dispose();
      createInterstitialAd();
    });

    _interstitialAd?.show();

    _interstitialAd = null;
  }

  // LOAD INTERSTITIAL AD
  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          print("Ad loaded");
          this._rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          // loadRewardedAd();
        }));
  }

  // SHOW Rewarded AD
  void showRewardAd() {
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
