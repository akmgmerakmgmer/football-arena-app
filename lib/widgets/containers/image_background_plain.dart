import 'package:flutter/material.dart';

class ImageBackgroundPlain extends StatelessWidget {
  final Widget body;
  const ImageBackgroundPlain({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/background_new.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          body
        ],
      ),
    );
  }
}
