import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class RankNavLinks extends StatelessWidget {
  final Function action;
  final String title;
  final String locale;
  const RankNavLinks(
      {super.key,
      required this.action,
      required this.title,
      required this.locale});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
        padding: EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: locale == 'en' ? 8 : 0,
            right: locale == 'en' ? 0 : 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              title: title,
              fontSize: 12.5,
              fontWeight: locale == 'en' ? FontWeight.w600 : FontWeight.bold,
              uppercase: true,
            ),
            Icon(
              locale == 'en'
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
