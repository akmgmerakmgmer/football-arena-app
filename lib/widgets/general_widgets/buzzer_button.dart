import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class BuzzerButton extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback hideBuzzer;
  final double size;
  const BuzzerButton({
    super.key,
    required this.onPressed,
    this.size = 120,
    required this.hideBuzzer,
  });

  @override
  State<BuzzerButton> createState() => _BuzzerButtonState();
}

class _BuzzerButtonState extends State<BuzzerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pressAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _pressAnim = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  void _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    return _BuzzerButtonWithIndicator(
      size: size,
      onPressed: _handleTap,
      hideBuzzer: widget.hideBuzzer,
      pressAnim: _pressAnim,
      child: TextWidget(
        title: AppLocalizations.of(context)!.bank.toUpperCase(),
        fontSize: size * 0.26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 2.5,
        shadow: [
          Shadow(
            blurRadius: 8,
            color: Colors.blueAccent.withOpacity(0.7),
            offset: const Offset(0, 2),
          ),
          Shadow(
            blurRadius: 16,
            color: Colors.cyanAccent.withOpacity(0.5),
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}

class TickButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double size;
  const TickButton({
    super.key,
    required this.onPressed,
    this.size = 60,
  });

  @override
  State<TickButton> createState() => _TickButtonState();
}

class _TickButtonState extends State<TickButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pressAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _pressAnim = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  void _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _pressAnim,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _pressAnim.value),
            child: child,
          );
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.6),
                blurRadius: 18,
                spreadRadius: 4,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.3),
                blurRadius: 32,
                spreadRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: size * 0.55,
            ),
          ),
        ),
      ),
    );
  }
}

class XButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double size;
  const XButton({
    super.key,
    required this.onPressed,
    this.size = 60,
  });

  @override
  State<XButton> createState() => _XButtonState();
}

class _XButtonState extends State<XButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pressAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _pressAnim = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  void _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _pressAnim,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _pressAnim.value),
            child: child,
          );
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.6),
                blurRadius: 18,
                spreadRadius: 4,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.3),
                blurRadius: 32,
                spreadRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: size * 0.55,
            ),
          ),
        ),
      ),
    );
  }
}

class _BuzzerButtonWithIndicator extends StatefulWidget {
  final double size;
  final VoidCallback onPressed;
  final VoidCallback hideBuzzer;
  final Animation<double> pressAnim;
  final Widget child;

  const _BuzzerButtonWithIndicator({
    required this.size,
    required this.onPressed,
    required this.pressAnim,
    required this.child,
    required this.hideBuzzer,
  });

  @override
  State<_BuzzerButtonWithIndicator> createState() =>
      _BuzzerButtonWithIndicatorState();
}

class _BuzzerButtonWithIndicatorState extends State<_BuzzerButtonWithIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _indicatorController;
  bool _show = true;

  void _hideAll() {
    setState(() {
      _show = false;
    });
    widget.hideBuzzer();
  }

  @override
  void initState() {
    super.initState();
    _indicatorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..forward();

    _indicatorController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _show = false;
        });
        widget.hideBuzzer();
      }
    });
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    return AnimatedBuilder(
      animation: _indicatorController,
      builder: (context, child) {
        final double progress = 1.0 - _indicatorController.value;
        // Fade and scale out when _show becomes false (after 5s)
        return IgnorePointer(
          ignoring: !_show,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeInBack,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            child: (_show && progress > 0)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Button body
                          Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  blurRadius: 16,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                            child: Center(child: widget.child),
                          ),
                          // Top highlight
                          Positioned(
                            top: size * 0.18,
                            left: size * 0.22,
                            child: Container(
                              width: size * 0.22,
                              height: size * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius:
                                    BorderRadius.circular(size * 0.11),
                              ),
                            ),
                          ),
                          // Progress indicator inside the border
                          SizedBox(
                            width: size,
                            height: size,
                            child: CustomPaint(
                              painter: _InnerCircularProgressPainter(
                                progress: progress,
                                strokeWidth: 5,
                                color: Colors.blue,
                                inset: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          XButton(
                            onPressed: _hideAll,
                            size: size * 0.48,
                          ),
                          SizedBox(width: size * 0.18),
                          TickButton(
                            onPressed: () {
                              if (_show) {
                                widget.onPressed();
                              }
                            },
                            size: size * 0.48,
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

class _InnerCircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final double inset;

  _InnerCircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    this.inset = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = (size.width / 2) - (strokeWidth / 2) - inset;
    final Offset center = size.center(Offset.zero);

    // Draw background arc (faint)
    final Paint bgPaint = Paint()
      ..color = color.withOpacity(0.13)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);

    // Draw progress arc
    final Paint fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double sweep = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweep,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_InnerCircularProgressPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.color != color ||
      oldDelegate.inset != inset;
}
