import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/media_query_height.dart';

class EventImageBackground extends StatelessWidget {
  final Widget child;
  final int numberOfImages;
  final String image; // Default value, can be overridden
  const EventImageBackground(
      {super.key,
      required this.child,
      required this.numberOfImages,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
          height: MediaQueryHeight()
              .largeImageHeight(context, mobileDefaultHeight: 200.00),
          width: numberOfImages == 1
              ? MediaQuery.of(context).size.width - 16
              : MediaQuery.of(context).size.width - 48,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(image), fit: BoxFit.cover)),
          child: child),
    );
  }
}
