import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class SaveExitButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final bool uppercase;
  final double fontSize;
  final double letterSpacing;
  final double radius;
  final bool loading;
  final IconData icon;
  const SaveExitButton({
    super.key,
    required this.buttonText,
    required this.action,
    this.uppercase = false,
    this.fontSize = 14,
    this.letterSpacing = 1.0,
    this.radius = 0,
    this.loading = false, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
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
        padding: const EdgeInsets.all(12.0),
        child: loading
            ? const PrimaryLoading()
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                    title: uppercase ? buttonText.toUpperCase() : buttonText,
                    textAlign: TextAlign.center,
                    fontSize: fontSize,
                    letterSpacing: letterSpacing,
                  ),
                  const SizedBox(width: 5,),
                  Icon(icon,color: Colors.white, size: 20,)
              ],
            ),
      ),
    );
  }
}
