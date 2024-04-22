import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';

class SinglePrize extends StatelessWidget {
  final String title;
  final String desc;
  const SinglePrize({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.paid,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 8,
          ),
          TextWidget(
            title: title.toUpperCase(),
            fontSize: 24,
            letterSpacing: 4,
          ),
          const SizedBox(
            height: 8,
          ),
          TextWidget(
            title: desc,
            fontSize: 17,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
