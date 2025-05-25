import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/utilities/game_data.dart';
import 'package:in_zone_app/widgets/screens/home/single_mode.dart';

class QuestionMods extends StatelessWidget {
  final bool isOnline;
  const QuestionMods({
    super.key,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: GameData.modes
                  .map((mode) => SingleMode(
                        singleMode: mode,
                        isOnline: isOnline,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
