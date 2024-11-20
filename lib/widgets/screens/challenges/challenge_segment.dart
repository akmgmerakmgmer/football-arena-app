import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge.dart';
import 'package:in_zone_app/widgets/screens/challenges/challenge_loading_cards.dart';

class ChallengeSegment extends StatelessWidget {
  final String title;
  final List data;
  final bool loading;
  const ChallengeSegment(
      {super.key,
      required this.title,
      required this.data,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithBorder(title: title),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: loading
              ? const ChallengeLoadingCards()
              : Row(
                  children: data
                      .map((challenge) => Challenge(
                            challenge: challenge,
                          ))
                      .toList(),
                ),
        )
      ],
    );
  }
}
