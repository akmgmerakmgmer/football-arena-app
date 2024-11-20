import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SinglePlayer extends StatelessWidget {
  final Map player;
  final String locale;
  final Function action;
  const SinglePlayer(
      {super.key,
      required this.player,
      required this.locale,
      required this.action});
  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Column(
        children: [
          Row(
            children: [
              CachedImage(
                image: player['image'],
                height: 35,
                width: 35,
                radius: 100,
              ),
              const SizedBox(
                width: 8,
              ),
              TextWidget(
                title: capitalize(
                    locale == 'en' ? player['nameEn'] : player['nameAr']),
                fontSize: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
