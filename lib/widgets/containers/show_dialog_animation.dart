import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/dialog_widget_blured.dart';

void showAnimatedDialog(BuildContext context, {required String title, required Widget widget, String description = '', dynamic closeCallBack}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 250), // Animation Duration
    pageBuilder: (context, animation, secondaryAnimation) {
      return DialogWidgetBlured(
        title: title,
        widget: widget,
        description: description,
        closeCallBack: closeCallBack,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: child,
        ),
      );
    },
  );
}
