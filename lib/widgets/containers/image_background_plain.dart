import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBackgroundPlain extends StatelessWidget {
  final Widget body;
  final String image;
  const ImageBackgroundPlain(
      {super.key, required this.body, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).splashColor,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(image), fit: BoxFit.cover)),
          child: body),
    );
  }
}
