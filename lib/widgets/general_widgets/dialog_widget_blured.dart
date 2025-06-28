import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/buttons/modal_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogWidgetBlured extends StatelessWidget {
  final String title;
  final String description;
  final Widget widget;
  final dynamic closeCallBack;
  final dynamic action;
  final bool loading;
  const DialogWidgetBlured(
      {super.key,
      required this.title,
      required this.widget,
      this.description = '',
      this.closeCallBack,
      this.action,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Make the dialog background transparent
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ), // Rounded corners
      contentPadding: EdgeInsets.zero, // Remove default padding
      content: ClipRRect(
        borderRadius:
            BorderRadius.circular(15), // Apply rounded corners to blur
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Apply blur
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05), // Semi-transparent overlay
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWidget(
                          title: title,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          uppercase: false,
                        ),
                        const SizedBox(height: 16),
                        if (description.isNotEmpty)
                          TextWidget(
                            title: description,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        if (description.isNotEmpty) const SizedBox(height: 16),
                        widget,
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        action != null
                            ? MainButtonNoWidth(
                                buttonText:
                                    AppLocalizations.of(context)!.choose,
                                action: () {
                                  action();
                                },
                                fontSize: 14,
                                radius: 10,
                                letterSpacing: 1.1,
                                loading: loading,
                              )
                            : Container(),
                        const SizedBox(width: 8),
                        ModalButton(
                          title: AppLocalizations.of(context)!.close,
                          color: Colors.white.withOpacity(0.1),
                          action: () {
                            Navigator.pop(context);
                            if (closeCallBack != null) {
                              closeCallBack();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
