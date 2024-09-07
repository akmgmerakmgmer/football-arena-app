import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class ImageBackgroundPlain extends StatelessWidget {
  final Widget body;
  const ImageBackgroundPlain({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedImage(
            image:
                'http://res.cloudinary.com/do0qe5hin/image/upload/v1725714122/ygxws6bwae22gyqiqspd.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          body
        ],
      ),
    );
  }
}
