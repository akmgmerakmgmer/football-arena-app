import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundImageBlack extends StatelessWidget {
  final double radius;
  final String image;
  final Widget body;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double height;
  const BackgroundImageBlack(
      {super.key,
      this.radius = 10,
      required this.image,
      required this.body,
      required this.padding,
      required this.height,
      this.margin = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          image: DecorationImage(
              image: CachedNetworkImageProvider(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ))),
      child: body,
    );
  }
}
