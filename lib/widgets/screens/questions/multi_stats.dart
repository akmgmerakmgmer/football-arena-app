import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class MultiStats extends StatelessWidget {
  final String image;
  final String points;
  const MultiStats({super.key, required this.image, required this.points});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(50, 0),
          child: Container(
            width: 75,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
            child: TextWidget(
              title: points,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              alwaysEnglish: true,
              number: true,
              color: Colors.black,
              textAlign: TextAlign.end,
            ),
          ),
        ),
        UserImage(image: image),
      ],
    );
  }
}
