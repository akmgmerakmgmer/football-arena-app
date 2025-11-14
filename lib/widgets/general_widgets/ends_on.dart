import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/white_glass_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class AnimatedEndsOn extends StatefulWidget {
  final String? endDate;
  const AnimatedEndsOn({super.key, required this.endDate});

  @override
  State<AnimatedEndsOn> createState() => _AnimatedEndsOnState();
}

class _AnimatedEndsOnState extends State<AnimatedEndsOn> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startToggling();
  }

  @override
  void didUpdateWidget(covariant AnimatedEndsOn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endDate != widget.endDate) {
      _resetToggling();
    }
  }

  void _startToggling() {
    if (widget.endDate != null && widget.endDate!.isNotEmpty) {
      _visible = true;
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (mounted) {
          setState(() {
            _visible = !_visible;
          });
        }
      });
    }
  }

  void _resetToggling() {
    _timer?.cancel();
    _startToggling();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldShow = _visible && widget.endDate != null && widget.endDate!.isNotEmpty;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.2),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: shouldShow
          ? EndsOn(
              key: const ValueKey('endsOn'),
              endDate: widget.endDate!,
            )
          : const SizedBox(key: ValueKey('empty')),
    );
  }
}

class EndsOn extends StatelessWidget {
  final String endDate;
  const EndsOn({super.key, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return WhiteGlassBackground(
      darkenBackground: true,
      radius: 4,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            title: AppLocalizations.of(context)!.ends_on,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(width: 4),
          TextWidget(
            title: endDate,
            alwaysEnglish: true,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
