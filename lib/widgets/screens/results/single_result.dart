import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';
import 'package:in_zone_app/widgets/screens/results/winner_loser_dot.dart';

class SingleResult extends StatelessWidget {
  final List result;
  const SingleResult({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Map player1 = result[0];
    Map player2 = result[1];
    double defaultFontSize = 15;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserImage(
              image: player1['player']['selectedAvatar']['image'],
              height: 65,
              width: 65,
            ),
            WinnerLoserDot(isWinner: player1['isWinner']),
            const SizedBox(
              width: 8,
            ),
            Row(
              children: [
                UsernameText(
                  title: player1['player']['username'],
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
                  title: player2['player']['username'],
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            UserImage(
              image: player2['player']['selectedAvatar']['image'],
              height: 65,
              width: 65,
            ),
            WinnerLoserDot(isWinner: player2['isWinner']),
          ],
        ),
      ),
    );
  }
}
