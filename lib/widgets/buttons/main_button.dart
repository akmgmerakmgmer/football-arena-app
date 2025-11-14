import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class MainButton extends StatefulWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  final double fontSize;
  final double letterSpacing;
  final double radius;
  final bool loading;
  final bool isWidget;
  final dynamic widget;
  final bool isChallengesPage;
  final bool offersPage;
  final bool disabled;
  final EdgeInsets padding;
  final bool blueColor;
  final bool enableFeedback;

  const MainButton({
    super.key,
    required this.buttonText,
    required this.action,
    this.uppercase = false,
    this.fontSize = 18,
    this.letterSpacing = 2.0,
    this.radius = 0,
    this.loading = false,
    this.isWidget = false,
    this.widget,
    this.isChallengesPage = false,
    this.offersPage = false,
    this.disabled = false,
    this.padding = const EdgeInsets.all(12.0),
    this.blueColor = false,
    this.enableFeedback = true,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> with SingleTickerProviderStateMixin {
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
    if (!widget.disabled && !widget.loading) {
      _scaleController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.disabled && !widget.loading) {
      _scaleController.reverse();
    }
  }

  void _onTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.offersPage
        ? BorderRadius.only(
            bottomLeft: Radius.circular(widget.radius),
            bottomRight: Radius.circular(widget.radius),
          )
        : BorderRadius.all(Radius.circular(widget.radius));

    final backgroundColor = widget.disabled
        ? Colors.white.withOpacity(0.1)
        : widget.blueColor
            ? Colors.blue
            : Theme.of(context).primaryColor;

    final boxShadow = widget.disabled
        ? null
        : widget.blueColor
            ? NeonBoxShadow().boxShadowBlue(context)
            : NeonBoxShadow().boxShadowNeon(context);

    final childWidget = widget.loading
        ? const PrimaryLoading()
        : widget.isWidget
            ? widget.widget
            : TextWidget(
                title: widget.uppercase ? widget.buttonText.toUpperCase() : widget.buttonText,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: widget.fontSize,
                letterSpacing: widget.letterSpacing,
              );

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
            borderRadius: borderRadius,
            boxShadow: boxShadow,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: widget.disabled || widget.loading ? null : () => widget.action(),
              splashColor: Colors.white.withOpacity(0.2),
              highlightColor: Colors.white.withOpacity(0.1),
              enableFeedback: widget.enableFeedback,
              child: Ink(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: borderRadius,
                ),
                child: Padding(
                  padding:
                      widget.isWidget && !widget.loading ? const EdgeInsets.all(8.0) : widget.padding,
                  child: childWidget,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
