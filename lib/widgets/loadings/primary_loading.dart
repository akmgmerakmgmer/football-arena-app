import 'package:flutter/material.dart';

class PrimaryLoading extends StatelessWidget {
  final double size;
  const PrimaryLoading({super.key, this.size = 15.0});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
    );
  }
}
