import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class SingleShopLoadingCard extends StatelessWidget {
  const SingleShopLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color contextColor = Colors.white.withOpacity(0.1);
    double defaultWidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width > 1280
        ? defaultWidth * 1 / 4
        : MediaQuery.of(context).size.width > 1024
            ? defaultWidth * 1 / 3
            : MediaQuery.of(context).size.width > 450
                ? defaultWidth * 1 / 2
                : defaultWidth;
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: SizedBox(
            width: width,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: LoadingCard(
                  height: 300,
                  width: width,
                  scaleEnd: 1.01,
                )),
          ),
        ),
        Positioned(
          bottom: 15,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingCard(
                    height: 30,
                    width: 30,
                    bgColor: contextColor,
                    radius: 100,
                    scaleEnd: 1.02,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingCard(
                        height: 10,
                        width: 100,
                        bgColor: contextColor,
                        scaleEnd: 1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      LoadingCard(
                        height: 10,
                        width: width * 0.7,
                        bgColor: contextColor,
                        scaleEnd: 1.01,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              LoadingCard(
                height: 50,
                width: width * 0.8,
                bgColor: contextColor,
                scaleEnd: 1.01,
              )
            ],
          ),
        ),
      ],
    );
  }
}
