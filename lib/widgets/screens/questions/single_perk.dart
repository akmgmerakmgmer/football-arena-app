import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SinglePerk extends StatelessWidget {
  final Function action;
  final String image;
  const SinglePerk({super.key, required this.action, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => action(),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          width: 35,
        ));
  }
}
