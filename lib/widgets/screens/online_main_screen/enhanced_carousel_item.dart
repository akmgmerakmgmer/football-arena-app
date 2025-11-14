import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/media_query_height.dart';

class EnhancedCarouselItem extends StatefulWidget {
  final int allDataLength;
  final Map item;
  final Widget body;
  final bool isPopular;
  final bool showGlow;
  
  const EnhancedCarouselItem({
    super.key,
    required this.allDataLength,
    required this.item,
    required this.body,
    this.isPopular = false,
    this.showGlow = false,
  });

  @override
  State<EnhancedCarouselItem> createState() => _EnhancedCarouselItemState();
}

class _EnhancedCarouselItemState extends State<EnhancedCarouselItem>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    if (widget.showGlow) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.item['action']();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Row(
          children: [
            AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) {
                return Container(
                  decoration: widget.showGlow
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3 * _glowAnimation.value),
                              blurRadius: 20 * _glowAnimation.value,
                              spreadRadius: 5 * _glowAnimation.value,
                            ),
                            BoxShadow(
                              color: Colors.orange
                                  .withOpacity(0.2 * _glowAnimation.value),
                              blurRadius: 30 * _glowAnimation.value,
                              spreadRadius: 3 * _glowAnimation.value,
                            ),
                          ],
                        )
                      : null,
                  child: Container(
                    decoration: widget.isPopular
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.amber.withOpacity(0.8),
                              width: 2,
                            ),
                          )
                        : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: MediaQueryHeight().largeImageHeight(context),
                        width: widget.allDataLength == 1
                            ? MediaQuery.of(context).size.width - 24
                            : MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.item['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Gradient overlay for better text readability
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Content
                            widget.body,
                            // Popular badge
                            if (widget.isPopular)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.amber.withOpacity(0.9),
                                      Colors.orange.withOpacity(0.9),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber.withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.local_fire_department,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'HOT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Press feedback indicator
                            if (_isPressed)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
