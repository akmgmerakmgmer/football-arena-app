import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/game_done_container.dart';

class YouLostImage extends StatelessWidget {
  final String locale;
  const YouLostImage({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return GameDoneContainer(
        image: locale == 'ar'
            ? 'assets/images/lost_arabic.png'
            : 'assets/images/lost_english.png');
  }
}
