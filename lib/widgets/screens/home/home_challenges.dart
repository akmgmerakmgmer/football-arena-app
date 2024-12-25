import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge.dart';
import 'package:provider/provider.dart';

class HomeChallenges extends StatelessWidget {
  const HomeChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    Map challenges =
        Provider.of<LocaleProvider>(context, listen: false).challenges;
    return challenges.isEmpty
        ? Container()
        : Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: challenges['homeChallenges']
                        .map<Widget>((challenge) => Challenge(
                              challenge: challenge,
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
          );
  }
}
