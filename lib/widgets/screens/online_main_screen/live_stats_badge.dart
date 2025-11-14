import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class LiveStatsBadge extends StatelessWidget {
  final int? playersOnline;
  final int? matchesStarting;
  final int? friendsPlaying;
  final String locale;
  
  const LiveStatsBadge({
    super.key,
    this.playersOnline,
    this.matchesStarting,
    this.friendsPlaying,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> stats = [];
    
    // Players online
    if (playersOnline != null && playersOnline! > 0) {
      stats.add(_buildStat(
        icon: Icons.circle,
        iconColor: Colors.green,
        value: _formatNumber(playersOnline!),
        label: locale == 'en' ? 'online' : 'متصل',
        pulseAnimation: true,
      ));
    }
    
    // Matches starting
    if (matchesStarting != null && matchesStarting! > 0) {
      stats.add(_buildStat(
        icon: Icons.bolt,
        iconColor: Colors.amber,
        value: matchesStarting.toString(),
        label: locale == 'en' ? 'starting' : 'تبدأ',
        pulseAnimation: false,
      ));
    }
    
    // Friends playing
    if (friendsPlaying != null && friendsPlaying! > 0) {
      stats.add(_buildStat(
        icon: Icons.people,
        iconColor: Colors.blue,
        value: friendsPlaying.toString(),
        label: locale == 'en' ? 'friends' : 'أصدقاء',
        pulseAnimation: false,
      ));
    }
    
    if (stats.isEmpty) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _intersperse(
          stats,
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    bool pulseAnimation = false,
  }) {
    Widget iconWidget = Icon(
      icon,
      color: iconColor,
      size: 14,
    );
    
    if (pulseAnimation) {
      iconWidget = _PulsingIcon(icon: icon, color: iconColor);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget,
        const SizedBox(width: 4),
        TextWidget(
          title: value,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          alwaysEnglish: true,
        ),
        const SizedBox(width: 2),
        TextWidget(
          title: label,
          fontSize: 11,
          color: Colors.white.withOpacity(0.8),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  List<Widget> _intersperse(List<Widget> list, Widget divider) {
    if (list.isEmpty) return list;
    return list
        .expand((item) => [item, divider])
        .toList()
        ..removeLast();
  }
}

class _PulsingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  
  const _PulsingIcon({
    required this.icon,
    required this.color,
  });

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Icon(
          widget.icon,
          color: widget.color.withOpacity(_animation.value),
          size: 14,
        );
      },
    );
  }
}
