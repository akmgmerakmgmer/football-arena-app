import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_container.dart';

class YouWonImage extends StatelessWidget {
  final String locale;
  final bool isCasual;
  final String code;
  const YouWonImage(
      {super.key,
      required this.locale,
      required this.isCasual,
      required this.code});

  @override
  Widget build(BuildContext context) {
    return GameDoneContainer(
        isCasual: isCasual,
        code: code,
        image: locale == 'ar'
            ? 'assets/images/won_arabic.png'
            : 'assets/images/won_english.png');
  }
}
