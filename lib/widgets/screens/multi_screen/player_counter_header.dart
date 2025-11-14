import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PlayerCounterHeader extends StatefulWidget {
  final int currentPlayers;
  final int totalPlayers;
  final String locale;
  
  const PlayerCounterHeader({
    super.key,
    required this.currentPlayers,
    required this.totalPlayers,
    required this.locale,
  });

  @override
  State<PlayerCounterHeader> createState() => _PlayerCounterHeaderState();
}

class _PlayerCounterHeaderState extends State<PlayerCounterHeader> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 8.0, end: 16.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFull = widget.currentPlayers == widget.totalPlayers;
    final double progress = widget.currentPlayers / widget.totalPlayers;

    return Column(
      children: [
        // Title
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isFull ? _pulseAnimation.value : 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isFull
                        ? [Colors.green.shade600, Colors.teal.shade600]
                        : [Colors.purple.shade600, Colors.blue.shade600],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: (isFull ? Colors.green : Colors.purple).withOpacity(0.5),
                      blurRadius: isFull ? _glowAnimation.value : 8,
                      spreadRadius: isFull ? _glowAnimation.value / 4 : 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isFull ? '🎮' : '⚔️',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 10),
                    TextWidget(
                      title: isFull
                          ? (widget.locale == 'en' ? 'ALL PLAYERS READY!' : 'جميع اللاعبين جاهزون!')
                          : '${widget.totalPlayers}-${widget.locale == 'en' ? 'PLAYER BATTLE' : 'لاعبين'}',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      uppercase: true,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      isFull ? '🎮' : '⚔️',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        // Progress indicator
        Container(
          width: 250,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              // Player count
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('👥', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: '${widget.currentPlayers}/${widget.totalPlayers}',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    alwaysEnglish: true,
                  ),
                  const SizedBox(width: 4),
                  TextWidget(
                    title: widget.locale == 'en' ? 'Players' : 'لاعبين',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(
                          height: 8,
                          width: double.infinity,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          height: 8,
                          width: constraints.maxWidth * progress,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isFull
                                  ? [Colors.green.shade400, Colors.teal.shade400]
                                  : [Colors.purple.shade400, Colors.blue.shade400],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
