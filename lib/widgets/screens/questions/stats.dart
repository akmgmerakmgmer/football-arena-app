import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/glass_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/coin.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/single_perk.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class Stats extends StatelessWidget {
  final Map user;
  final int points;
  final int coins;
  final int lives;
  final Function stopTime;
  final Function penalty;
  final Function varMethod;
  final Function stoppageTime;
  final Function pointsMultiplicationMethod;
  final Function skipQuestion;
  final List usedPerks;
  final String locale;
  const Stats(
      {super.key,
      required this.user,
      required this.points,
      required this.coins,
      required this.lives,
      required this.stopTime,
      required this.penalty,
      required this.varMethod,
      required this.stoppageTime,
      required this.usedPerks,
      required this.locale,
      required this.pointsMultiplicationMethod,
      required this.skipQuestion});

  void action(perk) {
    bool isPerkUsed = usedPerks
        .where((item) => item == perk['id']['_id'])
        .toList()
        .isNotEmpty;
    if (perk['quantity'] > 0 && !isPerkUsed) {
      switch (perk['id']['title']['en']) {
        case '+90':
          stoppageTime(perk['id']['_id']);
        case 'Penalty':
          penalty(perk['id']['_id']);
        case 'VAR':
          varMethod(perk['id']['_id']);
        case 'Stop Time':
          stopTime(perk['id']['_id']);
        case 'Double Points':
          pointsMultiplicationMethod(perk['id']['_id'], 2, 60);
        case 'Hero Personality':
          pointsMultiplicationMethod(perk['id']['_id'], 3, 40);
        case 'Skip Question':
          skipQuestion(perk['id']['_id']);
        default:
          () => {};
      }
    }
  }

  bool isPerkDisabled(perk) {
    if (perk['quantity'] == 0 || usedPerks.contains(perk['id']['_id'])) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 22,
          left: 75,
          child: Column(
            crossAxisAlignment: locale == 'en'
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bolt,
                          color: Colors.black,
                          size: 28,
                        ),
                        TextWidget(
                          title: points.toString(),
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          alwaysEnglish: true,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.heart_broken,
                          color: Colors.red,
                          size: 28,
                        ),
                        TextWidget(
                          title: lives > 1000
                              ? AppLocalizations.of(context)!.unlimitedText
                              : lives.toString(),
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          alwaysEnglish: true,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Coin(),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          title: coins.toString(),
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          alwaysEnglish: true,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              GlassBackgroundContainer(
                  radius: true,
                  margin: 0,
                  padding: 3,
                  body: Row(
                      children: user['perks']
                          .where((perk) => perk['selected'] == true)
                          .toList()
                          .map<Widget>(((perk) => Column(
                                children: [
                                  SinglePerk(
                                    action: () => action(perk),
                                    image: perk['id']['image'],
                                    disabled: isPerkDisabled(perk),
                                  ),
                                  const SizedBox(
                                    width: 43,
                                  ),
                                ],
                              )))
                          .toList())),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: UserImage(image: user['selectedAvatar']['image']),
        ),
      ],
    );
  }
}
