import 'package:flutter/material.dart';

class ImageManager {
  Future<void> preloadImages(BuildContext context) async {
    List<String> imagePaths = [
      'assets/images/gameOver.png',
      'assets/images/won_arabic.png',
      'assets/images/won_english.png',
      'assets/images/draw_arabic.png',
      'assets/images/draw_english.png',
      'assets/images/lost_arabic.png',
      'assets/images/lost_english.png',
      'assets/images/vs.png',
      'assets/images/video_ad.png',
      'assets/images/page_background_3.jpg'
    ];

    for (String path in imagePaths) {
      await precacheImage(AssetImage(path), context);
    }
  }
}
