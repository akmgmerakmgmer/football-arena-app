import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class MainButtonNoWidth extends StatefulWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  final double fontSize;
  final double letterSpacing;
  final double radius;
  final bool loading;
  final bool isWidget;
  final dynamic widget;
  final EdgeInsets padding;
  final bool alwaysEnglish;
  const MainButtonNoWidth({
    super.key,
    required this.buttonText,
    required this.action,
    this.uppercase = false,
    this.fontSize = 18,
    this.letterSpacing = 2.0,
    this.radius = 0,
    this.loading = false,
    this.isWidget = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.widget,
    this.alwaysEnglish = false,
  });

  @override
  State<MainButtonNoWidth> createState() => _MainButtonNoWidthState();
}

class _MainButtonNoWidthState extends State<MainButtonNoWidth> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => widget.action(),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              ...NeonBoxShadow().boxShadowNeon(context),
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: widget.padding,
          child: widget.loading
              ? const PrimaryLoading()
              : widget.isWidget
                  ? widget.widget
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        TextWidget(
                          title: widget.uppercase
                              ? widget.buttonText.toUpperCase()
                              : widget.buttonText,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.fontSize,
                          letterSpacing: widget.letterSpacing,
                          alwaysEnglish: widget.alwaysEnglish,
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
