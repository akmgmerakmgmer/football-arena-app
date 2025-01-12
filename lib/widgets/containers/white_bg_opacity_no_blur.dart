import 'package:flutter/material.dart';

class WhiteBgOpacityNoBlur extends StatelessWidget {
  final Widget widget;
  final EdgeInsets padding;
  const WhiteBgOpacityNoBlur({super.key, required this.widget, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1)),
        child: widget);
  }
}
