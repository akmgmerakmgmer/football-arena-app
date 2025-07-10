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
  final EdgeInsets padding;
  final bool blueColor;

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
    this.isChallengesPage = false,
    this.offersPage = false,
    this.disabled = false,
    this.padding = const EdgeInsets.all(12.0),
    this.blueColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = offersPage
        ? BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          )
        : BorderRadius.all(Radius.circular(radius));

    final backgroundColor = disabled
        ? Colors.white.withOpacity(0.1)
        : blueColor
            ? Colors.blue
            : Theme.of(context).primaryColor;

    final boxShadow = disabled
        ? null
        : blueColor
            ? NeonBoxShadow().boxShadowBlue(context)
            : NeonBoxShadow().boxShadowNeon(context);

    final childWidget = loading
        ? const PrimaryLoading()
        : isWidget
            ? widget
            : TextWidget(
                title: uppercase ? buttonText.toUpperCase() : buttonText,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                letterSpacing: letterSpacing,
              );

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: disabled || loading ? null : () => action(),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding:
                  isWidget && !loading ? const EdgeInsets.all(8.0) : padding,
              child: childWidget,
            ),
          ),
        ),
      ),
    );
  }
}
