import 'package:flutter/material.dart';

class ImageGlobalBackground extends StatelessWidget {
  final Widget body;
  final EdgeInsets padding;
  const ImageGlobalBackground(
      {super.key, required this.body, this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 64,
        padding: padding,
        decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            image: const DecorationImage(
                image: AssetImage('assets/images/background_2.jpg'),
                fit: BoxFit.cover)),
        child: body);
  }
}
