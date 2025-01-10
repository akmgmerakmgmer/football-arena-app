import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/ad_reward_methods.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/video_reward_ad.dart';
import 'package:in_zone_app/widgets/header/neon_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/loadings/pulse_animation.dart';

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
          ? VideoRewardAd(
              rewardMethod: () {
                AddRewardMethods().addCoinsMethod(localeProvider, context);
              },
              body: Column(
                children: [
                  const PulseAnimation(
                    child: Coin(
                      width: 20,
                    ),
                  ),
                  SizedBox(
                    height: locale == 'ar' ? 2 : 4,
                  ),
                  TextWidget(
                    title: user['coins'].toString(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    alwaysEnglish: true,
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/login',
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
