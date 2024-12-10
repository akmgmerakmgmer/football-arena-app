import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class VideoRewardAd extends StatefulWidget {
  final bool lives;
  final dynamic livesAction;
  final dynamic questionAction;
  const VideoRewardAd(
      {super.key, this.lives = false, this.livesAction, this.questionAction});

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

  void rewardMethod() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    int coins = getRandomCoin();
    user['coins'] += coins;
    Provider.of<LocaleProvider>(context, listen: false).setUser(user);
    PutApi('users/${user['_id']}', {'coins': user['coins']}, (value) {})
        .put(context);
    List<Map> prizes = [
      {"prizeType": "coins", "coins": coins}
    ];
    ModalContainer.modal(
        context,
        PrizesContent(prizes: prizes, showExclusiveText: false),
        AppLocalizations.of(context)!.congratulations);
  }

  int getRandomCoin() {
    List coinsList = [50, 100, 50, 25, 50, 200, 50, 100, 50, 25, 50];
    final random = Random(); // Create a Random instance
    int randomIndex = random.nextInt(coinsList.length); // Get a random index
    return coinsList[randomIndex]; // Return the coin at the random index
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
      if (widget.lives) {
        widget.questionAction();
      }
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          if (widget.lives) {
            widget.livesAction();
          } else {
            rewardMethod();
          }
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
                if (widget.lives) {
                  widget.livesAction();
                } else {
                  rewardMethod();
                }
              },
            )
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _isAdLoaded ? _showRewardedAd() : null,
      child: Stack(
        children: [
          Icon(
            Icons.smart_display,
            color: widget.lives ? Colors.white : Colors.white60,
            size: 42,
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: widget.lives
                  ? const Row(
                      children: [
                        Icon(
                          Icons.heart_broken,
                          color: Colors.red,
                          size: 15,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        TextWidget(
                          title: '+3',
                          color: Colors.black,
                        ),
                      ],
                    )
                  : const Coin(
                      width: 20,
                    ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }
}
