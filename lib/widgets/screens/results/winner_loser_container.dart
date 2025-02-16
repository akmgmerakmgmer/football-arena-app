import 'package:flutter/material.dart';

class WinnerLoserContainer extends StatelessWidget {
  final bool isWinner;
  final Widget child;
  const WinnerLoserContainer(
      {super.key, required this.isWinner, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isWinner ? Colors.green.shade400 : Colors.redAccent,
      ),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}
