import 'package:flutter/material.dart';

class NeonContainer extends StatelessWidget {
  final Widget widget;
  final EdgeInsetsGeometry padding;
  final double width;
  const NeonContainer(
      {super.key,
      required this.widget,
      required this.padding,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
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
      child: widget,
    );
  }
}
