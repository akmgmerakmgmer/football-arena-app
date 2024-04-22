import 'package:flutter/material.dart';

class ImageBackgroundPlain extends StatelessWidget {
  final Widget body;
  final double height;
  const ImageBackgroundPlain(
      {super.key, required this.body, this.height = 280});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/main_background.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            body
          ],
        ),
      ),
    );
  }
}
