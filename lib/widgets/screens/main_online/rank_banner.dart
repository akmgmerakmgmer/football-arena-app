import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class RankBanner extends StatelessWidget {
  final Map user;
  final String locale;
  const RankBanner({super.key, required this.user, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: CachedImage(width: 120, image: user['rank']['rank_banner'][locale]));
  }
}
