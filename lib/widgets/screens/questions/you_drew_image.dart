import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_container.dart';

class YouDrewImage extends StatelessWidget {
  final String locale;
  final bool isCasual;
  final String code;
  const YouDrewImage(
      {super.key,
      required this.locale,
      required this.isCasual,
      required this.code});

  @override
  Widget build(BuildContext context) {
    return GameDoneContainer(
      image: locale == 'ar'
          ? 'assets/images/draw_arabic.png'
          : 'assets/images/draw_english.png',
      isCasual: isCasual,
      code: code,
    );
  }
}
