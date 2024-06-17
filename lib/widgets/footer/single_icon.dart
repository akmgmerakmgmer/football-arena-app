import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleIcon extends StatelessWidget {
  final String icon;
  final dynamic action;
  const SingleIcon({super.key, required this.icon, this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: SvgPicture.asset(
            icon,
            color: Colors.white,
            semanticsLabel: 'Tiktok Icon', // Optional, for screen readers
            width: 24, // Adjust width as needed
            height: 24, // Adjust height as needed
          )),
    );
  }
}
