import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/rankings/single_loading_card.dart';

class UserLoadingCard extends StatelessWidget {
  const UserLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    List numberOfIterations = [1, 2, 3, 4, 5];
    return Column(
      children: numberOfIterations
          .map((e) => Container(
              margin: const EdgeInsets.only(top: 10),
              child: const SingleLoadingCard()))
          .toList(),
    );
  }
}
