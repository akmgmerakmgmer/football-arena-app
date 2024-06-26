import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  final double fontSize;
  final double letterSpacing;
  final double radius;
  final bool loading;
  final bool isWidget;
  final dynamic widget;
  const MainButton({
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
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFDC2626),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color(0xFFDC2626),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color(0xFFDC2626),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        padding: isWidget && !loading
            ? const EdgeInsets.all(8.0)
            : const EdgeInsets.all(12.0),
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
