import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class PlayerPoints extends StatelessWidget {
  final String points;
  const PlayerPoints({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: NeonBoxShadow().boxShadowNeon(context),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: TextWidget(
        textAlign: TextAlign.center,
        title: points,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        alwaysEnglish: true,
      ),
    );
  }
}
