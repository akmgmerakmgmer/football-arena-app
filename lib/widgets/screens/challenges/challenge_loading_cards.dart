import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class ChallengeLoadingCards extends StatelessWidget {
  const ChallengeLoadingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      LoadingCard(
        width: 225,
        height: 420,
      ),
      const SizedBox(
        width: 24,
      ),
      LoadingCard(
        width: 225,
        height: 420,
      ),
      const SizedBox(
        width: 24,
      ),
      LoadingCard(
        width: 225,
        height: 420,
      ),
      const SizedBox(
        width: 24,
      ),
      LoadingCard(
        width: 225,
        height: 420,
      ),
      const SizedBox(
        width: 24,
      ),
      LoadingCard(
        width: 225,
        height: 420,
      )
    ]);
  }
}
