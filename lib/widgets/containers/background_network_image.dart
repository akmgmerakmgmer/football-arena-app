import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/media_query_height.dart';

class BackgroundNetworkImage extends StatelessWidget {
  final String image;
  final Widget body;
  final double radius;
  const BackgroundNetworkImage(
      {super.key,
      required this.image,
      required this.body,
      this.radius = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQueryHeight().avatarImageHeight(context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: body);
  }
}
