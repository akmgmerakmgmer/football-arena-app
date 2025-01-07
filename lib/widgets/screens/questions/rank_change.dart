import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class RankChange extends StatelessWidget {
  final Map user;
  final String locale;
  const RankChange({super.key, required this.user, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget(
          title: user['rank']['title'][locale],
          fontSize: 18,
          fontWeight: FontWeight.w600,
          uppercase: true,
        ),
        const SizedBox(
          height: 8,
        ),
        CachedImage(image: user['rank']['image'],width: 100,)
      ],
    );
  }
}
