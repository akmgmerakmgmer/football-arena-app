import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class TabsButton extends StatelessWidget {
  final bool selected;
  final String title;
  final Function action;
  const TabsButton(
      {super.key,
      this.selected = false,
      required this.title,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.25,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
            boxShadow: selected
                ? NeonBoxShadow().boxShadowNeon(context)
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child:
            TextWidget(title: title, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
