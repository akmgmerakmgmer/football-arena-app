import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/image_global_background.dart';

class ImageBackgroundContainer extends StatelessWidget {
  final Widget body;
  final double height;
  final double width;
  const ImageBackgroundContainer(
      {super.key, required this.body, this.height = 280, this.width = 300});

  @override
  Widget build(BuildContext context) {
    return ImageGlobalBackground(
        body: Center(
      child: BlurBackgroundContainer(
        body: Container(
          width: width,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              color: Colors.black.withOpacity(0.1)),
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Wraps content vertically with minimum height
            children: [
              // Your body content goes here
              body,
            ],
          ),
        ),
      ),
    ));
  }
}
