import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';

class PrimaryColorBackground extends StatelessWidget {
  final Widget widget;
  final double padding;
  const PrimaryColorBackground(
      {super.key, required this.widget, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Theme.of(context).primaryColor,
          boxShadow: NeonBoxShadow().boxShadowNeon(context)
        ),
        child: widget);
  }
}
