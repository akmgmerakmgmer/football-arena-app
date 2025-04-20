import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class CountDown extends StatelessWidget {
  final ValueNotifier<int> countDownNotifier;
  final int defaultCountDown;
  const CountDown(
      {super.key,
      required this.countDownNotifier,
      required this.defaultCountDown});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: countDownNotifier,
      builder: (context, countdown, _) {
        int initialCountdown = defaultCountDown;
        double progress = countdown / initialCountdown;

        // Determine target color for transition
        const Color targetColor = Colors.red;

        return TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: targetColor),
          duration: const Duration(milliseconds: 300),
          builder: (context, animatedColor, _) {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(end: progress.clamp(0.0, 1.0)),
              duration: const Duration(milliseconds: 300),
              builder: (context, animatedProgress, _) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    elevation: 2,
                    shape: const CircleBorder(),
                    color: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: animatedProgress,
                            strokeWidth: 4,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(animatedColor!),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: TextWidget(
                              key: ValueKey(countdown),
                              title: countdown.toString(),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              alwaysEnglish: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
