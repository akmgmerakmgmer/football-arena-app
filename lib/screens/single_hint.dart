import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/primary_color_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';

class SingleHint extends StatelessWidget {
  final String hint;
  const SingleHint({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
      body: Column(
        children: [
          PrimaryColorBackground(
              widget: TextWidget(
                title: hint,
                fontSize: 14,
              ),
              padding: 8),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
