import 'package:flutter/material.dart';

class MediaQueryHeight {
  double largeImageHeight(BuildContext context, {mobileDefaultWidth = 250}) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1280) return 500;
    if (width >= 1024) return 400;
    if (width >= 720) return 350;
    if (width >= 450) return 300;
    return mobileDefaultWidth;
  }
}
