import 'package:flutter/material.dart';

class NeonContainer extends StatelessWidget {
  final Widget widget;
  final EdgeInsetsGeometry padding;
  final double? width;
  const NeonContainer(
      {super.key, required this.widget, required this.padding, this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow:  [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: widget,
      ),
    );
  }
}
