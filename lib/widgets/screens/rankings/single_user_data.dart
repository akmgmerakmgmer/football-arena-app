import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/rankings/ranking_prize.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';

class SingleUserData extends StatelessWidget {
  final Map item;
  final bool isSameUser;
  final String rank;
  final int numberOfCoins;
  final int points;
  const SingleUserData(
      {super.key,
      required this.item,
      required this.isSameUser,
      required this.rank,
      required this.numberOfCoins,
      this.points = 0});

  @override
  Widget build(BuildContext context) {
    final int rankInt = int.tryParse(rank) ?? 0;

    List<Shadow> shadow = rankInt == 1
        ? NeonBoxShadow().goldNeon(context)
        : rankInt == 2
            ? NeonBoxShadow().silverNeon(context)
            : rankInt == 3
                ? NeonBoxShadow().bronzeNeon(context)
                : NeonBoxShadow().whiteNeon(context);
    return BlurContainer(
      child: Container(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: isSameUser
              ? Theme.of(context).primaryColor.withOpacity(0.8)
              : Colors.white.withOpacity(0.15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NeonWhiteText(
                  word: rank,
                  fontSize: 24,
                  shadow: shadow,
                ),
                const SizedBox(width: 15),
                UserImage(
                  image: item['selectedAvatar']['image'],
                  video: item['selectedAvatar']['video'],
                  showVideo: true,
                  height: 75,
                  width: 75,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        UsernameText(
                          title: item['username'],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        const SizedBox(width: 4),
                        if (isSameUser)
                          TextWidget(
                            title: '(${AppLocalizations.of(context)!.you})',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                      ],
                    ),
                    if (rankInt < 6) const SizedBox(height: 6),
                    if (rankInt < 6) RankingPrize(numberOfCoins: numberOfCoins),
                  ],
                )
              ],
            ),
            MainButtonNoWidth(
              buttonText:
                  points != 0 ? points.toString() : item['points'].toString(),
              fontSize: 16,
              action: () {},
              radius: 100,
              alwaysEnglish: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
            )
          ],
        ),
      ),
    );
  }
}
