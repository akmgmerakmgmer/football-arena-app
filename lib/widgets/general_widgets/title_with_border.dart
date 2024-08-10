import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class TitleWithBorder extends StatelessWidget {
  final String title;
  const TitleWithBorder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          Provider.of<LocaleProvider>(context, listen: false).locale == 'en'
              ? Alignment.topLeft
              : Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
              color: Theme.of(context)
                  .primaryColor, // You can specify your desired color here
              width: 6 // You can adjust the width of the border
              ),
        )),
        child: TextWidget(
          title: title,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
