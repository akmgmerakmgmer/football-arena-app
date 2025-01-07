import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
    _loadRewardedAd();
  }


  Future<void> _loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId:
          'ca-app-pub-6065065349715677/8836064686', // Replace with your Ad Unit ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          setState(() {
            _rewardedAd = ad;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
        },
      ),
    );
  }

  void _showRewardedAd() async {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
           widget.rewardMethod();
        },
      );

      // Dispose of the ad after showing it
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (AdWithoutView ad) {
          ad.dispose();
          _loadRewardedAd(); // Load a new ad for next use
        },
        onAdFailedToShowFullScreenContent: (AdWithoutView ad, AdError error) {
          ad.dispose();
        },
      );
    } else {
      await _loadRewardedAd().then((value) => {
            _rewardedAd!.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                widget.rewardMethod();
              },
            )
          });
    }
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
