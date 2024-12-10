import 'package:flutter/material.dart';

class PrimaryLoading extends StatelessWidget {
  final double size;
  final Color color;
  const PrimaryLoading(
      {super.key, this.size = 15.0, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      ),
    );
  }
}
