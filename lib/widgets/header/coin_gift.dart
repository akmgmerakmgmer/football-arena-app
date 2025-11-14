import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/ad_reward_methods.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/video_reward_ad.dart';
import 'package:in_zone_app/widgets/header/neon_icon.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/animations/pulse_animation.dart';

class CoinGift extends StatelessWidget {
  final String locale;
  final LocaleProvider localeProvider;
  final Map user;
  const CoinGift(
      {super.key,
      required this.locale,
      required this.user,
      required this.localeProvider});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GeneralMethods().isUserExists(context)
          ? VideoRewardAd(
              rewardMethod: () {
                AddRewardMethods().addCoinsMethod(localeProvider, context);
              },
              body: const PulseAnimation(
                    child: Icon(Icons.wallet_giftcard,color: Colors.white,)
                  ),
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
