import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class ShopButton extends StatefulWidget {
  final String buttonText;
  final Function action;
  final bool loading;
  final double fontSize;
  final double radius;
  final EdgeInsets padding;
  final Widget? priceWidget;

  const ShopButton({
    super.key,
    required this.buttonText,
    required this.action,
    this.loading = false,
    this.fontSize = 14,
    this.radius = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.priceWidget,
  });

  @override
  State<ShopButton> createState() => _ShopButtonState();
}

class _ShopButtonState extends State<ShopButton> with SingleTickerProviderStateMixin {
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
    if (!widget.loading) {
      _scaleController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.loading) {
      _scaleController.reverse();
    }
  }

  void _onTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.radius);

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
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: NeonBoxShadow().boxShadowNeon(context),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: widget.loading ? null : () => widget.action(),
              splashColor: Colors.white.withOpacity(0.2),
              highlightColor: Colors.white.withOpacity(0.1),
              child: Ink(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: borderRadius,
                ),
                child: Padding(
                  padding: widget.padding,
                  child: widget.loading
                      ? const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: PrimaryLoading(),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(
                              title: widget.buttonText,
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              uppercase: true,
                              textAlign: TextAlign.center,
                            ),
                            if (widget.priceWidget != null) ...[
                              const SizedBox(height: 4),
                              widget.priceWidget!,
                            ],
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
