import 'package:flutter/material.dart';
import 'dart:ui'; // Add this import for BackdropFilter
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';
import 'package:in_zone_app/widgets/screens/rankings/ranking_prize.dart';
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
    final int rankInt = int.tryParse(rank) ?? 0;
    final int animationDelay = rankInt > 10
        ? 10 * 200
        : (rankInt - 1) * 200; // 200ms per user, rank starts from 1
    List<Shadow> shadow = rankInt == 1
        ? NeonBoxShadow().goldNeon(context)
        : rankInt == 2
            ? NeonBoxShadow().silverNeon(context)
            : rankInt == 3
                ? NeonBoxShadow().bronzeNeon(context)
                : NeonBoxShadow().whiteNeon(context);
    return FutureBuilder(
      future: Future.delayed(
          Duration(milliseconds: animationDelay < 0 ? 0 : animationDelay)),
      builder: (context, snapshot) {
        final show = snapshot.connectionState == ConnectionState.done;
        return AnimatedOpacity(
          opacity: show ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: AnimatedSlide(
              offset: show ? Offset.zero : const Offset(-1.0, 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: BlurContainer(
                child: Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
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
                            fontSize: 18,
                            shadow: shadow,
                          ),
                          const SizedBox(width: 15),
                          UserImage(
                            image: item['selectedAvatar']['image'],
                            video: item['selectedAvatar']['video'],
                            height: 60,
                            width: 60,
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
                                      title:
                                          '(${AppLocalizations.of(context)!.you})',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                ],
                              ),
                              if (rankInt < 6) const SizedBox(height: 6),
                              if (rankInt < 6)
                                RankingPrize(numberOfCoins: numberOfCoins),
                            ],
                          )
                        ],
                      ),
                      MainButtonNoWidth(
                        buttonText: item['points'].toString(),
                        fontSize: 16,
                        action: () {},
                        radius: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 7.0),
                      )
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
