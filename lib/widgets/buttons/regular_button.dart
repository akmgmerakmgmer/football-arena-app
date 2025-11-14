import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class RegularButton extends StatefulWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  final double fontSize;
  final bool enableFeedback;
  const RegularButton(
      {super.key,
      required this.buttonText,
      required this.action,
      this.uppercase = false,
      this.fontSize = 18,
      this.enableFeedback = true});

  @override
  State<RegularButton> createState() => _RegularButtonState();
}

class _RegularButtonState extends State<RegularButton> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _scaleController.reverse();
    if (widget.enableFeedback) {
      Feedback.forTap(context);
    }
    widget.action();
  }

  void _onTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20, // Equivalent to backdrop-blur-md
              spreadRadius: 2, // Optional
              offset: const Offset(0, 3), // Optional
            ),
          ],
        ),
          padding: const EdgeInsets.all(12.0),
          child: TextWidget(
            title: widget.uppercase ? widget.buttonText.toUpperCase() : widget.buttonText,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            fontSize: widget.fontSize,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
