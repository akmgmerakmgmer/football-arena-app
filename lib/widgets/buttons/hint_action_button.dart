import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/primary_color_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class HintActionButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final bool disabled;
  const HintActionButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.disabled});

  @override
  Widget build(BuildContext context) {
    return disabled
        ? BlurBackgroundContainer(
          border: 6,
            body: Row(
              children: [
                TextWidget(
                  title: title,
                  fontSize: 13,
                ),
                icon
              ],
            ),
            padding: 6,
          )
        : PrimaryColorBackground(
            widget: Row(
              children: [
                TextWidget(
                  title: title,
                  fontSize: 13,
                ),
                icon
              ],
            ),
            padding: 6,
          );
  }
}
