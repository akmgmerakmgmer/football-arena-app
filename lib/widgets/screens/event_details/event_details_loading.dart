import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class EventDetailsLoading extends StatelessWidget {
  const EventDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white.withOpacity(0.15);

    return PagesAssetBackground(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingCard(
            height: 200,
            width: MediaQuery.of(context).size.width,
            radius: 10,
            bgColor: bgColor,
            scaleEnd: 1.015,
          ),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.3,
              bgColor: bgColor,
              scaleEnd: 1.04),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(
            height: 20,
            width: MediaQuery.of(context).size.width,
            bgColor: bgColor,
            scaleEnd: 1.01,
          ),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.3,
              bgColor: bgColor,
              scaleEnd: 1.04),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(
              height: 20,
              width: MediaQuery.of(context).size.width,
              bgColor: bgColor,
              scaleEnd: 1.01),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.3,
              bgColor: bgColor,
              scaleEnd: 1.04),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(
              height: 20,
              width: MediaQuery.of(context).size.width,
              bgColor: bgColor,
              scaleEnd: 1.01),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.3,
              bgColor: bgColor,
              scaleEnd: 1.04),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(
              height: 20,
              width: MediaQuery.of(context).size.width,
              bgColor: bgColor,
              scaleEnd: 1.01),
        ],
      ),
    );
  }
}
