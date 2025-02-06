import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_container.dart';

class YouDrewImage extends StatelessWidget {
  final String locale;
  const YouDrewImage({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return GameDoneContainer(
        image: locale == 'ar'
            ? 'assets/images/draw_arabic.png'
            : 'assets/images/draw_english.png');
  }
}
