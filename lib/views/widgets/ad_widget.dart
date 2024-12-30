import 'package:flutter/cupertino.dart';
import 'package:formula/utils/admob_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyBannerAd extends StatefulWidget {
  const MyBannerAd({super.key});

  @override
  State<MyBannerAd> createState() => _MyBannerAdState();
}

class _MyBannerAdState extends State<MyBannerAd> {
  AdmobHelper admobHelper = AdmobHelper();

  BannerAd? bannerAd;

  /// Loads a banner ad.
  void loadAd() {
    bannerAd = AdmobHelper.getBannerAd()..load();
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: bannerAd != null
          ? Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: SizedBox(
                  width: bannerAd!.size.width.toDouble(),
                  height: bannerAd!.size.height.toDouble(),
                  child: AdWidget(key: UniqueKey(), ad: bannerAd!),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
