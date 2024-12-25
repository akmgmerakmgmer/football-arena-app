import 'package:flutter/material.dart';

class ResultBar extends StatelessWidget {
  final double width;
  const ResultBar({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark, // Black background
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: maxWidth, // Full width of the screen
      height: 10,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          width: width,
          height: 10,
        ),
      ),
    );
  }
}
