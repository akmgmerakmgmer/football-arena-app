import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/glass_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/single_perk.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Stats extends StatelessWidget {
  final Map user;
  final int points;
  final int coins;
  final int lives;
  final Function stopTime;
  final Function penalty;
  final Function varMethod;
  final Function stoppageTime;
  const Stats(
      {super.key,
      required this.user,
      required this.points,
      required this.coins,
      required this.lives,
      required this.stopTime,
      required this.penalty,
      required this.varMethod,
      required this.stoppageTime});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 22,
          left: 75,
          child: Column(
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
                          Icons.donut_large,
                          color: Colors.yellow,
                          size: 28,
                        ),
                        TextWidget(
                          title: coins.toString(),
                          fontSize: 13,
                          color: Colors.black,
                        )
                      ],
                    )
                  ],
                ),
              ),
              GlassBackgroundContainer(
                  radius: true,
                  margin: 0,
                  padding: 3,
                  body: Row(
                    children: [
                      SinglePerk(
                          action: stoppageTime,
                          image: 'assets/images/image90.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      SinglePerk(
                          action: penalty, image: 'assets/images/halfTime.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      SinglePerk(
                          action: varMethod, image: 'assets/images/VAR.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      SinglePerk(
                          action: stopTime, image: 'assets/images/stopTime.png')
                    ],
                  )),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 4)),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image.network(
                  user['selectedAvatar']['image'],
                  fit: BoxFit.cover,
                  height: 75,
                  width: 75,
                ),
              )),
        ),
      ],
    );
  }
}
