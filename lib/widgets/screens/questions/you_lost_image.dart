import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class YouLostImage extends StatelessWidget {
  final String locale;
  const YouLostImage({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedImage(
          image: locale == 'ar'
              ? 'assets/images/lost_arabic.png'
              : 'assets/images/lost_english.png'),
    );
  }
}
