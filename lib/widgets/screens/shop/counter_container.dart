import 'package:flutter/material.dart';

class CounterContainer extends StatelessWidget {
  final Widget body;
  const CounterContainer({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: const BorderRadius.all(
            Radius.circular(100)), // Equivalent to bg-white bg-opacity-5
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20, // Equivalent to backdrop-blur-md
            spreadRadius: 20, // Optional
            offset: const Offset(0, 3), // Optional
          ),
        ],
      ),
      child: body,
    );
  }
}
