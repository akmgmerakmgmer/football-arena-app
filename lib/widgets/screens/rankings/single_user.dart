import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';
import 'package:in_zone_app/widgets/screens/rankings/ranking_prize.dart';
import 'package:in_zone_app/widgets/screens/rankings/user_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleUser extends StatelessWidget {
  final dynamic item;
  final String rank;
  final bool isSameUser;
  final String locale;
  final int numberOfCoins;
  const SingleUser(
      {super.key,
      required this.rank,
      required this.isSameUser,
      required this.locale,
      required this.item,
      required this.numberOfCoins});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: isSameUser
                ? Theme.of(context).primaryColor
                : Colors.white.withOpacity(0.05)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainButtonNoWidth(
                  buttonText: rank,
                  action: () {},
                  radius: 100,
                ),
                const SizedBox(
                  width: 15,
                ),
                UserImage(
                  image: item['selectedAvatar']['image'],
                  video: item['selectedAvatar']['video'],
                ),
                const SizedBox(
                  width: 8,
                ),
                // CachedImage(
                //   image: item['rank']['image'],
                //   width: 50,
                // ),
                Row(
                  children: [
                    UsernameText(
                      title: item['username'],
                      fontWeight: FontWeight.bold,
                      fontSize: locale == 'ar' ? 17 : 19,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    isSameUser
                        ? TextWidget(
                            title: '(${AppLocalizations.of(context)!.you})',
                            fontWeight: FontWeight.bold,
                            fontSize: locale == 'ar' ? 17 : 19,
                          )
                        : Container(),
                    int.parse(rank) < 6
                        ? const SizedBox(
                            width: 4,
                          )
                        : Container(),
                    int.parse(rank) < 6
                        ? RankingPrize(numberOfCoins: numberOfCoins)
                        : Container(),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 75,
            ),
            Row(
              children: [
                UserData(
                    title: AppLocalizations.of(context)!.points,
                    stat: item['points']),
                const SizedBox(
                  width: 10,
                ),
                UserData(
                    title: AppLocalizations.of(context)!.coins,
                    stat: item['coins']),
                const SizedBox(
                  width: 10,
                ),
                UserData(
                    title: AppLocalizations.of(context)!.gamesPlayed,
                    stat: item['games_played'])
              ],
            )
          ],
        ),
      ),
    );
  }
}
