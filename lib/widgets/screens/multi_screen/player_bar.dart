import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/screens/multi_screen/hexagonal_image.dart';

class PlayerBar extends StatelessWidget {
  final Map player;
  final int index;
  const PlayerBar({super.key, required this.index, required this.player});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            index.isEven
                ? HexagonalImage(
                    image: player['userId']['selectedAvatar']['image'])
                : Container(),
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: index.isEven
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UsernameText(
                      title: player['userId']['username'],
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ),
            ),
            index.isEven ? Container() : HexagonalImage(image: player['userId']['selectedAvatar']['image']),
          ],
        ),
      ),
    );
  }
}
