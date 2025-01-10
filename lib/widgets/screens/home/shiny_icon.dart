import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/shiny_white_container.dart';

class ShinyIcon extends StatelessWidget {
  final double size;
  final IconData icon;
  const ShinyIcon({super.key, required this.size, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ShinyWhiteContainer(
      widget: Icon(
        icon,
        size: size,
        color: Colors.black,
      ),
    );
  }
}
