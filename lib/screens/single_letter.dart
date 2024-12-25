import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/primary_color_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SingleLetter extends StatelessWidget {
  final Map letter;
  final Function action;
  final bool isChosen;
  const SingleLetter(
      {super.key,
      required this.letter,
      required this.action,
      this.isChosen = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => action(letter),
          child: isChosen
              ? BlurBackgroundContainer(
                darkenBackground: true,
                  border: 6,
                  body: TextWidget(
                    title: letter['letter'],
                    fontSize: 18,
                  ),
                  padding: 8)
              : PrimaryColorBackground(
                  widget: TextWidget(
                    title: letter['letter'],
                    fontSize: 18,
                  ),
                  padding: 8),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
