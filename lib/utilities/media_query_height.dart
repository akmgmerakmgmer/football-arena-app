import 'package:flutter/material.dart';

class MediaQueryHeight {
  double largeImageHeight(BuildContext context, {mobileDefaultWidth = 250.00}) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1280) return 500.00;
    if (width >= 1024) return 400.00;
    if (width >= 720) return 350.00;
    if (width >= 450) return 300.00;
    return mobileDefaultWidth;
  }
  double avatarImageHeight(BuildContext context, {mobileDefaultWidth = 300.00}) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1280) return 550.00;
    if (width >= 1024) return 500.00;
    if (width >= 720) return 400.00;
    if (width >= 450) return 350.00;
    return mobileDefaultWidth;
  }
}
