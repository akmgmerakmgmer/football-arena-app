import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final double radius;
  const AssetImageWidget(
      {super.key,
      required this.image,
      this.width,
      this.height,
      this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
            child: Container()));
  }
}
