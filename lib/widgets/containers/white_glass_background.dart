import 'package:flutter/material.dart';

class WhiteGlassBackground extends StatelessWidget {
  final EdgeInsets padding;
  final Widget body;
  const WhiteGlassBackground(
      {super.key, this.padding = const EdgeInsets.all(8), required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.1)),
        child: body);
  }
}
