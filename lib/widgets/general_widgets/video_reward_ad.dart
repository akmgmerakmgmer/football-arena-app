import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';

class VideoRewardAd extends StatefulWidget {
  final Widget body;
  final Function rewardMethod;
  const VideoRewardAd(
      {super.key, required this.body, required this.rewardMethod});

  @override
  // ignore: library_private_types_in_public_api
  _VideoRewardAdState createState() => _VideoRewardAdState();
}

class _VideoRewardAdState extends State<VideoRewardAd> {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd(); // Load the ad earlier so it's ready when needed
  }

  Future<void> _loadRewardedAd({show = false}) async {
    setState(() {
      _isAdLoaded = false; // Ensure UI knows ad is not yet loaded
    });

    await RewardedAd.load(
      adUnitId:
          AdMethods().rewardedAdUnitId, // Replace with your Ad Unit ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          setState(() {
            _rewardedAd = ad;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          setState(() {
            _isAdLoaded = false;
            _rewardedAd = null; // Update UI accordingly
          });
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (AdWithoutView ad) {
          ad.dispose();
          _loadRewardedAd(); // Preload the next ad
        },
        onAdFailedToShowFullScreenContent: (AdWithoutView ad, AdError error) {
          ad.dispose();
          _loadRewardedAd();
        },
      );
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          widget.rewardMethod();
        },
      );
    } else {
      _loadRewardedAd(show: true); // Ensure ad loads again
    }
    _rewardedAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _isAdLoaded ? _showRewardedAd() : null,
      child: widget.body,
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }
}
