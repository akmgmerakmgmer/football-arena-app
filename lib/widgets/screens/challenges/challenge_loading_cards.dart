import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/challenges/single_challenge_loading_card.dart';

class ChallengeLoadingCards extends StatelessWidget {
  const ChallengeLoadingCards({super.key});

  @override
  Widget build(BuildContext context) {
    List numberOfIterations = [1, 2, 3, 4];
    return Row(
        children: numberOfIterations
            .map((e) => const SingleChallengeLoadingCard())
            .toList());
  }
}
