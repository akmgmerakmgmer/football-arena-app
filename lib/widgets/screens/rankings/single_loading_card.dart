import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class SingleLoadingCard extends StatelessWidget {
  const SingleLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color contextColor = Colors.white.withOpacity(0.1);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).primaryColorDark),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LoadingCard(
                  width: 20,
                  height: 20,
                  radius: 100,
                  bgColor: contextColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                LoadingCard(
                  width: 35,
                  height: 35,
                  radius: 100,
                  bgColor: contextColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                LoadingCard(
                  width: 50,
                  height: 10,
                  radius: 100,
                  bgColor: contextColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                LoadingCard(
                  width: 50,
                  height: 10,
                  radius: 100,
                  bgColor: contextColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                LoadingCard(
                  width: 50,
                  height: 10,
                  radius: 100,
                  bgColor: contextColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                LoadingCard(
                  width: 50,
                  height: 10,
                  radius: 100,
                  bgColor: contextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
