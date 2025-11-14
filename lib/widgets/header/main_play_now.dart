import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/containers/polygon_painter.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class MainPlayNow extends StatefulWidget {
  const MainPlayNow({super.key});

  @override
  State<MainPlayNow> createState() => _MainPlayNowState();
}

class _MainPlayNowState extends State<MainPlayNow> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void playNow(context) {
    if (!GeneralMethods().isUserExists(context)) {
      Navigator.pushNamed(
        context,
        '/signup',
      );
      return;
    }
    Navigator.pushNamed(
      context,
      '/questions',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        playNow(context);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow effect
                  Container(
                    width: 220,
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  
                  // Polygon button
                  CustomPaint(
                    size: const Size(200, 50),
                    painter: PolygonPainter(),
                  ),
                  
                  // Text with icon
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        color: Colors.white,
                        size: 24,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      TextWidget(
                        title: AppLocalizations.of(context)!.playNow,
                        uppercase: true,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
