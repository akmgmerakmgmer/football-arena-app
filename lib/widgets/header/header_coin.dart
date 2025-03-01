import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';
import 'package:in_zone_app/utilities/ad_reward_methods.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/header/coin_animation.dart';
import 'package:in_zone_app/widgets/header/neon_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderCoin extends StatelessWidget {
  final String locale;
  final LocaleProvider localeProvider;
  final Map user;
  const HeaderCoin(
      {super.key,
      required this.locale,
      required this.user,
      required this.localeProvider});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GeneralMethods().isUserExists(context)
          ? GestureDetector(
              onTap: () {
                if (AddRewardMethods()
                    .isFreeCoinsAvailable(localeProvider, context)) {
                  AdMethods().showInterstitialAd(() {
                    Future.delayed(const Duration(seconds: 3), () {
                      AddRewardMethods()
                          .addCoinsMethod(localeProvider, context);
                    });
                  }, context);
                }
              },
              child: CoinAnimation(user: user)
            )
          : GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/signup',
              ),
              child: Column(
                children: [
                  const NeonIcon(icon: Icons.login),
                  SizedBox(
                    height: locale == 'ar' ? 2 : 4,
                  ),
                  TextWidget(
                    title: AppLocalizations.of(context)!.login_word,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
    );
  }
}
