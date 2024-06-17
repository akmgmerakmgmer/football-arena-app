import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final double textSize;
  final double iconSize;
  final double bottomPadding;
  final Function action;
  final bool selected;
  final bool isTitle;
  const DrawerItem(
      {super.key,
      required this.text,
      required this.icon,
      this.textSize = 15,
      this.iconSize = 24,
      this.bottomPadding = 12,
      required this.action,
      this.selected = false,
      this.isTitle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 5, bottom: isTitle ? 0 : 12, left: selected ? 16 : 0),
      padding:
          Provider.of<LocaleProvider>(context, listen: false).locale == 'en'
              ? EdgeInsets.only(left: 16, top: 5, bottom: isTitle ? 0 : 5)
              : EdgeInsets.only(right: 16, top: 5, bottom: isTitle ? 0 : 5),
      decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100), bottomLeft: Radius.circular(100))),
      child: ListTile(
        onTap: () {
          action();
        },
        contentPadding: const EdgeInsets.all(0),
        horizontalTitleGap: 8,
        leading: Icon(
          icon,
          color: selected ? Colors.black : Colors.white,
          size: iconSize,
        ),
        title: TextWidget(
          title: text,
          fontSize: textSize,
          fontWeight: FontWeight.bold,
          color: selected ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
