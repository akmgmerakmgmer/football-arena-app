import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';
import 'package:in_zone_app/widgets/screens/questions/event_score.dart';

class NeonTitleAndNumber extends StatelessWidget {
  final String title;
  final ValueNotifier<int> number;
  final List<Shadow> shadow;
  final double fontSize;
  final String eventName;
  const NeonTitleAndNumber({
    super.key,
    required this.title,
    required this.number,
    required this.shadow,
    required this.fontSize,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      radius: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeonWhiteText(
              word: title,
              fontSize: fontSize * 0.7,
              shadow: shadow,
            ),
            const SizedBox(height: 4),
            EventScore(
              scoreNotifier: number,
              fontSize: fontSize,
              eventName: eventName,
              addMargin: false,
            ),
          ],
        ),
      ),
    );
  }
}
