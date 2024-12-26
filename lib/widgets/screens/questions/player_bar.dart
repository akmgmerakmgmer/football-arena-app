import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/username_text.dart';
import 'package:in_zone_app/widgets/screens/questions/hexagonal_image.dart';

class PlayerBar extends StatelessWidget {
  final String image;
  final String username;
  final int index;
  const PlayerBar(
      {super.key,
      required this.image,
      required this.username,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            index.isEven ? HexagonalImage(image: image) : Container(),
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
                      title: username,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ),
            ),
            index.isEven ? Container() : HexagonalImage(image: image),
          ],
        ),
      ),
    );
  }
}
