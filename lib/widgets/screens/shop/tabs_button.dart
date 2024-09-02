import 'package:flutter/material.dart';
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
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 8 ,horizontal: 24),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorDark,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child:
            TextWidget(title: title, fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}
