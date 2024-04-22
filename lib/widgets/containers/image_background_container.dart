import 'package:flutter/material.dart';

class ImageBackgroundContainer extends StatelessWidget {
  final Widget body;
  final double height;
  const ImageBackgroundContainer(
      {super.key, required this.body, this.height = 280});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/main_background.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              color: Colors.white
                  .withOpacity(0.05), // Equivalent to bg-white bg-opacity-5
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
          ),
        ),
      ],
    );
  }
}
