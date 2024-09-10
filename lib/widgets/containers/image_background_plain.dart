import 'package:flutter/material.dart';

class ImageBackgroundPlain extends StatelessWidget {
  final Widget body;
  const ImageBackgroundPlain({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_new.jpg'),
                  fit: BoxFit.cover)),
          child: body),
    );
  }
}
