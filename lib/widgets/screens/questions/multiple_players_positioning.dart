import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/containers/blur_container_with_border.dart';
import 'package:in_zone_app/widgets/screens/questions/online_party_single_result.dart';

class MultiplPlayersPositioning extends StatefulWidget {
  final List players;
  final Map user;
  final LocaleProvider localeProvider;
  const MultiplPlayersPositioning(
      {super.key,
      required this.players,
      required this.user,
      required this.localeProvider});

  @override
  State<MultiplPlayersPositioning> createState() =>
      _MultiplPlayersPositioningState();
}

class _MultiplPlayersPositioningState extends State<MultiplPlayersPositioning>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _socketMethods.sendPointsListener(widget.localeProvider);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAccordion() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final players = widget.players.toList();
    return Stack(
      children: [
        // Arrow button at the very top center, smaller and black with opacity
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 64,
            height: 32,
            child: MainButton(
              radius: 8,
              isWidget: true,
              action: _toggleAccordion,
              buttonText: '',
              widget: RotationTransition(
                turns: _arrowAnimation,
                child: const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        // Accordion content with slide animation and blur background only behind players
        AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          top: _expanded ? 42 : -400, // hide above the screen when collapsed
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _expanded ? 1.0 : 0.0,
            child: Center(
              child: BlurContainerWithBorder(
                padding: const EdgeInsets.all(8),
                child: Material(
                  color: Colors.transparent,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 32,
                    runSpacing: 32,
                    children: [
                      for (final player in players)
                        OnlinePartySingleResult(
                          player: player,
                          user: widget.user,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
