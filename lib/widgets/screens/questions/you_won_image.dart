import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class YouWonImage extends StatelessWidget {
  final String locale;
  const YouWonImage({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedImage(
          image: locale == 'ar'
              ? 'assets/images/won_arabic.png'
              : 'assets/images/won_english.png'),
    );
  }
}
