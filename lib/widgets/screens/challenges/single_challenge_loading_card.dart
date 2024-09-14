import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class SingleChallengeLoadingCard extends StatelessWidget {
  const SingleChallengeLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color contextColor = Colors.grey.shade800;
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const LoadingCard(height: 420, width: 225, scaleEnd: 1.01),
              Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: 225,
                    decoration: BoxDecoration(
                        color:  Theme.of(context).splashColor.withOpacity(0.55),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Column(
                      children: [
                        LoadingCard(
                          height: 10,
                          width: 80,
                          scaleEnd: 1.02,
                          bgColor: contextColor,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        LoadingCard(
                          height: 10,
                          width: 120,
                          scaleEnd: 1.02,
                          bgColor: contextColor,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        LoadingCard(
                          height: 35,
                          width: 175,
                          scaleEnd: 1.02,
                          bgColor: contextColor,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}
