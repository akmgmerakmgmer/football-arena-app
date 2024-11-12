import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/loading_card.dart';

class EventDetailsLoading extends StatelessWidget {
  const EventDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingCard(
            height: 200,
            width: MediaQuery.of(context).size.width,
            radius: 10,
          ),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20, width: MediaQuery.of(context).size.width * 0.3),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(height: 20, width: MediaQuery.of(context).size.width),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20, width: MediaQuery.of(context).size.width * 0.3),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(height: 20, width: MediaQuery.of(context).size.width),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20, width: MediaQuery.of(context).size.width * 0.3),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(height: 20, width: MediaQuery.of(context).size.width),
          const SizedBox(
            height: 16,
          ),
          LoadingCard(
              height: 20, width: MediaQuery.of(context).size.width * 0.3),
          const SizedBox(
            height: 8,
          ),
          LoadingCard(height: 20, width: MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}
