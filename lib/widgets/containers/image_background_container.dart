import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';

class ImageBackgroundContainer extends StatelessWidget {
  final Widget body;
  final double height;
  final double width;
  const ImageBackgroundContainer(
      {super.key, required this.body, this.height = 280, this.width = 300});

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/background_new.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: BlurBackgroundContainer(
              body: Container(
                width: width,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    color: Colors.black.withOpacity(0.1)),
                child: body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
