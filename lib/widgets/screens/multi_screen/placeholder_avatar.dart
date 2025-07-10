import 'package:flutter/material.dart';

class PlaceholderAvatar extends StatelessWidget {
  const PlaceholderAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 2,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: const Icon(Icons.person_outline, color: Colors.white38, size: 32),
    );
  }
}
