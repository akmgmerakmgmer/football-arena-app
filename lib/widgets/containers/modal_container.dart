import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModalContainer {
  static modal(BuildContext context, Widget widget, String title) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Colors.black,
              title: TextWidget(
                title: title,
                fontSize: 18,
              ),
              content: SingleChildScrollView(child: widget),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextWidget(
                      title: AppLocalizations.of(ctx)!.close,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ));
  }

  static updateModal(BuildContext context, Widget widget, String title) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => PopScope(
              onPopInvoked: (bool didPop) {},
              child: AlertDialog(
                backgroundColor: Colors.black,
                title: TextWidget(
                  title: title,
                  fontSize: 18,
                ),
                content: SingleChildScrollView(child: widget),
              ),
            ));
  }
}
