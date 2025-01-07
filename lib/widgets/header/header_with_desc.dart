import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';

class HeaderWithDesc extends StatelessWidget {
  final String title;
  final String desc;
  const HeaderWithDesc({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithBorder(
          title: title,
        ),
        const SizedBox(
          height: 8,
        ),
        TextWidget(
          title: desc,
          color: Colors.grey.shade300,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }
}
