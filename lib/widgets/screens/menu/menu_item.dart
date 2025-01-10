import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final double textSize;
  final double iconSize;
  final double bottomPadding;
  final Function action;
  final bool selected;
  final bool isTitle;
  final bool hideDivider;
  const MenuItem(
      {super.key,
      required this.text,
      required this.icon,
      this.textSize = 15,
      this.iconSize = 24,
      this.bottomPadding = 12,
      required this.action,
      this.selected = false,
      this.isTitle = false,
      this.hideDivider = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: 8, bottom: isTitle ? 0 : 8, left: selected ? 16 : 0),
          padding:
              Provider.of<LocaleProvider>(context, listen: false).locale == 'en'
                  ? EdgeInsets.only(left: 16, top: 5, bottom: isTitle ? 0 : 5)
                  : EdgeInsets.only(right: 16, top: 5, bottom: isTitle ? 0 : 5),
          decoration: BoxDecoration(
              color: selected ? Colors.white : Colors.transparent,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(100))),
          child: GestureDetector(
            child: Row(
              children: [
                Icon(
                  icon,
                  color: selected ? Colors.black : Colors.white,
                  size: iconSize,
                ),
                const SizedBox(
                  width: 16,
                ),
                TextWidget(
                  title: text,
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.black : Colors.white,
                ),
              ],
            ),
            onTap: () {
              action();
            },
          ),
        ),
        hideDivider
            ? Container()
            : Divider(
                color: Colors.grey.shade700,
              )
      ],
    );
  }
}
