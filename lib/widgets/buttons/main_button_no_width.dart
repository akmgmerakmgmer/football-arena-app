import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class MainButtonNoWidth extends StatelessWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  final double fontSize;
  final double letterSpacing;
  final double radius;
  final bool loading;
  final bool isWidget;
  final dynamic widget;
  const MainButtonNoWidth({
    super.key,
    required this.buttonText,
    required this.action,
    this.uppercase = false,
    this.fontSize = 18,
    this.letterSpacing = 2.0,
    this.radius = 0,
    this.loading = false,
    this.isWidget = false,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow:  [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: loading
            ? const PrimaryLoading()
            : isWidget
                ? widget
                : TextWidget(
                    title: uppercase ? buttonText.toUpperCase() : buttonText,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    letterSpacing: letterSpacing,
                  ),
      ),
    );
  }
}
