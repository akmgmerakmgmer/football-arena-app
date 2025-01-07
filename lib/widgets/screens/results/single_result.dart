import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class SingleResult extends StatelessWidget {
  final List result;
  const SingleResult({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Map player1 = result[0];
    Map player2 = result[1];
    double defaultFontSize = 17;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserImage(
              image: player1['image'],
              borderColor: Colors.transparent,
              imageSize: 65,
            ),
            const SizedBox(
                  width: 8,
                ),
            Row(
              children: [
                UsernameText(
                  title: player1['playerName'],
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 8,
                ),
                TextWidget(
                  title: player1['points'].toString(),
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.bold,
                  alwaysEnglish: true,
                ),
                const SizedBox(
                  width: 4,
                ),
                TextWidget(
                  title: '-',
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 4,
                ),
                TextWidget(
                  title: player2['points'].toString(),
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.bold,
                  alwaysEnglish: true,
                ),
                const SizedBox(
                  width: 8,
                ),
                UsernameText(
                  title: player2['playerName'],
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            UserImage(
                image: player2['image'],
                borderColor: Colors.transparent,
                imageSize: 65),
          ],
        ),
      ),
    );
  }
}
