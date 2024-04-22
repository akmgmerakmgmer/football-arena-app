import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';

class UserData extends StatelessWidget {
  final String title;
  final int stat;
  const UserData({super.key, required this.title, required this.stat});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(title: title, fontSize: 15),
          const SizedBox(
            height: 5,
          ),
          TextWidget(title: stat.toString(), fontSize: 15)
        ],
      ),
    );
  }
}
