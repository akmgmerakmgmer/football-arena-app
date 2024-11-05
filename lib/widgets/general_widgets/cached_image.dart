import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final double radius;
  const CachedImage(
      {super.key,
      required this.image,
      this.width,
      this.height,
      this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(), // Placeholder while loading
        errorWidget: (context, url, error) =>
            const Icon(Icons.error), // Error widget
      ),
    );
  }
}
