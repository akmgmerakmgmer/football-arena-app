import 'package:flutter/material.dart';

class PrimaryColorBackground extends StatelessWidget {
  final Widget widget;
  final double padding;
  const PrimaryColorBackground(
      {super.key, required this.widget, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Theme.of(context).primaryColor,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFDC2626),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color(0xFFDC2626),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color(0xFFDC2626),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: widget);
  }
}
