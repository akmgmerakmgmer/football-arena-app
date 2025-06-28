import 'package:flutter/material.dart';

class PagesAssetBackground extends StatelessWidget {
  final Widget child;
  final String background;
  final EdgeInsets padding;
  const PagesAssetBackground(
      {super.key,
      required this.child,
      this.background = 'assets/images/page_background_3.jpg',
      this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background), // or NetworkImage for online image
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
