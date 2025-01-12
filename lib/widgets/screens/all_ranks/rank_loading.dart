import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/triple_grid_container.dart';
import 'package:in_zone_app/widgets/screens/all_ranks/single_rank_loading.dart';

class RankLoading extends StatelessWidget {
  const RankLoading({super.key});

  @override
  Widget build(BuildContext context) {
    List numberOfIterations = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const SingleRankLoading(),
          const SizedBox(
            height: 8,
          ),
          TripleGridContainer(
            widget: numberOfIterations
                .map<Widget>((rank) => const SingleRankLoading())
                .toList(),
          )
        ],
      ),
    );
  }
}
