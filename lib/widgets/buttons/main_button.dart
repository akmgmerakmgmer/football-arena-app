import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
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
  final bool isChallengesPage;
  final bool offersPage;
  final bool disabled;
  const MainButton(
      {super.key,
      required this.buttonText,
      required this.action,
      this.uppercase = false,
      this.fontSize = 18,
      this.letterSpacing = 2.0,
      this.radius = 0,
      this.loading = false,
      this.isWidget = false,
      this.widget,
      this.isChallengesPage = false,
      this.offersPage = false,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: disabled
                ? Colors.white.withOpacity(0.1)
                : Theme.of(context).primaryColor,
            borderRadius: offersPage
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius))
                : BorderRadius.all(Radius.circular(radius)),
            boxShadow: disabled ? null : NeonBoxShadow().boxShadowNeon(context)),
        padding: isChallengesPage
            ? const EdgeInsets.all(10.0)
            : isWidget && !loading
                ? const EdgeInsets.all(8.0)
                : const EdgeInsets.all(12.0),
        child: loading
            ? const PrimaryLoading()
            : isWidget
                ? widget
                : TextWidget(
                    title: uppercase ? buttonText.toUpperCase() : buttonText,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                    letterSpacing: letterSpacing,
                  ),
      ),
    );
  }
}
