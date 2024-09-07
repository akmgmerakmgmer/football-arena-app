import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class ImageBackgroundContainer extends StatelessWidget {
  final Widget body;
  final double height;
  final double width;
  const ImageBackgroundContainer(
      {super.key, required this.body, this.height = 280, this.width = 300});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedImage(
          image:'http://res.cloudinary.com/do0qe5hin/image/upload/v1725714122/ygxws6bwae22gyqiqspd.jpg',
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
    );
  }
}
