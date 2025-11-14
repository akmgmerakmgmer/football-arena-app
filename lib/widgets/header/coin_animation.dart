import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/animations/ping_animation.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class CoinAnimation extends StatefulWidget {
  final Map user;
  const CoinAnimation({super.key, required this.user});

  @override
  State<CoinAnimation> createState() => _CoinAnimationState();
}

class _CoinAnimationState extends State<CoinAnimation> {
  bool showCoin = true;

  void toggleCoin() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        showCoin = !showCoin;
      });
    });
  }

  @override
  void initState() {
    toggleCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      child: showCoin
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              key: const ValueKey('coinColumn'),
              children: [
                const PingAnimation(
                  color: Colors.yellow,
                  seconds: 1,
                  size: 15,
                  child: Coin(
                    key: ValueKey('coin'),
                    width: 22,
                  ),
                ),
                const SizedBox(height: 3),
                TextWidget(
                  title: widget.user['coins'].toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  alwaysEnglish: true,
                ),
              ],
            )
          : Column(
              key: const ValueKey('iconColumn'),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PingAnimation(
                    color: Colors.red,
                    seconds: 1,
                    size: 18,
                    child: Image.asset(
                      'assets/images/video_ad.png',
                      width: 28,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  title: AppLocalizations.of(context)!.coinAd,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 11,
                ),
              ],
            ),
    );
  }
}
