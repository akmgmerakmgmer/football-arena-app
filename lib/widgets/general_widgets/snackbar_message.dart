import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SnackbarMessage {
  void snackbar(context, title, {color = Colors.green, label = '', action}) {
    dynamic snackdemo = SnackBar(
      padding: const EdgeInsets.all(16),
      content: Column(
        children: [
          TextWidget(
            title: title,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14.5,
          ),
          label != ''
              ? GestureDetector(
                  onTap: action,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread radius (like blur spread)
                          blurRadius: 6, // Blur radius for soft edges
                          offset: const Offset(
                              0, 3), // Horizontal and vertical offset
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(top: 8),
                    width: MediaQuery.of(context).size.width,
                    child: TextWidget(
                      title: label,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                )
              : Container()
        ],
      ),
      backgroundColor: color,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 70),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }
}
