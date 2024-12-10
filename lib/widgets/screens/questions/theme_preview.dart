import 'package:flutter/material.dart';

class ThemePreview extends StatelessWidget {
  const ThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/shop');
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                )))
      ],
    );
  }
}
