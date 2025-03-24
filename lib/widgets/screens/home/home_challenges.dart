import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/animations/pulse_animation.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge.dart';
import 'package:provider/provider.dart';

class HomeChallenges extends StatelessWidget {
  const HomeChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    Map challenges =
        Provider.of<LocaleProvider>(context, listen: false).challenges;
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return challenges.isEmpty
        ? Container()
        : Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: challenges['homeChallenges']
                        .map<Widget>((challenge) => Challenge(
                              challenge: challenge,
                            ))
                        .toList(),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/challenges'),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: NeonBoxShadow().boxShadowNeon(context),
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(100)),
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          right: locale == 'en' ? 16 : 0,
                          left: locale == 'en' ? 0 : 16),
                      child: PulseAnimation(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: locale == 'en' ? 2 : 0,
                              right: locale == 'en' ? 0 : 2),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
