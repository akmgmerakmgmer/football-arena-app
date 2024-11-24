import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  final double width;
  const Coin({super.key, this.width = 25});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/coin.png',
      width: width,
    );
  }
}
