import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class SingleAvatarLoadingCard extends StatelessWidget {
  final double radius;
  const SingleAvatarLoadingCard({super.key, this.radius = 15});

  @override
  Widget build(BuildContext context) {
    List numberOfIterations = [1, 2, 3, 4, 5, 6, 7, 8];
    Color contextColor = Colors.white.withOpacity(0.1);
    double width = MediaQuery.of(context).size.width;
    double buttonWidth = width > 1280
        ? width * 0.1
        : width > 1024
            ? width * 0.2
            : width > 450
                ? width * 0.3
                : width * 0.6;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
          children: numberOfIterations
              .map<Widget>(
                (rank) => Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        LoadingCard(
                          height: 300,
                          width: width,
                          radius: radius,
                          scaleEnd: 1.02,
                          bgColor: Theme.of(context).primaryColorDark.withOpacity(0.9),
                        ),
                        Positioned(
                            bottom: 15,
                            child: LoadingCard(
                              height: 50,
                              width: buttonWidth,
                              bgColor: contextColor,
                              scaleEnd: 1.02,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
              .toList()),
    );
  }
}
