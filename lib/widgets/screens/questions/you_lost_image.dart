import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_container.dart';

class YouLostImage extends StatelessWidget {
  final String locale;
  final bool isCasual;
  final String code;
  const YouLostImage(
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
            ? 'assets/images/lost_arabic.png'
            : 'assets/images/lost_english.png');
  }
}
