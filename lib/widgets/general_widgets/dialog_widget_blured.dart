import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/buttons/modal_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class DialogWidgetBlured extends StatefulWidget {
  final String title;
  final String description;
  final Widget widget;
  final dynamic closeCallBack;
  final dynamic action;
  final bool loading;
  const DialogWidgetBlured(
      {super.key,
      required this.title,
      required this.widget,
      this.description = '',
      this.closeCallBack,
      this.action,
      this.loading = false});

  @override
  State<DialogWidgetBlured> createState() => _DialogWidgetBluredState();
}

class _DialogWidgetBluredState extends State<DialogWidgetBlured>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 8.0, end: 16.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: AlertDialog(
              backgroundColor:
                  Colors.transparent, // Make the dialog background transparent
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ), // Rounded corners
              contentPadding: EdgeInsets.zero, // Remove default padding
              content: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Apply rounded corners to blur
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Apply blur
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1a237e).withOpacity(0.3),
                          const Color(0xFF0d47a1).withOpacity(0.2),
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 2,
                        color: Colors.cyan.withOpacity(0.4),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.3),
                          blurRadius: _glowAnimation.value,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: _glowAnimation.value * 1.5,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Enhanced Header with Icon
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.cyan.withOpacity(0.2),
                                  Colors.blue.withOpacity(0.15),
                                ],
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.cyan.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.cyan.withOpacity(0.4),
                                        Colors.blue.withOpacity(0.4),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Colors.cyan,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: TextWidget(
                                    title: widget.title,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    uppercase: false,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Content
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.description.isNotEmpty) ...[
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.cyan.withOpacity(0.2),
                                      ),
                                    ),
                                    child: TextWidget(
                                      title: widget.description,
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                                widget.widget,
                              ],
                            ),
                          ),

                          // Enhanced Button Container
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.2),
                                ],
                              ),
                              border: Border(
                                top: BorderSide(
                                  color: Colors.cyan.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (widget.action != null) ...[
                                  MainButtonNoWidth(
                                    buttonText:
                                        AppLocalizations.of(context)!.choose,
                                    action: () {
                                      widget.action();
                                    },
                                    fontSize: 14,
                                    radius: 10,
                                    letterSpacing: 1.1,
                                    loading: widget.loading,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                ModalButton(
                                  title: AppLocalizations.of(context)!.close,
                                  color: Colors.white.withOpacity(0.1),
                                  action: () {
                                    Navigator.pop(context);
                                    if (widget.closeCallBack != null) {
                                      widget.closeCallBack();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
