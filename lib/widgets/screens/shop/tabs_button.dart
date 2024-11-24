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
        width: MediaQuery.of(context).size.width * 0.4,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorDark,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child:
            TextWidget(title: title, fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}
