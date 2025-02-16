import 'package:flutter/material.dart';

class WinnerLoserDot extends StatelessWidget {
  final bool isWinner;
  const WinnerLoserDot({super.key, required this.isWinner});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isWinner ? Colors.green.shade400 : Colors.redAccent,
      ),
    );
  }
}
