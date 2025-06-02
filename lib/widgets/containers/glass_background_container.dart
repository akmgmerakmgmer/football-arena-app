import 'package:flutter/material.dart';

class GlassBackgroundContainer extends StatelessWidget {
  final Widget body;
  final double margin;
  final double padding;
  final bool radius;
  const GlassBackgroundContainer(
      {super.key,
      required this.body,
      this.margin = 16.0,
      this.padding = 16.0,
      this.radius = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: radius
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))
            : null, // Equivalent to bg-white bg-opacity-5
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
