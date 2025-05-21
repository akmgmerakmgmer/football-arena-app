import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class SingleRankLoading extends StatelessWidget {
  const SingleRankLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoadingCard(
          height: 60,
          width: 60,
          radius: 100,
          bgColor: Colors.white.withOpacity(0.15),
        ),
        const SizedBox(
          height: 8,
        ),
        LoadingCard(
          height: 10,
          width: 100,
          radius: 4,
          bgColor: Colors.white.withOpacity(0.15),
        )
      ],
    );
  }
}
