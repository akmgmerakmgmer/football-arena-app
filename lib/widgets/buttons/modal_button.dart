import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class ModalButton extends StatefulWidget {
  final dynamic action;
  final String title;
  final Color color;
  const ModalButton(
      {super.key, this.action, required this.title, required this.color});

  @override
  State<ModalButton> createState() => _ModalButtonState();
}

class _ModalButtonState extends State<ModalButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        widget.action();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.color,
                widget.color.withOpacity(0.7),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.close_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 18,
              ),
              const SizedBox(width: 6),
              TextWidget(
                title: widget.title,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
