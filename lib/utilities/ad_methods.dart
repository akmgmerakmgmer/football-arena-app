import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:provider/provider.dart';

class AdMethods {
  RewardedAd? rewardedAd;
  String rewardedAdUnitId = 'ca-app-pub-6065065349715677/8836064686';
  String interstitialAdUnitId = 'ca-app-pub-6065065349715677/9181247259';
  Future<void> loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (AdWithoutView ad) {
              ad.dispose();
              loadRewardedAd();
            },
            onAdFailedToShowFullScreenContent:
                (AdWithoutView ad, AdError error) {
              ad.dispose();
              loadRewardedAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void showRewardedAd(callback) {
    rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        callback();
      },
    );
  }

  Future<void> createInterstitialAd(BuildContext context) async{
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => localeProvider.setInterstitialAd(ad),
            onAdFailedToLoad: (LoadAdError error) =>
                localeProvider.setInterstitialAd(null)));
  }

  void showInterstitialAd(callback, BuildContext context) async{
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    InterstitialAd? interstitialAd = localeProvider.interstitialAd;

    if (interstitialAd != null) {
      interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd(context);
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterstitialAd(context);
        },
      );
      interstitialAd.show();
      localeProvider.setInterstitialAd(null);
      createInterstitialAd(context);
      callback();
    } else {
      await createInterstitialAd(context);
      showInterstitialAd(callback, context);
    }
  }
}
