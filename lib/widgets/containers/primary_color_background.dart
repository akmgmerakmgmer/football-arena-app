import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';

class PrimaryColorBackground extends StatelessWidget {
  final Widget widget;
  final double padding;
  final double radius;
  const PrimaryColorBackground(
      {super.key,
      required this.widget,
      required this.padding,
      this.radius = 6});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: Theme.of(context).primaryColor,
            boxShadow: NeonBoxShadow().boxShadowNeon(context)),
        child: widget);
  }
}
