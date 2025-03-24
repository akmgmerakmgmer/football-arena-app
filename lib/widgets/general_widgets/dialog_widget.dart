import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget widget;
  const DialogWidget(
      {super.key,
      required this.title,
      required this.widget,
      this.description = ''});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ), 
      title: TextWidget(
        title: title,
        fontSize: 18,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          description.isNotEmpty
              ? TextWidget(
                  title: description,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                )
              : Container(),
          description.isNotEmpty
              ? const SizedBox(
                  height: 16,
                )
              : Container(),
          widget
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: TextWidget(
              title: AppLocalizations.of(context)!.close,
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
