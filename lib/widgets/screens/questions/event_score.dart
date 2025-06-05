import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/event_neon_shadows.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';

class EventScore extends StatefulWidget {
  final ValueNotifier<int> scoreNotifier;
  final double fontSize;
  final String eventName;
  final bool addMargin;
  const EventScore({
    super.key,
    required this.scoreNotifier,
    this.fontSize = 48,
    required this.eventName,
    this.addMargin = true,
  });

  @override
  State<EventScore> createState() => _EventScoreState();
}

class _EventScoreState extends State<EventScore> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  int _displayedScore = 0;

  @override
  void initState() {
    super.initState();
    _displayedScore = widget.scoreNotifier.value;

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.18)
        .chain(CurveTween(curve: Curves.easeInOutCubic))
        .animate(_scaleController);

    widget.scoreNotifier.addListener(_handleScoreChange);
  }

  void _handleScoreChange() {
    setState(() {
      _displayedScore = widget.scoreNotifier.value;
    });
    _scaleController.forward(from: 0).then((_) => _scaleController.reverse());
  }

  @override
  void dispose() {
    widget.scoreNotifier.removeListener(_handleScoreChange);
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Shadow> shadows = EventNeonShadows.get(widget.eventName, context);

    return AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: widget.addMargin ? 22 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeonWhiteText(
                word: _displayedScore.toString(),
                fontSize: widget.fontSize,
                shadow: shadows,
              ),
            ],
          ),
        ));
  }
}
