import 'package:flutter/material.dart';

class HomeSectionContainers extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final double padding;
  const HomeSectionContainers(
      {super.key,
      required this.children,
      this.backgroundColor = const Color(0xFF111111),
      this.padding = 24.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: backgroundColor, width: 4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
