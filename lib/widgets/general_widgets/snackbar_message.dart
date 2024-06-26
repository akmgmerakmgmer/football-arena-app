import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SnackbarMessage {
  void snackbar(context, title, {color = Colors.green}) {
    dynamic snackdemo = SnackBar(
      content: TextWidget(
        title: title,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14.5,
      ),
      backgroundColor: color,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }
}
