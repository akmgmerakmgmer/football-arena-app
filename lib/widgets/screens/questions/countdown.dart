import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'dart:ui';

class CountDown extends StatelessWidget {
  final ValueNotifier<int> countDownNotifier;
  final int defaultCountDown;
  final double defaultSize;
  const CountDown({
    super.key,
    required this.countDownNotifier,
    required this.defaultCountDown,
    this.defaultSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: countDownNotifier,
      builder: (context, countdown, _) {
        // Determine color based on time remaining
        Color neonColor;
        List<Shadow> textShadow;

        if (countdown > 10) {
          neonColor = Colors.white;
          textShadow = NeonBoxShadow().whiteNeon(context);
        } else if (countdown > 5) {
          neonColor = Colors.yellow;
          textShadow = NeonBoxShadow().goldNeon(context);
        } else {
          neonColor = Colors.red;
          textShadow = NeonBoxShadow().redNeon(context);
        }

        return BlurContainer(
          radius: 8,
          child: Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: neonColor.withOpacity(0.5),
                width: 2,
              ),
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: neonColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.timer,
                  color: Colors.white,
                  size: 24,
                  shadows: textShadow,
                ),
                const SizedBox(width: 6),
                NeonWhiteText(
                  word: countdown.toString(),
                  fontSize: 24,
                  shadow: textShadow,
                  alwaysEnglish: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
