import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button_no_width.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_challenge_mobile/widgets/screens/rankings/user_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleUser extends StatelessWidget {
  final String image;
  final String name;
  final int gamesPlayed;
  final int points;
  final int coins;
  final String rank;
  final bool isSameUser;
  final double fontSize;
  const SingleUser(
      {super.key,
      required this.image,
      required this.gamesPlayed,
      required this.points,
      required this.coins,
      required this.name,
      required this.rank,
      required this.isSameUser, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: isSameUser
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorDark),
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
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Image.network(
                      image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 15,
                ),
                TextWidget(
                  title: name,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                )
              ],
            ),
            const SizedBox(
              width: 75,
            ),
            Row(
              children: [
                UserData(
                    title: AppLocalizations.of(context)!.gamesPlayed,
                    stat: gamesPlayed),
                const SizedBox(
                  width: 10,
                ),
                UserData(
                    title: AppLocalizations.of(context)!.coins, stat: coins),
                const SizedBox(
                  width: 10,
                ),
                UserData(
                    title: AppLocalizations.of(context)!.points, stat: points)
              ],
            )
          ],
        ),
      ),
    );
  }
}
